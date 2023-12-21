#version 460 core

#include "common.glsli"

readonly layout(std430, binding = 0) buffer lines_      { vec4 lines[]; };

layout(location=0) out vec2 ndc;
flat layout(location=1) out vec3 col;

void main()
{
    uint lineId = gl_VertexID / 12;
    int side = (gl_VertexID / 6) % 2;
    int quadId = triangleToQuadVertexIdZ(gl_VertexID % 6);

    vec4 line = lines[lineId];
    vec2 point = side == 0 ? line.xy : line.zw;

    ndc = vec2((quadId & 1) == 0 ? -1 : 1,
               (quadId & 2) == 0 ? -1 : 1);

    col.xy = point * 0.5 + 0.5;
    col.z = min(1, length(col.xy));

    gl_Position = vec4(point * 2.0 - 1.0
                       + ndc * PICK_MAX_DIST * 2,
                       0.0,
                       1.0);
}
