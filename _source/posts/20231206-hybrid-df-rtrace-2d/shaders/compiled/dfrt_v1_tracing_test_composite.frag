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
    highp float _958;
    highp vec2 _966;
    if (_560)
    {
        highp vec2 _564 = vec2(1.0) / _458;
        highp vec2 _575 = (vec2(0.0, 1.0) - targetUV.xx) * _564.x;
        highp vec2 _586 = (vec2(0.0, 1.0) - targetUV.yy) * _564.y;
        highp vec2 _937;
        if (_575.x > _575.y)
        {
            _937 = _575.yx;
        }
        else
        {
            _937 = _575;
        }
        highp vec2 _938;
        if (_586.x > _586.y)
        {
            _938 = _586.yx;
        }
        else
        {
            _938 = _586;
        }
        highp float _618 = max(0.0, max(_937.x, _938.x));
        bool _624 = _618 < min(_937.y, _938.y);
        bool _635;
        if (_624)
        {
            _635 = (_618 * _618) < (_453 * _453);
        }
        else
        {
            _635 = _624;
        }
        highp float _960;
        highp vec2 _967;
        if (_635)
        {
            highp float _639 = _618 + 9.9999997473787516355514526367188e-06;
            _967 = targetUV + (_458 * _639);
            _960 = _639;
        }
        else
        {
            _967 = targetUV;
            _960 = 0.0;
        }
        _966 = _967;
        _958 = _960;
    }
    else
    {
        _966 = targetUV;
        _958 = 0.0;
    }
    highp vec2 _965;
    uint _988;
    highp vec2 _1009;
    _988 = 0u;
    _965 = _966;
    _1009 = _458 * _453;
    uint _744;
    uint _948;
    highp vec2 _1006;
    uint _1024;
    bool _1076;
    bool _1085;
    bool _1093;
    highp float _1106;
    highp vec2 _1112;
    uint _1118;
    bool _947 = false;
    uint _949 = 0u;
    highp float _957 = _958;
    uint _975 = 0u;
    bool _1077 = true;
    for (;;)
    {
        if (!_947)
        {
            highp vec2 _964;
            _964 = _965;
            _948 = _949;
            highp float _704;
            uint _709;
            highp vec2 _714;
            uint _976;
            uint _982;
            uint _999;
            uint _1119;
            highp float _956 = _957;
            uint _974 = _975;
            uint _983 = 0u;
            uint _1000 = 0u;
            for (;;)
            {
                if (_948 < 128u)
                {
                    bool _664 = _956 >= _453;
                    bool _674;
                    if (!_664)
                    {
                        _674 = min(_964.x, _964.y) < 0.0;
                    }
                    else
                    {
                        _674 = _664;
                    }
                    bool _684;
                    if (!_674)
                    {
                        _684 = max(_964.x, _964.y) > 1.0;
                    }
                    else
                    {
                        _684 = _674;
                    }
                    if (_684)
                    {
                        _1118 = _974;
                        _1112 = _964;
                        _1106 = _956;
                        _1085 = false;
                        _999 = _1000;
                        _982 = _983;
                        break;
                    }
                    uvec4 _696 = texelFetch(v1DfTexture, ivec2(_964 * v1HybridParams.xx), 0);
                    uint _697 = _696.x;
                    highp float _701 = float(_697 & 255u) * 0.0039215688593685626983642578125;
                    _704 = _956 + _701;
                    uint _707 = (_697 >> uint(8)) & 255u;
                    _709 = _697 >> uint(16);
                    _714 = _964 + (_458 * _701);
                    if (_707 > 0u)
                    {
                        uint _719 = _697 >> 8u;
                        bool _722 = _974 == _719;
                        _1119 = _722 ? _974 : _719;
                        _976 = _722 ? 0u : _707;
                    }
                    else
                    {
                        _1119 = _974;
                        _976 = _707;
                    }
                    if (_976 > 0u)
                    {
                        _1118 = _1119;
                        _1112 = _714;
                        _1106 = _704;
                        _1085 = _1077;
                        _999 = _709;
                        _982 = _976;
                        break;
                    }
                    _974 = _1119;
                    _964 = _714;
                    _956 = _704;
                    _948++;
                    _1000 = _709;
                    _983 = _976;
                    continue;
                }
                else
                {
                    _1118 = _974;
                    _1112 = _964;
                    _1106 = _956;
                    _1085 = _1077;
                    _999 = _1000;
                    _982 = _983;
                    break;
                }
            }
            if (_982 == 0u)
            {
                _1076 = _1085;
                _1024 = _948;
                break;
            }
            _744 = _988 + _982;
            uint _749 = _999 + _982;
            _1006 = _1009;
            _1093 = _947;
            bool _1133;
            highp vec2 _1126;
            for (uint _1005 = _999; _1005 < _749; _1006 = _1126, _1005++, _1093 = _1133)
            {
                highp vec4 _761 = texelFetch(v1LinesBuffer, ivec2(int(_1005), 0), 0);
                highp vec2 _765 = -_1006;
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
                    _1126 = _1006 * (_818 / abs(_783));
                }
                else
                {
                    _1126 = _1006;
                }
                _1133 = _831 ? true : _1093;
            }
            _988 = _744;
            _975 = _1118;
            _965 = _1112;
            _957 = _1106;
            _949 = _948;
            _947 = _1093;
            _1077 = _1085;
            _1009 = _1006;
            continue;
        }
        else
        {
            _1076 = _1077;
            _1024 = _949;
            break;
        }
    }
    col = vec4(float(_1024) * 0.0625, float(_988) * 0.0625, float(!_1076), 1.0);
}
