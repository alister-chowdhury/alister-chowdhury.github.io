#ifndef BVH_V1_H
#define BVH_V1_H

#include <stdint.h>

#if defined(__GNUC__) || defined(__clang__)
#define BVH_V1_FORCEINLINE __attribute__((always_inline)) inline
#elif defined(_MSC_VER)
#define BVH_V1_FORCEINLINE __forceinline
#else
#define BVH_V1_FORCEINLINE inline
#endif


#define BVH_V1_METADATA_BBOX       0
#define BVH_V1_METADATA_LINE       1
#define BVH_V1_NODE_FLOAT4_STRIDE  3


typedef struct
{
    float x, y;
} float2;


typedef struct
{
    float x, y, z, w;
} float4;


typedef struct
{
    float4 v0, v1, v2;
} BvhEntryV1;


typedef struct
{
    float2 center;
    uint32_t id;
} WorkingEntryV1;


typedef struct
{
    uint32_t    hitLineId;
    float       hitDistSq;
    float4      line; // ptA = line.xy, ptB = line.xy - line.zw
    float       hitLineInterval;
    float2      dUV; // ro + dUV = intersection point

} LineBvhV1Result;


#ifdef __cplusplus
extern "C"
{
#endif // __cplusplus


// Build a BVH returning back the final number of `BvhEntry` elements written into `outBvh`
uint32_t buildBvhV1(uint32_t numLines,          // Number of lines to process
                    const float4* lines,        // Input buffer, containings lines in [x0, y0, x1, y1] format.
                    BvhEntryV1* outBvh,         // Output BVH, should contain `numLines` elements.
                    WorkingEntryV1* workspace   // Workspace buffer, should contain `numLines` elements.
                    );


void traceLineBvhV1(const BvhEntryV1* bvh,
                    float2 ro,
                    float2 rd,
                    float maxDist,
                    int stopOnFirstHit,
                    LineBvhV1Result* outResult);


#ifdef __cplusplus
} // extern "C"
#endif // __cplusplus


#endif // BVH_V1_H
