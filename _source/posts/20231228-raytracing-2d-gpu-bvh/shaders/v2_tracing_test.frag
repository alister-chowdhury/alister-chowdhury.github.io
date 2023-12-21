#version 460 core

// Maximum demo size is 16x16
#define LINE_BVH_V2_STACK_SIZE 9

#include "v2_tracing.glsli"
#include "common.glsli"

#define VIS_TRACE_POINTLIGHT            0
#define VIS_TRACE_VISIBILITY            1
#define VIS_TRACE_NUM_VISITS            2
#define VIS_TRACE_NUM_INTERSECTIONS     3
#define VIS_TRACE_COMPOSITE             4


#ifndef VIS_TRACE_TYPE
#define VIS_TRACE_TYPE VIS_TRACE_VISIBILITY
#endif // VIS_TRACE_TYPE

layout(binding=1) uniform targetUV_ { vec2 targetUV; };
layout(location=0) in vec2 uv;
layout(location=0) out vec4 col;


void main()
{

    bool stopOnFirstHit = (VIS_TRACE_TYPE == VIS_TRACE_VISIBILITY)
                            || (VIS_TRACE_TYPE == VIS_TRACE_POINTLIGHT);

    // Trace from UV to target
#if 0
    vec2 toTarget = targetUV - uv;
    float dist = length(toTarget);
    LineBvhV2Result hit = traceLineBvhV2(uv, toTarget / dist, dist, stopOnFirstHit);

    // Trace from target to UV
#else
    vec2 fromTarget = uv - targetUV;
    float dist = length(fromTarget);
    LineBvhV2Result hit = traceLineBvhV2(targetUV, fromTarget / dist, dist, stopOnFirstHit);
#endif

    float noHit = float(hit.hitLineId == 0xffffffffu);
    float numVisits = float(hit.numNodesVisited) / 32.0;
    float numIntersections = float(hit.numLineIntersections) / 64.0;


#if VIS_TRACE_TYPE == VIS_TRACE_POINTLIGHT

    float attenuation = pow(dist + 1.0, -5);
    vec3 c = normalize(vec3(targetUV, length(targetUV))) * noHit * attenuation;
    col = vec4(c, 1.0);

#elif VIS_TRACE_TYPE == VIS_TRACE_VISIBILITY

    col = vec4(noHit, noHit, noHit, 1.0);

#elif VIS_TRACE_TYPE == VIS_TRACE_NUM_VISITS

    col = vec4(numVisits, numVisits, numVisits, 1.0);

#elif VIS_TRACE_TYPE == VIS_TRACE_NUM_INTERSECTIONS

    col = vec4(numIntersections, numIntersections, numIntersections, 1.0);

#else // VIS_TRACE_TYPE == VIS_TRACE_COMPOSITE

    col = vec4(numVisits, numIntersections, noHit, 1.0);

#endif // VIS_TRACE_TYPE

}
