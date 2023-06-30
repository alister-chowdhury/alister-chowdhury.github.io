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
    highp float _369 = 0.5 * uintBitsToFloat(2130706432u - floatBitsToUint(float(textureSize(lightPlaneMap, 0).x)));
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
    highp vec4 _437 = texture(lightPlaneMap, vec2(uintBitsToFloat(floatBitsToUint(_720) ^ (floatBitsToUint(localUv.y) & 2147483648u)), linemapV));
    highp vec2 _443 = (_437.xy * 2.0) - vec2(1.0);
    highp vec3 _713 = _725;
    _713.x = _443.x;
    highp vec3 _715 = _713;
    _715.y = _443.y;
    highp float _662 = _437.z;
    outCol = vec4((colourAndDecayRate.xyz * pow(length(localUv) + 1.0, -colourAndDecayRate.w)) * (1.0 - smoothstep(_662 - _369, _662 + _369, dot(localUv, _715.xy))), 0.0);
}
