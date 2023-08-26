#version 300 es
precision highp float;
precision highp int;
uniform highp uint backgroundEnergySeed;
layout(location = 0) out highp vec2 outNoiseEnergy;
void main()
{
    uvec2 _103 = uvec2(gl_FragCoord.xy);
    outNoiseEnergy = vec2(0.0, uintBitsToFloat(((1405471321u ^ (((3041117094u ^ _103.x) * (1383044322u ^ _103.y)) >> 5u)) * (1953774619u ^ backgroundEnergySeed)) & 8388607u));
}
