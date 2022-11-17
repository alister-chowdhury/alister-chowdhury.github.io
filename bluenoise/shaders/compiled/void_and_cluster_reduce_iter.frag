#version 300 es
precision highp float;
precision highp int;
uniform highp uvec3 maxSizeAndSeed;
uniform highp sampler2D inVoidData;
layout(location = 0) out highp vec2 outVoidData;
void main()
{
    uvec2 _82 = min((uvec2(gl_FragCoord.xy) << uvec2(3u)), (maxSizeAndSeed.xy - uvec2(1u)));
    uvec2 _89 = min((_82 + uvec2(8u)), maxSizeAndSeed.xy);
    uvec2 _93 = _82 + uvec2(1u);
    uint _101 = ((1405471321u ^ (((3041117094u ^ _93.x) * (1383044322u ^ _93.y)) >> 5u)) * (1953774619u ^ maxSizeAndSeed.z)) >> 19u;
    uvec2 _105 = _82 + uvec2(3u, 5u);
    uint _113 = ((1405471321u ^ (((3041117094u ^ _105.x) * (1383044322u ^ _105.y)) >> 5u)) * (1953774619u ^ _101)) >> 20u;
    highp float _268;
    highp float _269;
    _269 = 0.0;
    _268 = 1.0000000409184787596297531937522e+35;
    highp float _278;
    highp float _279;
    for (uint _267 = 0u; _267 < 8u; _269 = _279, _268 = _278, _267++)
    {
        uint _131 = _82.y + ((_101 ^ _267) & 7u);
        if (_131 >= _89.y)
        {
            _279 = _269;
            _278 = _268;
            continue;
        }
        highp float _271;
        highp float _280;
        _271 = _268;
        _280 = _269;
        highp float _281;
        highp float _283;
        for (uint _270 = 0u; _270 < 8u; _271 = _283, _270++, _280 = _281)
        {
            uint _154 = _82.x + ((_113 ^ _270) & 7u);
            if (_154 >= _89.x)
            {
                _283 = _271;
                _281 = _280;
                continue;
            }
            highp vec4 _178 = texelFetch(inVoidData, ivec2(int(_154), int(_131)), 0);
            highp float _181 = _178.x;
            bool _183 = _181 < _271;
            highp float _282;
            if (_183)
            {
                _282 = _178.y;
            }
            else
            {
                _282 = _280;
            }
            _283 = _183 ? _181 : _271;
            _281 = _282;
        }
        _279 = _280;
        _278 = _271;
    }
    outVoidData = vec2(_268, _269);
}
