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
    bool _570 = min(targetUV.x, targetUV.y) <= 0.0;
    bool _580;
    if (!_570)
    {
        _580 = max(targetUV.x, targetUV.y) >= 1.0;
    }
    else
    {
        _580 = _570;
    }
    highp float _975;
    highp vec2 _983;
    if (_580)
    {
        highp vec2 _584 = vec2(1.0) / _458;
        highp vec2 _595 = (vec2(0.0, 1.0) - targetUV.xx) * _584.x;
        highp vec2 _606 = (vec2(0.0, 1.0) - targetUV.yy) * _584.y;
        highp vec2 _954;
        if (_595.x > _595.y)
        {
            _954 = _595.yx;
        }
        else
        {
            _954 = _595;
        }
        highp vec2 _955;
        if (_606.x > _606.y)
        {
            _955 = _606.yx;
        }
        else
        {
            _955 = _606;
        }
        highp float _638 = max(0.0, max(_954.x, _955.x));
        bool _644 = _638 < min(_954.y, _955.y);
        bool _655;
        if (_644)
        {
            _655 = (_638 * _638) < (_453 * _453);
        }
        else
        {
            _655 = _644;
        }
        highp float _977;
        highp vec2 _984;
        if (_655)
        {
            highp float _659 = _638 + 9.9999997473787516355514526367188e-06;
            _984 = targetUV + (_458 * _659);
            _977 = _659;
        }
        else
        {
            _984 = targetUV;
            _977 = 0.0;
        }
        _983 = _984;
        _975 = _977;
    }
    else
    {
        _983 = targetUV;
        _975 = 0.0;
    }
    highp vec2 _982;
    highp vec2 _1026;
    _982 = _983;
    _1026 = _458 * _453;
    uint _965;
    highp vec2 _1023;
    bool _1093;
    bool _1102;
    bool _1110;
    highp float _1123;
    highp vec2 _1129;
    uint _1135;
    bool _964 = false;
    uint _966 = 0u;
    highp float _974 = _975;
    uint _992 = 0u;
    bool _1094 = true;
    for (;;)
    {
        if (!_964)
        {
            highp vec2 _981;
            _981 = _982;
            _965 = _966;
            highp float _724;
            uint _729;
            highp vec2 _734;
            uint _993;
            uint _999;
            uint _1016;
            uint _1136;
            highp float _973 = _974;
            uint _991 = _992;
            uint _1000 = 0u;
            uint _1017 = 0u;
            for (;;)
            {
                if (_965 < 128u)
                {
                    bool _684 = _973 >= _453;
                    bool _694;
                    if (!_684)
                    {
                        _694 = min(_981.x, _981.y) < 0.0;
                    }
                    else
                    {
                        _694 = _684;
                    }
                    bool _704;
                    if (!_694)
                    {
                        _704 = max(_981.x, _981.y) > 1.0;
                    }
                    else
                    {
                        _704 = _694;
                    }
                    if (_704)
                    {
                        _1135 = _991;
                        _1129 = _981;
                        _1123 = _973;
                        _1102 = false;
                        _1016 = _1017;
                        _999 = _1000;
                        break;
                    }
                    uvec4 _716 = texelFetch(v1DfTexture, ivec2(_981 * v1HybridParams.xx), 0);
                    uint _717 = _716.x;
                    highp float _721 = float(_717 & 255u) * 0.0039215688593685626983642578125;
                    _724 = _973 + _721;
                    uint _727 = (_717 >> uint(8)) & 255u;
                    _729 = _717 >> uint(16);
                    _734 = _981 + (_458 * _721);
                    if (_727 > 0u)
                    {
                        uint _739 = _717 >> 8u;
                        bool _742 = _991 == _739;
                        _1136 = _742 ? _991 : _739;
                        _993 = _742 ? 0u : _727;
                    }
                    else
                    {
                        _1136 = _991;
                        _993 = _727;
                    }
                    if (_993 > 0u)
                    {
                        _1135 = _1136;
                        _1129 = _734;
                        _1123 = _724;
                        _1102 = _1094;
                        _1016 = _729;
                        _999 = _993;
                        break;
                    }
                    _991 = _1136;
                    _981 = _734;
                    _973 = _724;
                    _965++;
                    _1017 = _729;
                    _1000 = _993;
                    continue;
                }
                else
                {
                    _1135 = _991;
                    _1129 = _981;
                    _1123 = _973;
                    _1102 = _1094;
                    _1016 = _1017;
                    _999 = _1000;
                    break;
                }
            }
            if (_999 == 0u)
            {
                _1093 = _1102;
                break;
            }
            uint _769 = _1016 + _999;
            _1023 = _1026;
            _1110 = _964;
            bool _1149;
            highp vec2 _1143;
            for (uint _1022 = _1016; _1022 < _769; _1023 = _1143, _1022++, _1110 = _1149)
            {
                highp vec4 _781 = texelFetch(v1LinesBuffer, ivec2(int(_1022), 0), 0);
                highp vec2 _785 = -_1023;
                highp vec2 _792 = targetUV - _781.xy;
                highp float _794 = _785.x;
                highp float _796 = _781.w;
                highp float _799 = _785.y;
                highp float _801 = _781.z;
                highp float _803 = (_794 * _796) - (_799 * _801);
                highp float _805 = _792.x;
                highp float _810 = _792.y;
                uint _828 = floatBitsToUint(_803) & 2147483648u;
                highp float _833 = uintBitsToFloat(floatBitsToUint((_805 * _799) - (_810 * _794)) ^ _828);
                highp float _838 = uintBitsToFloat(floatBitsToUint((_805 * _796) - (_810 * _801)) ^ _828);
                bool _842 = min(_833, _838) > 0.0;
                bool _851;
                if (_842)
                {
                    _851 = max(_833, _838) < abs(_803);
                }
                else
                {
                    _851 = _842;
                }
                if (_851)
                {
                    _1143 = _1023 * (_838 / abs(_803));
                }
                else
                {
                    _1143 = _1023;
                }
                _1149 = _851 ? true : _1110;
            }
            _992 = _1135;
            _982 = _1129;
            _974 = _1123;
            _966 = _965;
            _964 = _1110;
            _1094 = _1102;
            _1026 = _1023;
            continue;
        }
        else
        {
            _1093 = _1094;
            break;
        }
    }
    col = vec4((normalize(vec3(targetUV, length(targetUV))) * float(!_1093)) * pow(_453 + 1.0, -10.0), 1.0);
}
