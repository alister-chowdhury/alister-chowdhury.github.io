#version 460 core

#include "v1_df_rtrace_hybrid.glsli"
#include "common.glsli"

#define VIS_TRACE_POINTLIGHT            0
#define VIS_TRACE_VISIBILITY            1
#define VIS_TRACE_NUM_ITERACTIONS       2
#define VIS_TRACE_NUM_INTERSECTIONS     3
#define VIS_TRACE_COMPOSITE             4
#define VIS_TRACE_LINE_ID               5


#ifndef VIS_TRACE_TYPE
#define VIS_TRACE_TYPE VIS_TRACE_VISIBILITY
#endif // VIS_TRACE_TYPE


layout(location=0) uniform vec2 targetUV;
layout(location=0) in vec2 uv;
layout(location=0) out vec4 col;


void main()
{

    // Trace from UV to target
#if 0
    vec2 toTarget = targetUV - uv;
    float dist = length(toTarget);
    LineBvhV1Result hit = traceLineBvhV1(uv, toTarget / dist, dist, stopOnFirstHit);

    // Trace from target to UV
#else
    vec2 fromTarget = uv - targetUV;
    float dist = length(fromTarget);
    TraceHybridV1Result hit = traceHybridV1(targetUV, fromTarget / dist, dist);
#endif

    float noHit = float(!hit.hit);
    float numIterations = float(hit.numIterations) / 16.0;
    float numLineIntersections = float(hit.numLineIntersections) / 16.0;


#if VIS_TRACE_TYPE == VIS_TRACE_POINTLIGHT

    float attenuation = pow(dist + 1.0, -10);
    vec3 c = normalize(vec3(targetUV, length(targetUV))) * noHit * attenuation;
    col = vec4(c, 1.0);

#elif VIS_TRACE_TYPE == VIS_TRACE_VISIBILITY

    col = vec4(noHit, noHit, noHit, 1.0);

#elif VIS_TRACE_TYPE == VIS_TRACE_NUM_ITERACTIONS

    col = vec4(numIterations, numIterations, numIterations, 1.0);

#elif VIS_TRACE_TYPE == VIS_TRACE_NUM_INTERSECTIONS

    col = vec4(numLineIntersections, numLineIntersections, numLineIntersections, 1.0);

#else // VIS_TRACE_TYPE == VIS_TRACE_COMPOSITE

    col = vec4(numIterations, numLineIntersections, noHit, 1.0);

#endif // VIS_TRACE_TYPE

}
