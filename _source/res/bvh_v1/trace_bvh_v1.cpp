#include <algorithm>
#include <cmath>
#include <cstdint>
#include <cstddef>

#include "bvh_v1.h"


// Should be like log2(num_lines) + 1 for maximum occupancy
// assuming a mostly perfect binary tree.
#ifndef LINE_BVH_V1_STACK_SIZE
#define LINE_BVH_V1_STACK_SIZE 16
#endif // LINE_BVH_V1_STACK_SIZE


namespace
{

struct LineBvhV1Stack
{
    int index;
    int stack[LINE_BVH_V1_STACK_SIZE];
};


static BVH_V1_FORCEINLINE bool lineBvhV1EvalEntry(float2 ro,
                                                  float2 invRd,
                                                  float2 metadata,
                                                  float4 data,
                                                  LineBvhV1Result& result,
                                                  float& dist,
                                                  int& idx)
{
    // https://www.geogebra.org/calculator/ytnhzgzb
    if(*((uint32_t*)&metadata.x) == BVH_V1_METADATA_LINE)
    {
        float2 A = ro;
        float2 AB = { -result.dUV.x, -result.dUV.y };
        float2 C = { data.x, data.y };
        float2 CD = { data.z, data.w };
        float2 AC = { A.x - C.x, A.y - C.y };

        float d = AB.x * CD.y - AB.y * CD.x; // cross(AB, CD)
        float u = AC.x * AB.y - AC.y * AB.x; // cross(AC, AB)
        float v = AC.x * CD.y - AC.y * CD.x; // cross(AC, CD)

        float dSign = std::copysign(1.0f, d);
        u *= dSign; // u *= sign(d);
        v *= dSign; // v *= sign(d);

        if((std::min(u, v) > 0.0f) && (std::max(u, v) < std::abs(d)))
        {
            float invd = 1.0f / d;
            result.hitLineId = *((uint32_t*)&metadata.y);
            result.hitLineInterval = -u * invd;
            result.line = data;
            result.dUV.x *= v * invd;
            result.dUV.y *= v * invd;
            result.hitDistSq = result.dUV.x * result.dUV.x
                             + result.dUV.y * result.dUV.y
                             ;
        }

        return false;
    }

    // (*((uint32_t*)&metadata.x) == LINE_BVH_V1_BBOX_TYPE)
    // https://www.geogebra.org/calculator/gcmwgqhk
    {
        float2 bboxMin = { data.x, data.y };
        float2 bboxMax = { data.z, data.w };
        float2 xintervals = { (bboxMin.x - ro.x) * invRd.x, (bboxMax.x - ro.x) * invRd.x };
        float2 yintervals = { (bboxMin.y - ro.y) * invRd.y, (bboxMax.y - ro.y) * invRd.y };

        if(xintervals.x > xintervals.y) { std::swap(xintervals.x, xintervals.y); }
        if(yintervals.x > yintervals.y) { std::swap(yintervals.x, yintervals.y); }

        float2 intervals = { std::max(xintervals.x, yintervals.x), std::min(xintervals.y, yintervals.y) };
        intervals.x = std::max(0.0f, intervals.x);

        if((intervals.x < intervals.y) && ((intervals.x * intervals.x) < result.hitDistSq))
        {
            dist = intervals.x;
            idx = *((uint32_t*)&metadata.y);
            return true;
        }

        return false;
    }

}


} // unnamed namespace


extern "C"
{

void traceLineBvhV1(const BvhEntryV1* bvh_,
                    float2 ro,
                    float2 rd,
                    float maxDist,
                    int stopOnFirstHit,
                    LineBvhV1Result* outResult)
{
    if(!bvh_ || !outResult)
    {
        return;
    }

    LineBvhV1Result result;

    result.hitLineId = 0xffffffffu;
    result.hitDistSq = maxDist * maxDist;
    result.dUV = { rd.x * maxDist, rd.y * maxDist };

    LineBvhV1Stack stack;
    stack.index = 0;

    float2 invRd = { 1.0f / rd.x, 1.0f / rd.y };
    bool done = false;
    int head = 0;

    const float4* bvh = (const float4*)bvh_;

    while(!done)
    {
        float4 v0 = bvh[head];
        float4 v1 = bvh[head + 1];
        float4 v2 = bvh[head + 2];

        float2 addToStackDistances;
        struct { int x; int y; } addToStackIds;

        float2 leftMeta = { v0.x, v0.y };
        float4 leftData = v1;

        bool leftAddToStack = lineBvhV1EvalEntry(ro,
                                                 invRd,
                                                 leftMeta,
                                                 leftData,
                                                 result,
                                                 addToStackDistances.x,
                                                 addToStackIds.x);

        float2 rightMeta = { v0.z, v0.w };
        float4 rightData = v2;

        bool rightAddToStack = lineBvhV1EvalEntry(ro,
                                                  invRd,
                                                  rightMeta,
                                                  rightData,
                                                  result,
                                                  addToStackDistances.y,
                                                  addToStackIds.y);

        if(stopOnFirstHit && (result.hitLineId != 0xffffffffu))
        {
            break;
        }

        // Prioritise nearest
        if(leftAddToStack && rightAddToStack)
        {
            if(addToStackDistances.x < addToStackDistances.y)
            {
                std::swap(addToStackDistances.x, addToStackDistances.y);
                std::swap(addToStackIds.x, addToStackIds.y);
            }

            stack.stack[++stack.index] = addToStackIds.x;
            head = addToStackIds.y;
        }
        else if(leftAddToStack)
        {
            head = addToStackIds.x;

        }
        else if(rightAddToStack)
        {
            head = addToStackIds.y;
        }
        else if(stack.index > 0)
        {
            head = stack.stack[stack.index--];
        }
        else
        {
            done = true;
        }
    }

    *outResult = result;
}


} // extern "C"
