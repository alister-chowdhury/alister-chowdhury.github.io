#version 460 core

#include "common.glsli"


layout(binding=0)  uniform sampler2D inVoidData;
layout(location=0) uniform uvec3 maxSizeAndSeed;
layout(location=0) out vec2 outVoidData;


void main()
{
    uvec2 maxSize = maxSizeAndSeed.xy;
    uint seed = maxSizeAndSeed.z;

    float packedVoidCoord = 0;
    float voidValue = 1e+35;

    uvec2 start = min(uvec2(gl_FragCoord.xy) << 3u, maxSize - 1u);
    uvec2 end = min(start + uvec2(8u, 8u), maxSize);

    // Reduce 8x8 at a time, but mix up the order of comparison
    // to prevent biasing in any one location (wont be cache friendly)
    uint yh = simpleHash32(uvec3(start + 1u, seed)) >> 19u;
    uint xh = simpleHash32(uvec3(start + uvec2(3u, 5u), yh)) >> 20u;

    for(uint yit=0; yit < 8u; ++yit)
    {
        uint y = start.y + ((yh ^ yit) & 7u);
        if(y >= end.y) { continue; }

        for(uint xit=0; xit < 8u; ++xit)
        {
            uint x = start.x + ((xh ^ xit) & 7u);
            if(x >= end.x) { continue; }
            
            vec2 packedData = texelFetch(inVoidData, ivec2(x, y), 0).xy;
            if(packedData.x < voidValue)
            {
                voidValue = packedData.x;
                packedVoidCoord = packedData.y;
            }
        }
    }

    outVoidData = vec2(voidValue, packedVoidCoord);
}

