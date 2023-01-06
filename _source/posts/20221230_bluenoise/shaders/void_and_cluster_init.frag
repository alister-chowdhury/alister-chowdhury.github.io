#version 460 core

#include "common.glsli"

layout(location=0) uniform uint backgroundEnergySeed;   // Used to populate the energy with
                                                        // a bit of random variance, to make
                                                        // void and clusters choice when filling
                                                        // the otherwise same value a bit more
                                                        // unpredictable.

layout(location=0) out vec2 outNoiseEnergy;


// Uses the last 23bits to construct a (non-linear) range
// [0, 1.08420210e-19]
float backgroundEnergyBounded(uint Seed)
{
    return uintBitsToFloat(Seed & 0x1fffffffu);
}


float getBackgroundEnergy()
{
    uint S = simpleHash32(uvec3(uvec2(gl_FragCoord.xy), backgroundEnergySeed));
    return backgroundEnergyBounded(S);
}


void main()
{
    float noise = 0.;
    float energy = getBackgroundEnergy();
    outNoiseEnergy = vec2(0, energy);
}
