#version 300 es
precision highp float;
precision highp int;
const uint _42[16] = uint[](496684590u, 140644494u, 487854175u, 1057374766u, 588839440u, 1041744399u, 1008191022u, 1057230980u, 488064558u, 488176142u, 15268910u, 198u, 145536u, 14336u, 11512810u, 0u);
uniform highp uint encodedNumber;
uniform highp vec3 bgCol;
uniform highp vec3 fgCol;
in highp vec2 uv;
layout(location = 0) out highp vec4 outCol;
void main()
{
    highp float _169 = uv.x * 8.0;
    highp float _181 = fract(_169) * 1.2000000476837158203125;
    highp vec2 _241 = uv;
    _241.x = _181;
    uint _248;
    do
    {
        bool _194 = _181 < 0.0;
        bool _201;
        if (!_194)
        {
            _201 = uv.y < 0.0;
        }
        else
        {
            _201 = _194;
        }
        bool _208;
        if (!_201)
        {
            _208 = _181 >= 1.0;
        }
        else
        {
            _208 = _201;
        }
        bool _215;
        if (!_208)
        {
            _215 = uv.y >= 1.0;
        }
        else
        {
            _215 = _208;
        }
        if (_215)
        {
            _248 = 0u;
            break;
        }
        uvec2 _220 = uvec2(_241 * vec2(5.0, 6.0));
        _248 = (_42[(encodedNumber >> (uint(_169) * 4u)) & 15u] >> ((_220.y * 5u) + _220.x)) & 1u;
        break;
    } while(false);
    outCol = vec4(mix(bgCol, fgCol, vec3(float(_248))), 1.0);
}
