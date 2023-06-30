#version 460 core

#include "common.glsli"
#include "lights_common.glsli"


#if TARGETTING_WEBGL
layout(binding=0) uniform usampler2D lightingData;
#else // TARGETTING_WEBGL
layout(binding=0) uniform usampler1D lightingData;
#endif // TARGETTING_WEBGL

#if USE_OBBOX

#if TARGETTING_WEBGL
layout(binding=0) uniform usampler2D lightOBBox;
#define OBBOX_TEXEL_FETCH(P) texelFetch(lightOBBox, ivec2((P), 0), 0)
#else // TARGETTING_WEBGL
layout(binding=0) uniform usampler1D lightOBBox;
#define OBBOX_TEXEL_FETCH(P) texelFetch(lightOBBox, (P), 0)
#endif // TARGETTING_WEBGL

#else // USE_OBBOX

#if TARGETTING_WEBGL
layout(binding=0) uniform sampler2D lightBBox;
#define BBOX_TEXEL_FETCH(P) texelFetch(lightBBox, ivec2((P), 0), 0)
#else // TARGETTING_WEBGL
layout(binding=0) uniform sampler1D lightBBox;
#define BBOX_TEXEL_FETCH(P) texelFetch(lightBBox, (P), 0)
#endif // TARGETTING_WEBGL

#endif // USE_OBBOX

layout(location=0) uniform float invNumLights;


layout(location=0) out vec2 localUv;
flat layout(location=1) out float linemapV;
flat layout(location=2) out vec4 colourAndDecayRate;


void main()
{
    int lightIndex = int(gl_VertexID) / 6;
    int quadId = triangleToQuadVertexIdZ(gl_VertexID % 6);

#if USE_OBBOX
    uvec4 obbox = OBBOX_TEXEL_FETCH(lightIndex);
    uint target;
    switch(quadId)
    {
        case 0: target = obbox.x; break;
        case 1: target = obbox.y; break;
        case 2: target = obbox.w; break;
        default:
        case 3: target = obbox.z; break;
    }
    vec2 uv = unpackHalf2x16(target);

#else // USE_OBBOX
    vec4 bbox = BBOX_TEXEL_FETCH(lightIndex);
    vec2 uv = vec2(
        ((quadId & 1) == 0) ? bbox.x : bbox.z,
        ((quadId & 2) == 0) ? bbox.y : bbox.w
    );
#endif // USE_OBBOX

    gl_Position = vec4(uv * 2 - 1, 0., 1.);

    PointLightData pointLightData = loadPointLightData(lightingData, lightIndex);

    localUv = uv - pointLightData.position;
    linemapV = (float(lightIndex) + 0.5) * invNumLights;
    colourAndDecayRate = vec4(pointLightData.colour, pointLightData.decayRate);
}
