#version 460 core

#include "common.glsli"

layout(location=0) in vec2 ndc;
layout(location=0) out vec4 outCol;

void main()
{
    float l = length(ndc);
    float mask = step(l, 1.);
    float lessMask = mask * smoothstep(0.1, 0.75, l);
    outCol = vec4(vec3(lessMask), 1.0) * mask;
}
