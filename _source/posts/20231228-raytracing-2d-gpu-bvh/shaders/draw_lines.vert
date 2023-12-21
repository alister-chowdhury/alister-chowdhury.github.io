#version 460 core

#include "common.glsli"

readonly layout(std430, binding = 0) buffer  lines_      { vec4 lines[]; };
         layout(binding = 1)         uniform inCol_      { vec3 inCol; };

layout(location=0) out vec3 col;


void main()
{
    uint lineId = gl_VertexID / 2;
    int side = gl_VertexID % 2;
    vec4 line = lines[lineId];
    vec2 uv = side == 0 ? line.xy : line.zw;
    col = inCol;
    gl_Position = vec4(uv * 2.0 - 1.0, 0.0, 1.0);
}
