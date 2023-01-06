#version 300 es
precision highp float;
precision highp int;
uniform highp sampler2D inVoidData;
uniform highp float value;
uniform highp vec4 textureSizeAndInvSize;
uniform highp float expMultiplier;
layout(location = 0) out highp vec2 outNoiseEnergy;
void main()
{
    highp vec2 _16 = floor(gl_FragCoord.xy);
    uint _36 = floatBitsToUint(texelFetch(inVoidData, ivec2(0), 0).y);
    highp vec2 _46 = vec2(float(_36 & 65535u), float(_36 >> uint(16)));
    highp vec2 _81 = (vec2(0.5) - abs(fract(abs(_16 - _46) * textureSizeAndInvSize.zw) - vec2(0.5))) * textureSizeAndInvSize.xy;
    outNoiseEnergy = vec2(all(equal(_46, _16)) ? value : 0.0, exp2((-dot(_81, _81)) * expMultiplier) * value);
}
