#version 460 core

#include "common.glsli"
#include "lights_common.glsli"

layout(binding=1) uniform sampler2D lightPlaneMap;

layout(location=0) in vec2 localUv;
flat layout(location=1) in float linemapV;
flat layout(location=2) in vec4 colourAndDecayRate;


layout(location=0) out vec4 outCol;


#ifndef PLANE_BLOCKING_MODE
#define PLANE_BLOCKING_MODE PLANE_BLOCKING_MODE_BINARY_TWOTAP_PCF
#endif // PLANE_BLOCKING_MODE


void main()
{

    ivec2 lightPlaneMapSize = textureSize(lightPlaneMap, 0);
    float bias = 0.5 * rcpForPowersOf2(float(lightPlaneMapSize.x)); // texture width is assumed to be a power of 2

    vec3 evaluatedColour = evaluateLightWithPlaneShadowing(lightPlaneMap,
                                                           linemapV,
                                                           localUv,
                                                           lightPlaneMapSize,
                                                           colourAndDecayRate,
                                                           bias,
                                                           PLANE_BLOCKING_MODE);

    outCol = vec4(evaluatedColour, 0.0);
}
