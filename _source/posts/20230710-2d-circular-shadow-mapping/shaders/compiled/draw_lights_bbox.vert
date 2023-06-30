#version 300 es
uniform highp sampler2D lightBBox;
uniform highp usampler2D lightingData;
uniform highp float invNumLights;
out vec2 localUv;
flat out float linemapV;
flat out vec4 colourAndDecayRate;
void main()
{
    int _125 = gl_VertexID / 6;
    int _128 = gl_VertexID % 6;
    int _315;
    do
    {
        if (_128 < 3)
        {
            _315 = _128;
            break;
        }
        _315 = _128 - 2;
        break;
    } while(false);
    ivec2 _140 = ivec2(_125, 0);
    vec4 _142 = texelFetch(lightBBox, _140, 0);
    float _316;
    if ((_315 & 1) == 0)
    {
        _316 = _142.x;
    }
    else
    {
        _316 = _142.z;
    }
    float _317;
    if ((_315 & 2) == 0)
    {
        _317 = _142.y;
    }
    else
    {
        _317 = _142.w;
    }
    vec2 _169 = vec2(_316, _317);
    gl_Position = vec4((_169 * 2.0) - vec2(1.0), 0.0, 1.0);
    uvec4 _249 = texelFetch(lightingData, _140, 0);
    uint _267 = _249.w;
    localUv = _169 - uintBitsToFloat(_249.xy);
    linemapV = (float(_125) + 0.5) * invNumLights;
    colourAndDecayRate = vec4(unpackHalf2x16((_267 >> 17u) & 32752u).x, unpackHalf2x16((_267 >> 6u) & 32752u).x, unpackHalf2x16((_267 << 5u) & 32736u).x, uintBitsToFloat(_249.z));
}
