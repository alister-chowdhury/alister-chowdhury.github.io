#version 300 es
uniform highp usampler2D lightOBBox;
uniform highp usampler2D lightingData;
uniform highp float invNumLights;
out vec2 localUv;
flat out float linemapV;
flat out vec4 colourAndDecayRate;
void main()
{
    int _125 = gl_VertexID / 6;
    int _128 = gl_VertexID % 6;
    int _308;
    do
    {
        if (_128 < 3)
        {
            _308 = _128;
            break;
        }
        _308 = _128 - 2;
        break;
    } while(false);
    ivec2 _135 = ivec2(_125, 0);
    uvec4 _137 = texelFetch(lightOBBox, _135, 0);
    uint _309;
    switch (_308)
    {
        case 0:
        {
            _309 = _137.x;
            break;
        }
        case 1:
        {
            _309 = _137.y;
            break;
        }
        case 2:
        {
            _309 = _137.w;
            break;
        }
        default:
        {
            _309 = _137.z;
            break;
        }
    }
    vec2 _161 = unpackHalf2x16(_309);
    gl_Position = vec4((_161 * 2.0) - vec2(1.0), 0.0, 1.0);
    uvec4 _242 = texelFetch(lightingData, _135, 0);
    uint _260 = _242.w;
    localUv = _161 - uintBitsToFloat(_242.xy);
    linemapV = (float(_125) + 0.5) * invNumLights;
    colourAndDecayRate = vec4(unpackHalf2x16((_260 >> 17u) & 32752u).x, unpackHalf2x16((_260 >> 6u) & 32752u).x, unpackHalf2x16((_260 << 5u) & 32736u).x, uintBitsToFloat(_242.z));
}
