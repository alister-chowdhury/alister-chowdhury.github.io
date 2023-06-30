#version 460 core

// dispatch GL_LINES, 8 * numLights

#include "common.glsli"


#if TARGETTING_WEBGL
layout(binding=0) uniform usampler2D lightOBBox;
#define OBBOX_TEXEL_FETCH(P) texelFetch(lightOBBox, ivec2((P), 0), 0)
#else // TARGETTING_WEBGL
layout(binding=0) uniform usampler1D lightOBBox;
#define OBBOX_TEXEL_FETCH(P) texelFetch(lightOBBox, (P), 0)
#endif // TARGETTING_WEBGL


layout(location=0) out vec3 vsToFsCol;


void main()
{
    int index = int(gl_VertexID);
    int pointIndex = index & 1; index /= 2;
    int lineIndex = index & 3; index /= 4;
    int entryIndex = index;

    uvec4 data = OBBOX_TEXEL_FETCH(entryIndex);
    vec2 uv = vec2(0);

    switch(lineIndex)
    {
        case 0: uv = (pointIndex == 0) ? unpackHalf2x16(data.x) : unpackHalf2x16(data.y); break;
        case 1: uv = (pointIndex == 0) ? unpackHalf2x16(data.y) : unpackHalf2x16(data.z); break;
        case 2: uv = (pointIndex == 0) ? unpackHalf2x16(data.z) : unpackHalf2x16(data.w); break;
        case 3: uv = (pointIndex == 0) ? unpackHalf2x16(data.w) : unpackHalf2x16(data.x); break;
        default: break;
    }

    vsToFsCol = randomHs1Col(uint(entryIndex) * 5123 + 9128);
    gl_Position = vec4(uv * 2.0 - 1.0, 0., 1.);
}

