#include <cmath>
#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <algorithm>

#include "dfrt_v1.h"


#if (defined(_MSVC_LANG) && (_MSVC_LANG >= 201803L)) || __cplusplus >= 201803L
    #define IF_LIKELY(x)         if(x)       [[likely]]
    #define IF_UNLIKELY(x)       if(x)       [[unlikely]]
#elif defined(__GNUC__) || defined(__INTEL_COMPILER) || defined(__clang__)
    #define IF_LIKELY(x)         if(__builtin_expect(x, 1))
    #define IF_UNLIKELY(x)       if(__builtin_expect(x, 0))
#else
    #define IF_LIKELY(x)         if(x)
    #define IF_UNLIKELY(x)       if(x)
#endif


namespace
{

struct LineOverlapCollector
{
    const static uint32_t tombstone = 0xffffffffu;
    const static uint32_t emptyLinesId = (1u << 24) - 1u;

    struct LineGroup
    {

        uint32_t    hash;
        uint32_t    numLines;
        uint32_t    offset;     /* Offset that the line ids start inside the
                                 * global line ids buffer.
                                 *
                                 * When numLines == 1, it stores the single
                                 */

        uint32_t    llindex;    /* Index of the next LineGroup within the same
                                 * bucket.
                                 *
                                 * When used as part of the cache, it refers
                                 * to the original index.
                                 */
    };


    LineGroup cache;        /* Cached entry of the last added / fetched
                             * group, with the expectation being that it's
                             * very common for nearby pixels to share the
                             * group.
                             */

    uint32_t  lineIdsSize;
    uint32_t  lineIdsCap;
    uint32_t* lineIds;      /* Global buffer used to store unique sequences of
                             * line ids.
                             */

    uint32_t   lineGroupsSize;
    uint32_t   lineGroupsCap;
    LineGroup* lineGroups;  /* Global buffer used to store unique line
                             * groups.
                             */

    uint32_t* buckets;      /* Buckets of linked list LineGroups, storing the
                             * index of the first element (or a tombstone).
                             * Never grows and is fixed to the number of lines
                             * rounded to the next power of 2.
                             */

    uint32_t bucketsMask;   /* Mask used against the hash of a group of
                             * lines (numBuckets - 1)
                             */

    uint32_t numOneLineIds; /* Counter for how many sigle line groups there
                             * are
                             */

    /* FNV1a variant with the following tweaks:
     *
     * 1. Reading a dword rather than a byte per iteration.
     *
     * 2. Shifting the existing hash by 1 bit per iteration, this makes the
     *    buckets that get picked a lot more balanced.
     *
     * 3. The prime number has been swapped to use floor(1/goldenratio * 2^64).
     *
     *    We use the lower 32bits to determine a bucket and the upper 32bits
     *    for the persistent hash.
     *
     *    The original value would only really affect the upper bits when
     *    the size changes, which we already compare against seperately.
     */
    static uint64_t hashLines(const uint32_t* lines, uint32_t numLines)
    {
        const uint64_t p = 0x9e3779b97f4a7c15LLU;
        uint64_t h = 0xcbf29ce484222325LLU;
        for(uint32_t i=0; i<numLines; ++i)
        {
            uint64_t x = (uint64_t)lines[i];
            h = ((h >> 1) ^ x) * p;
        }
        return h;
    }

    /* Test if a line group matches some input lines. */
    bool matches(LineGroup key,
                 uint32_t hash,
                 const uint32_t* lines,
                 uint32_t numLines) const
    {
        if(hash == key.hash && numLines == key.numLines)
        {
            if(numLines == 1)
            {
                return key.offset == lines[0];
            }

            bool result = memcmp(&lineIds[key.offset],
                                 lines,
                                 sizeof(uint32_t)*numLines) == 0;

            return result;
        }
        return false;
    }

