#version 460 core

#include "common.glsli"


layout(binding=0)  uniform sampler2D noiseEnergyMap;
layout(location=0) uniform uvec3 maxSizeAndSeed;
layout(location=0) out vec2 outVoidData;


void main()
{
    uvec2 maxSize = maxSizeAndSeed.xy;
    uint seed = maxSizeAndSeed.z;

    uvec2 voidCoord = uvec2(0, 0);
    float voidValue = 1e+35;

    uvec2 start = min(uvec2(gl_FragCoord.xy) << 3u, maxSize - 1u);
    uvec2 end = min(start + uvec2(8u, 8u), maxSize);

    // Reduce 8x8 at a time, but mix up the order of comparison
    // to prevent biasing in any one location
    uint yh = simpleHash32(uvec3(start + 1u, seed)) >> 20u;
    uint xh = simpleHash32(uvec3(start + uvec2(13u, 11u), yh)) >> 19u;

    for(uint yit=0; yit < 8u; ++yit)
    {
        uint y = start.y + ((yh ^ yit) & 7u);
        if(y >= end.y) { continue; }

        for(uint xit=0; xit < 8u; ++xit)
        {
            uint x = start.x + ((xh ^ xit) & 7u);
            if(x >= end.x) { continue; }
            
            uvec2 coord = uvec2(x, y);
            vec2 noiseEnergy = texelFetch(noiseEnergyMap, ivec2(coord), 0).xy;
            if((noiseEnergy.x == 0) && (noiseEnergy.y < voidValue))
            {
                voidValue = noiseEnergy.y;
                voidCoord = coord;
            }
        }
    }

    outVoidData = vec2(voidValue,
                       uintBitsToFloat(voidCoord.x | (voidCoord.y << 16)));
}

