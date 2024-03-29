#version 450

#include "common.glsli"

#ifdef VS_OUTPUT_UV
layout(location=VS_OUTPUT_UV) out vec2 uv;
#endif

#ifdef VS_OUTPUT_NDC
layout(location=VS_OUTPUT_NDC) out vec2 ndc;
#endif


void main()
{

#ifndef VS_OUTPUT_NDC
vec2
#endif // VS_OUTPUT_NDC

    ndc = vec2(
        gl_VertexID == 0 ? -4.0 : 1.0,
        gl_VertexID == 2 ? 4.0 : -1.0
    );

#ifdef VS_OUTPUT_UV
    uv = ndc * 0.5 + 0.5;
#endif

    gl_Position = vec4(ndc, 0., 1.);

}
