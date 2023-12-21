#version 460 core

#include "common.glsli"

readonly layout(std430, binding = 0) buffer lines_      { vec4 lines[]; };
         layout(binding=1)           uniform picked_    { uvec2 picked; };

layout(location=0) out vec2 ndc;

void main()
{
    int quadId = triangleToQuadVertexIdZ(gl_VertexID);
    if(picked.x == 0xffffffffu)
    {
        ndc = vec2(0);
        gl_Position = vec4(0);

    }
    else
    {        
        vec4 line = lines[picked.x];
        vec2 point = picked.y == 0 ? line.xy : line.zw;
        ndc = vec2((quadId & 1) == 0 ? -1 : 1,
                   (quadId & 2) == 0 ? -1 : 1);
        gl_Position = vec4(point * 2.0 - 1.0
                           + ndc * PICK_MAX_DIST * 2,
                           0.0,
                           1.0);
    }

}
