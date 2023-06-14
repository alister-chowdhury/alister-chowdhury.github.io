#include <algorithm>
#include <cmath>
#include <cstdint>
#include <cstddef>

#include "bvh_v1.h"


namespace
{

struct BuildBVHV1Entry
{
    uint32_t metadata;
    uint32_t entryId;
    float4 data;
    float4 bbox;
};


struct BuildBVHWriteBackDataV1
{
    uint32_t allocator;
    BvhEntryV1* outBvh;
    const float4* lines;
};


// Compute the union of two bounding boxes.
BVH_V1_FORCEINLINE static float4 mergeBounds(float4 a, float4 b)
{
    if(b.x < a.x) { a.x = b.x; }
    if(b.y < a.y) { a.y = b.y; }
    if(b.z > a.z) { a.z = b.z; }
    if(b.w > a.w) { a.w = b.w; }
    return a;
}


// Expand a bounding box given a point.
BVH_V1_FORCEINLINE static float4 mergeBoundsPoint(float4 a, float2 b)
{
    if(b.x < a.x) { a.x = b.x; }
    if(b.x > a.z) { a.z = b.x; }
    if(b.y < a.y) { a.y = b.y; }
    if(b.y > a.w) { a.w = b.y; }
    return a;
}


// Calculate the bounding box that contains all the central positions
// of a range of lines.
// NB: This is used for splitting rather than the actual bounding box
//     to prevent configurations like.
//
//            -.-
//           --.--
//        -----.-----
//     --------.---------
//
//     From splitting across centerX rather than centerY, where the
//     split would effectively be random, since they all share the same
//     centerX value.
BVH_V1_FORCEINLINE static float4 calcCenterBBox(const WorkingEntryV1* start,
                                                const WorkingEntryV1* end)
{
    float4 bounds = {start->center.x, start->center.y, start->center.x, start->center.y };
    ++start;
    for(;start < end; ++start)
    {
        bounds = mergeBoundsPoint(bounds, start->center);
    }
    return bounds;
}


BVH_V1_FORCEINLINE static float2 bboxCenter(float4 bbox)
{
    return { (bbox.x + bbox.z) * 0.5f,
             (bbox.y + bbox.w) * 0.5f};
}


BVH_V1_FORCEINLINE static float dot(float2 a, float2 b)
{
    return (a.x * b.x) + (a.y * b.y);
}


BVH_V1_FORCEINLINE static float distSq(float2 a, float2 b)
{
    a.x -= b.x;
    a.y -= b.y;
    return dot(a, a);
}


BVH_V1_FORCEINLINE static WorkingEntryV1* partition(WorkingEntryV1* start,
                                                    WorkingEntryV1* end,
                                                    float4 referenceBBox,
                                                    float4* outReferenceBBoxLeft,
                                                    float4* outReferenceBBoxRight)
{
    uint32_t num = ((uint32_t)(end - start));

    // Split across which ever central bbox axis is greater.
    struct SortingOp
    {
        BVH_V1_FORCEINLINE bool operator()(const WorkingEntryV1& a, const WorkingEntryV1& b) const
        {
            const float* af = (float*)(((uintptr_t)&a) + centerDimOffset);
            const float* bf = (float*)(((uintptr_t)&b) + centerDimOffset);
            return *af < *bf;
        }
        uintptr_t centerDimOffset;
    };
    SortingOp op{};
    op.centerDimOffset = (referenceBBox.z - referenceBBox.x) > (referenceBBox.w - referenceBBox.x)
                         ? (offsetof(WorkingEntryV1, center) + offsetof(float2, x))
                         : (offsetof(WorkingEntryV1, center) + offsetof(float2, y))
                         ;

    // For even elements:
    //      A B C D
    //          ^-- mid point is here
    //        ^-- ensure this element is sorted.
    // For odd elements:
    //      A B C D E
    //            ^-- mid point is here
    //          ^-- ensure this element is sorted
    WorkingEntryV1* mid = start + (num + 1) / 2;   // end of left, start of right
    std::nth_element(start, mid - 1, end, op);

    // If we have an even number of elemebnts just split directly in the middle.
    //       A B C D => [ A B ] [ C D ]
    //
    // If we have an odd number of elements, calculate the left and right bboxs
    // without the middle element and then merge into whichever side has a closer
    // central bbox.
    //       A B C D E => [ A B C ] [ D E ]
    //                 or [ A B ] [ C D E ]
    //
    //
    // Another strategy, worth exploring is to find the line with the biggest
    // bbox, and to extract it, e.g:
    //
    //  Instead of:
    //      [A B C D E]
    //          /     \
    //    [A B C]     [D E]
    //     /    \      / \
    //   [A B]   C    D   E
    //   /   \
    //  A     B
    //
    // Do this:
    //      [A B C D E]
    //          /     \
    //    [A B C E]    D
    //     /    \
    //   [A B]   [C E]
    //    / \     /  \
    //   A   B   C    E
    //
    // If one line is sufficiently larger the probability of hitting
    // it early on would increase + descendant bboxs would be smaller.
    // However, not currently doing this.

    if(num & 1) { --mid; }
    *outReferenceBBoxLeft = calcCenterBBox(start, mid);

    if(num & 1) { ++mid; }
    *outReferenceBBoxRight = calcCenterBBox(mid, end);

    if(num & 1)
    {
        float2 leftCenter =  bboxCenter(*outReferenceBBoxLeft);
        float2 rightCenter = bboxCenter(*outReferenceBBoxRight);
        float2 midCenter = mid[-1].center;

        if(distSq(rightCenter, midCenter) > distSq(leftCenter, midCenter))
        {
            *outReferenceBBoxLeft = mergeBoundsPoint(*outReferenceBBoxLeft, midCenter);
        }
        else
        {
            --mid;
            *outReferenceBBoxRight = mergeBoundsPoint(*outReferenceBBoxRight, midCenter);
        }
    }

    return mid;
}


static void buildBvhSubdivV1(BuildBVHWriteBackDataV1* writebackData,
                             BuildBVHV1Entry* outEntry,
                             WorkingEntryV1* start,
                             WorkingEntryV1* end,
                             float4 referenceBBox)
{
    size_t num = end - start;

    // Generate a leaf, no extra allocation needed
    if(num == 1)
    {
        float4 line = writebackData->lines[start->id];
        outEntry->metadata = BVH_V1_METADATA_LINE;
        outEntry->entryId = start->id;
        outEntry->data = { line.x, line.y, line.x - line.z, line.y - line.w };
        outEntry->bbox = {
            std::min(line.x, line.z),
            std::min(line.y, line.w),
            std::max(line.x, line.z),
            std::max(line.y, line.w)
        };
        return;
    }

    float4 refBboxLeft;
    float4 refBboxRight;
    WorkingEntryV1* mid;

    if(num != 2)
    {
        mid = partition(start, end, referenceBBox, &refBboxLeft, &refBboxRight);
    }
    else
    {
        mid = start + num / 2;
    }

    uint32_t allocIndex = writebackData->allocator++;

    BuildBVHV1Entry left;
    buildBvhSubdivV1(writebackData, &left, start, mid, refBboxLeft);
    
    BuildBVHV1Entry right;
    buildBvhSubdivV1(writebackData, &right, mid, end, refBboxRight);

    writebackData->outBvh[allocIndex].v0.x = *((const float*)&left.metadata);
    writebackData->outBvh[allocIndex].v0.y = *((const float*)&left.entryId);
    writebackData->outBvh[allocIndex].v0.z = *((const float*)&right.metadata);
    writebackData->outBvh[allocIndex].v0.w = *((const float*)&right.entryId);
    writebackData->outBvh[allocIndex].v1 = left.data;
    writebackData->outBvh[allocIndex].v2 = right.data;

    float4 bbox = mergeBounds(left.bbox, right.bbox);
    outEntry->metadata = BVH_V1_METADATA_BBOX;
    outEntry->entryId = allocIndex * BVH_V1_NODE_FLOAT4_STRIDE;
    outEntry->data = bbox;
    outEntry->bbox = bbox;
}

} // unnamed namespace


