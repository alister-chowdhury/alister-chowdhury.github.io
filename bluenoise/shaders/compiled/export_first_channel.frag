#version 300 es
precision highp float;
precision highp int;
uniform highp sampler2D inTexture;
layout(location = 0) out highp float outValue;
void main()
{
    outValue = texelFetch(inTexture, ivec2(gl_FragCoord.xy), 0).x;
}
