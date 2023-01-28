
#version 460 core

layout(binding=0)  uniform sampler2D inVoidData;
layout(location=0) uniform vec4 textureSizeAndInvSize;
layout(location=1) uniform float expMultiplier; // sigma^-2 * log2(e)
layout(location=2) uniform float value;

layout(location=0) out vec2 outNoiseEnergy;


void main()
{

    vec2 coord = vec2(floor(gl_FragCoord.xy));
    uint packedVoidCoord = floatBitsToUint(texelFetch(inVoidData, ivec2(0, 0), 0).y);
    vec2 target = vec2(packedVoidCoord & 0xffff, packedVoidCoord >> 16);

    float noise = all(equal(target, coord)) ? value : 0;

    // Wrap around logic
    vec2 delta = fract(abs(coord - target) * textureSizeAndInvSize.zw);
    delta = 0.5 - abs(delta - 0.5);
    delta *= textureSizeAndInvSize.xy;

    float energy = exp2(-dot(delta, delta) * expMultiplier) * value;

    outNoiseEnergy = vec2(noise, energy);
}

