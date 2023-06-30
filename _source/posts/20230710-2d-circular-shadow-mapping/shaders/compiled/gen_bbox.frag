#version 300 es
precision highp float;
precision highp int;
uniform highp usampler2D lightingData;
uniform highp sampler2D lightPlaneMap;
layout(location = 0) out highp vec4 outBBox;
vec3 _433;
void main()
{
    int _160 = int(gl_FragCoord.x);
    highp vec2 _296 = uintBitsToFloat(texelFetch(lightingData, ivec2(_160, 0), 0).xy);
    ivec2 _180 = textureSize(lightPlaneMap, 0);
    int _181 = _180.x;
    highp float _188 = uintBitsToFloat(2130706432u - floatBitsToUint(float(_181))) * 6.283185482025146484375;
    highp vec2 _420;
    highp vec2 _421;
    _421 = vec2(-65504.0);
    _420 = vec2(65504.0);
    highp vec2 _246;
    highp vec2 _251;
    for (int _419 = 0; _419 < _181; _421 = _251, _420 = _246, _419++)
    {
        highp vec2 _346;
        highp vec4 _204 = texelFetch(lightPlaneMap, ivec2(_419, _160), 0);
        highp vec2 _212 = (_204.xy * 2.0) - vec2(1.0);
        highp vec3 _414 = _433;
        _414.x = _212.x;
        highp vec3 _416 = _414;
        _416.y = _212.y;
        highp float _220 = float(_419);
        highp float _223 = (_220 - 1.0) * _188;
        highp float _229 = (_220 + 1.0) * _188;
        highp vec2 _422;
        do
        {
            highp vec2 _344 = vec2(cos(_223), sin(_223));
            _346 = _416.xy;
            highp float _348 = dot(_346, _344);
            if (abs(_348) <= 0.01745240576565265655517578125)
            {
                _422 = vec2(0.0);
                break;
            }
            _422 = _344 * (_204.z / _348);
            break;
        } while(false);
        highp vec2 _423;
        do
        {
            highp vec2 _377 = vec2(cos(_229), sin(_229));
            highp float _381 = dot(_346, _377);
            if (abs(_381) <= 0.01745240576565265655517578125)
            {
                _423 = vec2(0.0);
                break;
            }
            _423 = _377 * (_204.z / _381);
            break;
        } while(false);
        _246 = min(min(_422, _423), _420);
        _251 = max(max(_422, _423), _421);
    }
    outBBox = vec4(_420 + _296, _421 + _296);
}
