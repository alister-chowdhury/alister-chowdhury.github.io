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
    highp float _955;
    highp vec2 _963;
    if (_560)
    {
        highp vec2 _564 = vec2(1.0) / _458;
        highp vec2 _575 = (vec2(0.0, 1.0) - targetUV.xx) * _564.x;
        highp vec2 _586 = (vec2(0.0, 1.0) - targetUV.yy) * _564.y;
        highp vec2 _934;
        if (_575.x > _575.y)
        {
            _934 = _575.yx;
        }
        else
        {
            _934 = _575;
        }
        highp vec2 _935;
        if (_586.x > _586.y)
        {
            _935 = _586.yx;
        }
        else
        {
            _935 = _586;
        }
        highp float _618 = max(0.0, max(_934.x, _935.x));
        bool _624 = _618 < min(_934.y, _935.y);
        bool _635;
        if (_624)
        {
            _635 = (_618 * _618) < (_453 * _453);
        }
        else
        {
            _635 = _624;
        }
        highp float _957;
        highp vec2 _964;
        if (_635)
        {
            highp float _639 = _618 + 9.9999997473787516355514526367188e-06;
            _964 = targetUV + (_458 * _639);
            _957 = _639;
        }
        else
        {
            _964 = targetUV;
            _957 = 0.0;
        }
        _963 = _964;
        _955 = _957;
    }
    else
    {
        _963 = targetUV;
        _955 = 0.0;
    }
    highp vec2 _962;
    highp vec2 _1006;
    _962 = _963;
    _1006 = _458 * _453;
    uint _945;
    highp vec2 _1003;
    bool _1073;
    bool _1082;
    bool _1090;
    highp float _1103;
    highp vec2 _1109;
    uint _1115;
    bool _944 = false;
    uint _946 = 0u;
    highp float _954 = _955;
    uint _972 = 0u;
    bool _1074 = true;
    for (;;)
    {
        if (!_944)
        {
            highp vec2 _961;
            _961 = _962;
            _945 = _946;
            highp float _704;
            uint _709;
            highp vec2 _714;
            uint _973;
            uint _979;
            uint _996;
            uint _1116;
            highp float _953 = _954;
            uint _971 = _972;
            uint _980 = 0u;
            uint _997 = 0u;
            for (;;)
            {
                if (_945 < 128u)
                {
                    bool _664 = _953 >= _453;
                    bool _674;
                    if (!_664)
                    {
                        _674 = min(_961.x, _961.y) < 0.0;
                    }
                    else
                    {
                        _674 = _664;
                    }
                    bool _684;
                    if (!_674)
                    {
                        _684 = max(_961.x, _961.y) > 1.0;
                    }
                    else
                    {
                        _684 = _674;
                    }
                    if (_684)
                    {
                        _1115 = _971;
                        _1109 = _961;
                        _1103 = _953;
                        _1082 = false;
                        _996 = _997;
                        _979 = _980;
                        break;
                    }
                    uvec4 _696 = texelFetch(v1DfTexture, ivec2(_961 * v1HybridParams.xx), 0);
                    uint _697 = _696.x;
                    highp float _701 = float(_697 & 255u) * 0.0039215688593685626983642578125;
                    _704 = _953 + _701;
                    uint _707 = (_697 >> uint(8)) & 255u;
                    _709 = _697 >> uint(16);
                    _714 = _961 + (_458 * _701);
                    if (_707 > 0u)
                    {
                        uint _719 = _697 >> 8u;
                        bool _722 = _971 == _719;
                        _1116 = _722 ? _971 : _719;
                        _973 = _722 ? 0u : _707;
                    }
                    else
                    {
                        _1116 = _971;
                        _973 = _707;
                    }
                    if (_973 > 0u)
                    {
                        _1115 = _1116;
                        _1109 = _714;
                        _1103 = _704;
                        _1082 = _1074;
                        _996 = _709;
                        _979 = _973;
                        break;
                    }
                    _971 = _1116;
                    _961 = _714;
                    _953 = _704;
                    _945++;
                    _997 = _709;
                    _980 = _973;
                    continue;
                }
                else
                {
                    _1115 = _971;
                    _1109 = _961;
                    _1103 = _953;
                    _1082 = _1074;
                    _996 = _997;
                    _979 = _980;
                    break;
                }
            }
            if (_979 == 0u)
            {
                _1073 = _1082;
                break;
            }
            uint _749 = _996 + _979;
            _1003 = _1006;
            _1090 = _944;
            bool _1129;
            highp vec2 _1123;
            for (uint _1002 = _996; _1002 < _749; _1003 = _1123, _1002++, _1090 = _1129)
            {
                highp vec4 _761 = texelFetch(v1LinesBuffer, ivec2(int(_1002), 0), 0);
                highp vec2 _765 = -_1003;
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
                    _1123 = _1003 * (_818 / abs(_783));
                }
                else
                {
                    _1123 = _1003;
                }
                _1129 = _831 ? true : _1090;
            }
            _972 = _1115;
            _962 = _1109;
            _954 = _1103;
            _946 = _945;
            _944 = _1090;
            _1074 = _1082;
            _1006 = _1003;
            continue;
        }
        else
        {
            _1073 = _1074;
            break;
        }
    }
    highp float _469 = float(!_1073);
    col = vec4(_469, _469, _469, 1.0);
}
