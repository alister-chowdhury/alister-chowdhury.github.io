#version 300 es
precision highp float;
precision highp int;
uniform highp uvec3 maxSizeAndSeed;
uniform highp sampler2D noiseEnergyMap;
layout(location = 0) out highp vec2 outVoidData;
void main()
{
    uvec2 _82 = min((uvec2(gl_FragCoord.xy) << uvec2(3u)), (maxSizeAndSeed.xy - uvec2(1u)));
    uvec2 _89 = min((_82 + uvec2(8u)), maxSizeAndSeed.xy);
    uvec2 _93 = _82 + uvec2(1u);
    uint _101 = ((1405471321u ^ (((3041117094u ^ _93.x) * (1383044322u ^ _93.y)) >> 5u)) * (1953774619u ^ maxSizeAndSeed.z)) >> 20u;
    uvec2 _107 = _82 + uvec2(13u, 11u);
    uint _115 = ((1405471321u ^ (((3041117094u ^ _107.x) * (1383044322u ^ _107.y)) >> 5u)) * (1953774619u ^ _101)) >> 19u;
    highp float _286;
    uvec2 _287;
    _287 = uvec2(0u);
    _286 = 1.0000000409184787596297531937522e+35;
    highp float _298;
    uvec2 _299;
    for (uint _285 = 0u; _285 < 8u; _287 = _299, _286 = _298, _285++)
    {
        uint _133 = _82.y + ((_101 ^ _285) & 7u);
        if (_133 >= _89.y)
        {
            _299 = _287;
            _298 = _286;
            continue;
        }
        highp float _289;
        uvec2 _300;
        _289 = _286;
        _300 = _287;
        uvec2 _301;
        highp float _304;
        for (uint _288 = 0u; _288 < 8u; _289 = _304, _288++, _300 = _301)
        {
            uint _156 = _82.x + ((_115 ^ _288) & 7u);
            if (_156 >= _89.x)
            {
                _304 = _289;
                _301 = _300;
                continue;
            }
            uvec2 _167 = uvec2(_156, _133);
            highp vec4 _181 = texelFetch(noiseEnergyMap, ivec2(_167), 0);
            bool _186 = _181.x == 0.0;
            bool _193;
            if (_186)
            {
                _193 = _181.y < _289;
            }
            else
            {
                _193 = _186;
            }
            highp float _305;
            if (_193)
            {
                _305 = _181.y;
            }
            else
            {
                _305 = _289;
            }
            bvec2 _311 = bvec2(_193);
            _304 = _305;
            _301 = uvec2(_311.x ? _167.x : _300.x, _311.y ? _167.y : _300.y);
        }
        _299 = _300;
        _298 = _289;
    }
    outVoidData = vec2(_286, uintBitsToFloat(_287.x | (_287.y << uint(16))));
}
