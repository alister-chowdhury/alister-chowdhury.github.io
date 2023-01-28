#version 460 core

#include "number_encoding.glsli"


layout(location = 0) in vec2 uv;

layout(location = 0) uniform uint encodedNumber;
layout(location = 1) uniform vec3 bgCol;
layout(location = 2) uniform vec3 fgCol;

layout(location = 0)        out vec4 outCol;


void main()
{
    uint signedValue = sampleEncodedNumber(encodedNumber, uv);
    outCol = vec4(mix(bgCol, fgCol, vec3(float(signedValue))), 1.0);
}
