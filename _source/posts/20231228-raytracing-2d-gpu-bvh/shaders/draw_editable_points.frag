#version 460 core

#include "common.glsli"

layout(location=0) in vec2 ndc;
flat layout(location=1) in vec3 col;

layout(location=0) out vec4 outCol;

void main()
{
    outCol = vec4(col, 1) * step(length(ndc), 1.);
}