    /* Add a group of lines or find an already existing line group that matches
     * and return back the logical id for it.
     */
    uint32_t add(const uint32_t* lines, uint32_t numLines)
    {
        if(numLines == 0)
        {
            return emptyLinesId;
        }

        uint64_t hashed = hashLines(lines, numLines);

        // Upper 32bits are used for the hash
        // Lower 32bits are used for the bucket id;
        uint32_t hash = (uint32_t)(hashed >> 32);
        uint32_t bucketId = hashed & bucketsMask;

        // First, probe the cache.
        if(matches(cache, hash, lines, numLines))
        {
            return cache.llindex;
        }

        // Next probe the corresponding bucket
        uint32_t lineGroupId = buckets[bucketId];
        while(lineGroupId != tombstone)
        {
            LineGroup key = lineGroups[lineGroupId];
            if(matches(key, hash, lines, numLines))
            {
                cache = key;
                cache.llindex = lineGroupId;
                return lineGroupId;
            }
            lineGroupId = key.llindex;
        }

        // Allocate a new entry, resizing the lineGroup buffer, if needed.
        lineGroupId = lineGroupsSize++;
        IF_UNLIKELY(lineGroupsSize > lineGroupsCap)
        {
            lineGroupsCap += (lineGroupsCap >> 1);
            lineGroups = (LineGroup*)realloc(lineGroups,
                                             sizeof(LineGroup) * lineGroupsCap);
            if(!lineGroups)
            {
                return tombstone;
            }
        }

        // Allocate new line ids, resizing the lineIds buffer, if needed.
        uint32_t offset;
        if(numLines == 1)
        {
            offset = lines[0];
            ++numOneLineIds;
        }
        else
        {
            offset = lineIdsSize;
            lineIdsSize += numLines;
            IF_UNLIKELY(lineIdsSize > lineIdsCap)
            {
                lineIdsCap += (lineIdsCap >> 1) + numLines;
                lineIds = (uint32_t*)realloc(lineIds,
                                             sizeof(uint32_t) * lineIdsCap);
                if(!lineIds)
                {
                    return tombstone;
                }
            }
            memcpy(lineIds + offset, lines, sizeof(uint32_t) * numLines);
        }

        LineGroup newLineGroup;
        newLineGroup.hash = hash;
        newLineGroup.numLines = numLines;
        newLineGroup.offset = offset;
        newLineGroup.llindex = buckets[bucketId];

        lineGroups[lineGroupId] = newLineGroup;
        buckets[bucketId] = lineGroupId;

        cache = newLineGroup;
        cache.llindex = lineGroupId;

        return lineGroupId;
    }

    /* Destructively compact the lineId buffer, with the line groups
     * now reflecting their new place.
     * Adding will no longer work and lines with a length of one will have
     * a real offset.
     */
    bool compact()
    {
        cache = {0,0,0,0};

        // Allocating for the worst case scenario, but realistically
        // this shouldn't typically need to be this big.
        uint32_t* compactLineIds = (uint32_t*)malloc(sizeof(uint32_t)
                                                     * (lineIdsSize
                                                        + numOneLineIds));

        uint32_t* sortableGroupIds = (uint32_t*)malloc(sizeof(uint32_t)
                                                       * lineGroupsSize);

        IF_UNLIKELY(!compactLineIds || !sortableGroupIds)
        {
            free(compactLineIds);
            free(sortableGroupIds);
            return false;
        }

        for(uint32_t i=0; i<lineGroupsSize; ++i)
        {
            sortableGroupIds[i] = i;
        }

        // We write elements in descending order of size, looking for if our
        // sequence was already written by something previously.
        std::sort(sortableGroupIds,
                  sortableGroupIds + lineGroupsSize,
                  [&](uint32_t A, uint32_t B)
                  {
                      return lineGroups[A].numLines > lineGroups[B].numLines;
                  });


        uint32_t compactLineIdsSize = 0;
        for(uint32_t i=0; i<lineGroupsSize; ++i)
        {
            LineGroup& lineGroup = lineGroups[sortableGroupIds[i]];
            uint32_t found = tombstone;
            uint32_t* needle = &lineIds[lineGroup.offset];
            uint32_t needleNumLines = lineGroup.numLines;
            uint32_t needleBytes = needleNumLines * sizeof(uint32_t);
            if(needleNumLines == 1)
            {
                needle = &lineGroup.offset;
            }

            // naive search, considered swapping this for robin-karp
            // but that just seemed to be slower.
            if(compactLineIdsSize > needleNumLines)
            {
                uint32_t n = compactLineIdsSize - needleNumLines;
                for(uint32_t j=0; j<=n; ++j)
                {
                    bool matched = memcmp(needle,
                                          compactLineIds + j,
                                          needleBytes) == 0;
                    if(matched)
                    {
                        found = j;
                        break;
                    }
                }
            }

            // need to allocate.
            if(found == tombstone)
            {
                found = compactLineIdsSize;
                compactLineIdsSize += needleNumLines;
                memcpy(compactLineIds + found, needle, needleBytes);
            }

            lineGroup.offset = found;
        }

        free(sortableGroupIds);
        free(lineIds);
        lineIdsCap = lineIdsSize;
        lineIdsSize = compactLineIdsSize;
        lineIds = compactLineIds;

        return true;
    }

