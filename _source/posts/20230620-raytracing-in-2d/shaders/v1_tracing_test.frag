#version 460 core

#include "v1_tracing.glsli"

#define VIS_TRACE_POINTLIGHT            0
#define VIS_TRACE_VISIBILITY            1
#define VIS_TRACE_NUM_VISITS            2
#define VIS_TRACE_NUM_INTERSECTIONS     3
#define VIS_TRACE_COMPOSITE             4
#define VIS_TRACE_LINE_ID               5


#ifndef VIS_TRACE_TYPE
#define VIS_TRACE_TYPE VIS_TRACE_VISIBILITY
#endif // VIS_TRACE_TYPE


layout(location=0)  uniform vec2 targetUV;
layout(location=0) in vec2 uv;
layout(location=0) out vec4 col;

uint wang_hash(uint seed)
{
    seed = (seed ^ 61) ^ (seed >> 16);
    seed *= 9;
    seed = seed ^ (seed >> 4);
    seed *= 0x27d4eb2d;
    seed = seed ^ (seed >> 15);
    return seed;
}


vec3 hs1(float H)
{
    float R = abs(H * 6 - 3) - 1;
    float G = 2 - abs(H * 6 - 2);
    float B = 2 - abs(H * 6 - 4);
    return clamp(vec3(R,G,B), vec3(0), vec3(1));
}


vec3 randomHs1Col(uint idx)
{
    return hs1((wang_hash(idx) & 0xffff) / 65535.0);
}


void main()
{

    bool stopOnFirstHit = (VIS_TRACE_TYPE == VIS_TRACE_VISIBILITY)
                            || (VIS_TRACE_TYPE == VIS_TRACE_POINTLIGHT);

    // Trace from UV to target
#if 0
    vec2 toTarget = targetUV - uv;
    float dist = length(toTarget);
    LineBvhV1Result hit = traceLineBvhV1(uv, toTarget / dist, dist, stopOnFirstHit);

    // Trace from target to UV
#else
    vec2 fromTarget = uv - targetUV;
    float dist = length(fromTarget);
    LineBvhV1Result hit = traceLineBvhV1(targetUV, fromTarget / dist, dist, stopOnFirstHit);
#endif

    float noHit = float(hit.hitLineId == 0xffffffffu);
    float numVisits = float(hit.numNodesVisited) / 32.0;
    float numIntersections = float(hit.numLineIntersections) / 16.0;


#if VIS_TRACE_TYPE == VIS_TRACE_POINTLIGHT

    float attenuation = pow(dist + 1.0, -10);
    vec3 c = normalize(vec3(targetUV, length(targetUV))) * noHit * attenuation;
    col = vec4(c, 1.0);

#elif VIS_TRACE_TYPE == VIS_TRACE_VISIBILITY

    col = vec4(noHit, noHit, noHit, 1.0);

#elif VIS_TRACE_TYPE == VIS_TRACE_NUM_VISITS

    col = vec4(numVisits, numVisits, numVisits, 1.0);

#elif VIS_TRACE_TYPE == VIS_TRACE_NUM_INTERSECTIONS

    col = vec4(numIntersections, numIntersections, numIntersections, 1.0);

#elif VIS_TRACE_TYPE == VIS_TRACE_COMPOSITE

    col = vec4(numVisits, numIntersections, noHit, 1.0);

#else // VIS_TRACE_TYPE == VIS_TRACE_LINE_ID

    col = vec4(randomHs1Col(hit.hitLineId) * (1.0 - noHit), 1.0);

#endif // VIS_TRACE_TYPE

}
