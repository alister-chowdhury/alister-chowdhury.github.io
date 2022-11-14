
#version 460 core

layout(binding=0)  uniform sampler2D inTexture;
layout(location=0) out float outValue;


void main()
{
    outValue = texelFetch(inTexture, ivec2(gl_FragCoord.xy), 0).x;
}
