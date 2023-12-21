#version 460 core

#include "common.glsli"

flat layout(location=0) in vec3 colA;
flat layout(location=1) in vec3 colB;
flat layout(location=2) in float level;
     layout(location=3) in vec2 localCoord;

layout(location=0) out vec4 finalCol;

void main()
{
    vec2 scaled = localCoord * level * level;
    int tile = (int(scaled.x) & 1) ^ (int(scaled.y) & 1);
    finalCol = vec4((tile == 0 ? colA : colB), 0.9);
}
