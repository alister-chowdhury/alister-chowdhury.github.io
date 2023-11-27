#version 300 es
precision highp float;
precision highp int;
uniform highp vec4 v1HybridParams;
uniform highp usampler2D v1DfTexture;
uniform highp sampler2D v1LinesBuffer;
uniform highp vec2 targetUV;
in highp vec2 uv;
layout(location = 0) out highp vec4 col;
void main()
{
    highp vec2 _450 = uv - targetUV;
    highp float _453 = length(_450);
    highp vec2 _458 = _450 / vec2(_453);
    bool _550 = min(targetUV.x, targetUV.y) <= 0.0;
    bool _560;
    if (!_550)
    {
        _560 = max(targetUV.x, targetUV.y) >= 1.0;
    }
    else
    {
        _560 = _550;
    }
    highp float _956;
    highp vec2 _964;
    if (_560)
    {
        highp vec2 _564 = vec2(1.0) / _458;
        highp vec2 _575 = (vec2(0.0, 1.0) - targetUV.xx) * _564.x;
        highp vec2 _586 = (vec2(0.0, 1.0) - targetUV.yy) * _564.y;
        highp vec2 _935;
        if (_575.x > _575.y)
        {
            _935 = _575.yx;
        }
        else
        {
            _935 = _575;
        }
        highp vec2 _936;
        if (_586.x > _586.y)
        {
            _936 = _586.yx;
        }
        else
        {
            _936 = _586;
        }
        highp float _618 = max(0.0, max(_935.x, _936.x));
        bool _624 = _618 < min(_935.y, _936.y);
        bool _635;
        if (_624)
        {
            _635 = (_618 * _618) < (_453 * _453);
        }
        else
        {
            _635 = _624;
        }
        highp float _958;
        highp vec2 _965;
        if (_635)
        {
            highp float _639 = _618 + 9.9999997473787516355514526367188e-06;
            _965 = targetUV + (_458 * _639);
            _958 = _639;
        }
        else
        {
            _965 = targetUV;
            _958 = 0.0;
        }
        _964 = _965;
        _956 = _958;
    }
    else
    {
        _964 = targetUV;
        _956 = 0.0;
    }
    highp vec2 _963;
    highp vec2 _1007;
    _963 = _964;
    _1007 = _458 * _453;
    uint _946;
    highp vec2 _1004;
    uint _1022;
    bool _1091;
    highp float _1104;
    highp vec2 _1110;
    uint _1116;
    bool _945 = false;
    uint _947 = 0u;
    highp float _955 = _956;
    uint _973 = 0u;
    for (;;)
    {
        if (!_945)
        {
            highp vec2 _962;
            _962 = _963;
            _946 = _947;
            highp float _704;
            uint _709;
            highp vec2 _714;
            uint _974;
            uint _980;
            uint _997;
            uint _1117;
            highp float _954 = _955;
            uint _972 = _973;
            uint _981 = 0u;
            uint _998 = 0u;
            for (;;)
            {
                if (_946 < 128u)
                {
                    bool _664 = _954 >= _453;
                    bool _674;
                    if (!_664)
                    {
                        _674 = min(_962.x, _962.y) < 0.0;
                    }
                    else
                    {
                        _674 = _664;
                    }
                    bool _684;
                    if (!_674)
                    {
                        _684 = max(_962.x, _962.y) > 1.0;
                    }
                    else
                    {
                        _684 = _674;
                    }
                    if (_684)
                    {
                        _1116 = _972;
                        _1110 = _962;
                        _1104 = _954;
                        _997 = _998;
                        _980 = _981;
                        break;
                    }
                    uvec4 _696 = texelFetch(v1DfTexture, ivec2(_962 * v1HybridParams.xx), 0);
                    uint _697 = _696.x;
                    highp float _701 = float(_697 & 255u) * 0.0039215688593685626983642578125;
                    _704 = _954 + _701;
                    uint _707 = (_697 >> uint(8)) & 255u;
                    _709 = _697 >> uint(16);
                    _714 = _962 + (_458 * _701);
                    if (_707 > 0u)
                    {
                        uint _719 = _697 >> 8u;
                        bool _722 = _972 == _719;
                        _1117 = _722 ? _972 : _719;
                        _974 = _722 ? 0u : _707;
                    }
                    else
                    {
                        _1117 = _972;
                        _974 = _707;
                    }
                    if (_974 > 0u)
                    {
                        _1116 = _1117;
                        _1110 = _714;
                        _1104 = _704;
                        _997 = _709;
                        _980 = _974;
                        break;
                    }
                    _972 = _1117;
                    _962 = _714;
                    _954 = _704;
                    _946++;
                    _998 = _709;
                    _981 = _974;
                    continue;
                }
                else
                {
                    _1116 = _972;
                    _1110 = _962;
                    _1104 = _954;
                    _997 = _998;
                    _980 = _981;
                    break;
                }
            }
            if (_980 == 0u)
            {
                _1022 = _946;
                break;
            }
            uint _749 = _997 + _980;
            _1004 = _1007;
            _1091 = _945;
            bool _1131;
            highp vec2 _1124;
            for (uint _1003 = _997; _1003 < _749; _1004 = _1124, _1003++, _1091 = _1131)
            {
                highp vec4 _761 = texelFetch(v1LinesBuffer, ivec2(int(_1003), 0), 0);
                highp vec2 _765 = -_1004;
                highp vec2 _772 = targetUV - _761.xy;
                highp float _774 = _765.x;
                highp float _776 = _761.w;
                highp float _779 = _765.y;
                highp float _781 = _761.z;
                highp float _783 = (_774 * _776) - (_779 * _781);
                highp float _785 = _772.x;
                highp float _790 = _772.y;
                uint _808 = floatBitsToUint(_783) & 2147483648u;
                highp float _813 = uintBitsToFloat(floatBitsToUint((_785 * _779) - (_790 * _774)) ^ _808);
                highp float _818 = uintBitsToFloat(floatBitsToUint((_785 * _776) - (_790 * _781)) ^ _808);
                bool _822 = min(_813, _818) > 0.0;
                bool _831;
                if (_822)
                {
                    _831 = max(_813, _818) < abs(_783);
                }
                else
                {
                    _831 = _822;
                }
                if (_831)
                {
                    _1124 = _1004 * (_818 / abs(_783));
                }
                else
                {
                    _1124 = _1004;
                }
                _1131 = _831 ? true : _1091;
            }
            _973 = _1116;
            _963 = _1110;
            _955 = _1104;
            _947 = _946;
            _945 = _1091;
            _1007 = _1004;
            continue;
        }
        else
        {
            _1022 = _947;
            break;
        }
    }
    highp float _475 = float(_1022) * 0.0625;
    col = vec4(_475, _475, _475, 1.0);
}