    LineGroup getLineGroup(uint32_t index) const
    {
        if(index == emptyLinesId)
        {
            LineGroup emptyLg{};
            emptyLg.numLines = 0;
            emptyLg.offset = 0;
            return emptyLg;
        }

        return lineGroups[index];
    }

    bool initOk() const
    {
        return buckets && lineGroups && lineIds;
    }

    LineOverlapCollector(uint32_t numLines)
    : cache({0, 0, 0, 0})
    , numOneLineIds(0)
    {
        uint32_t numBuckets = numLines-1;
                 numBuckets |= (numBuckets >> 1);
                 numBuckets |= (numBuckets >> 2);
                 numBuckets |= (numBuckets >> 4);
                 numBuckets |= (numBuckets >> 8);
                 numBuckets |= (numBuckets >> 16);
                 ++numBuckets;

        // Force a minimum of 8 buckets, incase for
        // whatever reason numLines is 0.
        IF_UNLIKELY(numBuckets < 8)
        {
            numBuckets = 8;
        }

        // init buckets to all have tombstone values.
        bucketsMask = numBuckets - 1;
        buckets = (uint32_t*)malloc(numBuckets * sizeof(uint32_t));
        memset(buckets, 0xff, sizeof(uint32_t) * numBuckets);

        // init line groups buffer to have an initial size of numBuckets.
        lineGroupsSize = 0;
        lineGroupsCap = numBuckets;
        lineGroups = (LineGroup*)malloc(lineGroupsCap * sizeof(LineGroup));

        // init line ids buffer to have an initial size of numBuckets * 2.
        lineIdsSize = 0;
        lineIdsCap = numBuckets * 2;
        lineIds = (uint32_t*)malloc(lineIdsCap * sizeof(uint32_t));
    }


    ~LineOverlapCollector()
    {
        free(buckets);
        free(lineGroups);
        free(lineIds);
    }

};


DFRT_V1_FORCEINLINE float dot(float2 a, float2 b)
{
    return (a.x * b.x) + (a.y * b.y);
}


/* Evalute a pixel, writing out the index of lines that should
 * be intersected against and returns the distance field value
 * that should be stored.
 */
DFRT_V1_FORCEINLINE uint32_t evalPixel(float2 uv,
                                       float captureSpanSq,
                                       float invResolution,
                                       const float4* preparedLines,
                                       uint32_t numLines,
                                       uint32_t* outCapturedLines,
                                       uint32_t* outNumCapturedLines)
{
    float dfSq = 1.0f;
    uint32_t numCaptured = 0u;

    for(uint32_t i=0; i<numLines; ++i)
    {
        float4 lineData = preparedLines[i];
        float2 A = { lineData.x - uv.x, lineData.y - uv.y };
        float2 AB = { lineData.z, lineData.w };

        float t = dot(A, AB) / dot(AB, AB);
        t = (t < 0.0f ? 0.0f : t > 1.0 ? 1.0f : t);

        float2 nearestPoint = { A.x - AB.x * t,
                                A.y - AB.y * t };

        float nearestDistSq = dot(nearestPoint, nearestPoint);
        if(nearestDistSq <= captureSpanSq)
        {
            outCapturedLines[numCaptured++] = i;
        }
        else if(nearestDistSq < dfSq)
        {
            dfSq = nearestDistSq;
        }
    }

    *outNumCapturedLines = numCaptured;

    float df = sqrtf(dfSq) - invResolution;
    if(df < (1.0f / 255.0f))
    {
        df = 1.0f / 255.0f;
    }
    else if(df > 1.0f)
    {
        df = 1.0f;
    }
    return (uint32_t)(df * 255.0f);
}


template<class T>
struct scoped_malloc
{

