#version 460 core

// dispatch GL_LINES, 8 * numLights

#include "common.glsli"


#if TARGETTING_WEBGL
layout(binding=0) uniform sampler2D lightBBox;
#define BBOX_TEXEL_FETCH(P) texelFetch(lightBBox, ivec2((P), 0), 0)
#else // TARGETTING_WEBGL
layout(binding=0) uniform sampler1D lightBBox;
#define BBOX_TEXEL_FETCH(P) texelFetch(lightBBox, (P), 0)
#endif // TARGETTING_WEBGL


layout(location=0) out vec3 vsToFsCol;


void main()
{
    int index = int(gl_VertexID);
    int pointIndex = index & 1; index /= 2;
    int lineIndex = index & 3; index /= 4;
    int entryIndex = index;

    vec4 data = BBOX_TEXEL_FETCH(entryIndex);
    vec2 uv = vec2(0);

    switch(lineIndex)
    {
        case 0: uv = (pointIndex == 0) ? data.xy : data.zy; break;
        case 1: uv = (pointIndex == 0) ? data.zy : data.zw; break;
        case 2: uv = (pointIndex == 0) ? data.zw : data.xw; break;
        case 3: uv = (pointIndex == 0) ? data.xw : data.xy; break;
        default: break;
    }

    vsToFsCol = randomHs1Col(uint(entryIndex) * 5123 + 9128);
    gl_Position = vec4(uv * 2.0 - 1.0, 0., 1.);
}
