#version 460 core

// Dispatch with GL_TRIANGLES, 6


#include "common.glsli"


#ifdef VS_OUTPUT_UV
layout(location=VS_OUTPUT_UV) out vec2 uv;
#endif

#ifdef VS_OUTPUT_NDC
layout(location=VS_OUTPUT_NDC) out vec2 ndc;
#endif

layout(location=0) uniform vec4 inRectBounds;


void main()
{

    int quadId = triangleToQuadVertexIdZ(gl_VertexID);

#ifndef VS_OUTPUT_UV
    vec2
#endif
    uv = vec2(
        ((quadId & 1) == 0) ? inRectBounds.x : inRectBounds.z,
        ((quadId & 2) == 0) ? inRectBounds.y : inRectBounds.w
    );

#ifndef VS_OUTPUT_NDC
vec2
#endif // VS_OUTPUT_NDC
    ndc = uv * 2.0 - 1.0;

    gl_Position = vec4(ndc, 0., 1.);

}
