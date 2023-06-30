#version 300 es
precision highp float;
precision highp int;
uniform highp sampler2D lightPlaneMap;
flat in highp float linemapV;
in highp vec2 localUv;
flat in highp vec4 colourAndDecayRate;
layout(location = 0) out highp vec4 outCol;
vec3 _725;
void main()
{
    ivec2 _362 = textureSize(lightPlaneMap, 0);
    int _365 = _362.x;
    highp float _366 = float(_365);
    highp float _369 = 0.5 * uintBitsToFloat(2130706432u - floatBitsToUint(_366));
    highp float _482 = abs(localUv.x);
    highp float _484 = abs(localUv.y);
    highp float _491 = min(_482, _484) / max(_482, _484);
    highp float _494 = _491 * _491;
    highp float _504 = (((((0.013506161980330944061279296875 * _494) + (-0.046842403709888458251953125)) * _494) + (-0.8414151668548583984375)) * _491) + _491;
    highp float _719;
    if (_484 > _482)
    {
        _719 = 0.25 - _504;
    }
    else
    {
        _719 = _504;
    }
    highp float _720;
    if (localUv.x < 0.0)
    {
        _720 = 0.5 - _719;
    }
    else
    {
        _720 = _719;
    }
    highp float _557 = ((uintBitsToFloat(floatBitsToUint(_720) ^ (floatBitsToUint(localUv.y) & 2147483648u)) + 1.0) * _366) - 0.5;
    int _564 = int(linemapV * float(_362.y));
    int _566 = int(_557);
    int _571 = _365 - 1;
    highp vec4 _584 = texelFetch(lightPlaneMap, ivec2(_566 & _571, _564), 0);
    highp vec4 _591 = texelFetch(lightPlaneMap, ivec2((_566 + 1) & _571, _564), 0);
    highp vec2 _597 = (_584.xy * 2.0) - vec2(1.0);
    highp vec3 _701 = _725;
    _701.x = _597.x;
    highp vec3 _703 = _701;
    _703.y = _597.y;
    highp vec2 _606 = (_591.xy * 2.0) - vec2(1.0);
    highp vec3 _705 = _725;
    _705.x = _606.x;
    highp vec3 _707 = _705;
    _707.y = _606.y;
    highp float _630 = _584.z;
    highp float _646 = _591.z;
    outCol = vec4((colourAndDecayRate.xyz * pow(length(localUv) + 1.0, -colourAndDecayRate.w)) * mix(1.0 - smoothstep(_630 - _369, _630 + _369, dot(localUv, _703.xy)), 1.0 - smoothstep(_646 - _369, _646 + _369, dot(localUv, _707.xy)), smoothstep(0.0, 1.0, fract(_557))), 0.0);
}