extern "C"
{

uint32_t buildBvhV1(uint32_t numLines,
                    const float4* lines,
                    BvhEntryV1* outBvh,
                    WorkingEntryV1* workspace)
{
    if(!numLines || !lines || !outBvh || !workspace)
    {
        return 0;
    }

    for(uint32_t id=0; id<numLines; ++id)
    {
        float4 line = lines[id];
        float2 center = { (line.x + line.z) * 0.5f, (line.y + line.w) * 0.5f };
        workspace[id].center = center;
        workspace[id].id = id;
    }

    BuildBVHWriteBackDataV1 writebackData;
    writebackData.allocator = 0;
    writebackData.outBvh = outBvh;
    writebackData.lines = lines;

    float4 topLevelCenterBbox = calcCenterBBox(workspace, workspace+numLines);

    BuildBVHV1Entry rootData;
    buildBvhSubdivV1(&writebackData, &rootData, workspace, workspace + numLines, topLevelCenterBbox);

    // Handle only having a single line by just duplicating it
    if(rootData.metadata == BVH_V1_METADATA_LINE)
    {
        uint32_t allocIndex = writebackData.allocator++;
        writebackData.outBvh[allocIndex].v0.x = *((const float*)&rootData.metadata);
        writebackData.outBvh[allocIndex].v0.y = *((const float*)&rootData.entryId);
        writebackData.outBvh[allocIndex].v0.z = *((const float*)&rootData.metadata);
        writebackData.outBvh[allocIndex].v0.w = *((const float*)&rootData.entryId);
        writebackData.outBvh[allocIndex].v1 = rootData.data;
        writebackData.outBvh[allocIndex].v2 = rootData.data;
    }

    return writebackData.allocator;
}

} // extern "C"
