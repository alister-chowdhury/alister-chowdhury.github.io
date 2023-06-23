#version 460 core

#include "common.glsli"

layout(location=0) uniform vec4 bbox;
layout(location=0) out vec2 localNDC;

void main()
{
    int vertexId = triangleToQuadVertexIdZ(int(gl_VertexID));
    vec2 localUV = vec2(vertexId & 1, vertexId >> 1);
    localNDC = localUV * 2.0 - 1.0;
    gl_Position = vec4(mix(bbox.x, bbox.z, localUV.x),
                       mix(bbox.y, bbox.w, localUV.y),
                       0.0,
                       1.0);
}