    scoped_malloc(uint32_t num)
    : mem((T*)malloc(sizeof(T)*num))
    {}
    
    ~scoped_malloc()
    {
        free(mem);
    }

    operator T* () { return mem; }
    
    T* consume()
    {
        T* v = mem;
        mem = 0;
        return v;
    }

    T*   mem;
};


} // unnamed namespace


void DFRTV1PrepareLines(float4* lines, uint32_t numLines)
{
    for(uint32_t i=0; i<numLines; ++i)
    {
        lines[i].z = lines[i].x - lines[i].z;
        lines[i].w = lines[i].y - lines[i].w;
    }
}


int DFRTV1Render(const DFRTV1Inputs* inputs, DFRTV1Outputs* outputs)
{
    uint32_t    numLines = inputs->numLines;
    float4*     preparedLines = inputs->preparedLines;
    uint32_t    resolution = inputs->resolution;
    float       capturePadding = inputs->capturePadding;
    
    IF_UNLIKELY(!numLines || !preparedLines || !resolution)
    {
        return 0;
    }

    scoped_malloc<uint32_t> dfTexture(resolution * resolution);
    scoped_malloc<uint32_t> pixelLineCaptures(numLines);

    IF_UNLIKELY(!dfTexture || !pixelLineCaptures)
    {
        return 0;
    }

    LineOverlapCollector collector(numLines);
    IF_UNLIKELY(!collector.initOk())
    {
        return 0;
    }

    float invResolution = 1.0f / ((float)resolution);
    float captureSpan = (0.5f + capturePadding)
                        * sqrtf(2.0f)
                        * (1.0f / ((float)(resolution < 255 ? resolution : 255)));
    float captureSpanSq = captureSpan * captureSpan;

    for(uint32_t y=0; y<resolution; ++y)
    {
        float v = ((float)y + 0.5f) * invResolution;
        uint32_t rowOffset = y * resolution;
        for(uint32_t x=0; x<resolution; ++x)
        {
            float u = ((float)x + 0.5f) * invResolution;
            float2 uv = { u, v };

            uint32_t numCapturedLines;
            uint32_t df = evalPixel(uv,
                                    captureSpanSq,
                                    invResolution,
                                    preparedLines,
                                    numLines,
                                    pixelLineCaptures,
                                    &numCapturedLines);

            // Can't handle more than 255 lines under a pixel.
            IF_UNLIKELY(numCapturedLines > 255)
            {
                return 0;
            }

            uint32_t lineGroupId = collector.add(pixelLineCaptures,
                                                 numCapturedLines);

            IF_UNLIKELY(lineGroupId == LineOverlapCollector::tombstone)
            {
                return 0;
            }

            // Stash the group id in the texture, we'll be fetching
            // it out later.
            dfTexture[rowOffset + x] = df | (lineGroupId << 8);
        }
    }

    IF_UNLIKELY(!collector.compact())
    {
        return 0;
    }

    uint32_t lineBufferCount = collector.lineIdsSize;
    float4* lineBuffer = (float4*)malloc(sizeof(float4)*lineBufferCount);
    if(!lineBuffer)
    {
        return 0;
    }

    for(uint32_t i=0; i<lineBufferCount; ++i)
    {
        lineBuffer[i] = preparedLines[collector.lineIds[i]];
    }

    for(uint32_t y=0; y<resolution; ++y)
    {
        uint32_t rowOffset = y * resolution;
        for(uint32_t x=0; x<resolution; ++x)
        {
            uint32_t& pixel = dfTexture[rowOffset + x];
            uint32_t lineGroupId = pixel >> 8;
            pixel &= 0xffu;
            LineOverlapCollector::LineGroup group = collector.getLineGroup(lineGroupId);
            pixel |= (group.numLines << 8) | (group.offset << 16);
        }
    }

    outputs->dfTexture = dfTexture.consume();
    outputs->lineBuffer = lineBuffer;
    outputs->lineBufferCount = lineBufferCount;
    return 1;
}
