#version 300 es
precision highp float;
precision highp int;
uniform highp vec4 textureSizeAndInvSize;
uniform highp sampler2D noiseEnergy;
layout(location = 0) out highp vec4 outCol;
void main()
{
    outCol = vec4(texelFetch(noiseEnergy, ivec2(fract(gl_FragCoord.xy * textureSizeAndInvSize.zw) * textureSizeAndInvSize.xy), 0).xxx, 1.0);
}
