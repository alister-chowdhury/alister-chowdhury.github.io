#version 460 core

#include "common.glsli"

#define VIS_DF_TYPE_DIST                0
#define VIS_DF_TYPE_NUMLINES            1
#define VIS_DF_TYPE_COMPOSITE           2


#ifndef VIS_DF_TYPE
#define VIS_DF_TYPE VIS_DF_TYPE_DIST
#endif // VIS_DF_TYPE

layout(binding=DF_RTRACE_DFTEX_V1_LOC)      uniform usampler2D v1DfTexture;
layout(location=DF_RTRACE_PARAMS_V1_LOC)    uniform vec4 v1HybridParams; // .x = res, .yzw = unused

layout(location=0) in vec2 uv;
layout(location=0) out vec4 col;


void main()
{

    ivec2 coord = ivec2(uv * v1HybridParams.xx);
    uint texelData = texelFetch(v1DfTexture, coord, 0).x;

    float dist = float(texelData & 0xff) / 255.0;
    float numLines = float((texelData >> 8) & 0xff);

    dist /= 0.25;       // 0->.25 => 0->1
    numLines /= 4.0;    // 0->4   => 0->1

#if VIS_DF_TYPE == VIS_DF_TYPE_DIST

    col = vec4(vec3(dist), 1.0);

#elif  VIS_DF_TYPE == VIS_DF_TYPE_NUMLINES

    col = vec4(vec3(numLines), 1.0);

#else // VIS_DF_TYPE == VIS_DF_TYPE_COMPOSITE

    col = vec4(dist, numLines, length(vec2(dist, numLines)), 1.0);

#endif // VIS_TRACE_TYPE

}
