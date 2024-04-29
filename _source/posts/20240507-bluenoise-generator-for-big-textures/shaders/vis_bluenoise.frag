#version 460 core

#extension GL_EXT_samplerless_texture_functions : require

layout(binding = 0) uniform VisBlueNoiseParams_
{
    vec4 textureSizeAndInvSize;
};

layout(binding = 1) uniform texture2D blueNoiseTexture;


layout(location=0) in vec2 uv;
layout(location=0) out vec4 outCol;


void main()
{

#if TILE_SAMPLE
    ivec2 coord = ivec2(fract(gl_FragCoord.xy * textureSizeAndInvSize.zw) * textureSizeAndInvSize.xy);
#else // TILE_SAMPLE
    ivec2 coord = ivec2(uv * textureSizeAndInvSize.xy);
#endif // TILE_SAMPLE

    float value = texelFetch(blueNoiseTexture, coord, 0).x;
    outCol = vec4(value, value, value, 1);
}
