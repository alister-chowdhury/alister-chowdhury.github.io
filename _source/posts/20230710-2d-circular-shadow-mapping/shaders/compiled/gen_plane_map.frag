#version 300 es
precision highp float;
precision highp int;
uniform highp sampler2D v1LinesBvh;
uniform highp usampler2D lightingData;
in highp vec2 uv;
layout(location = 0) out highp vec4 outPlane;
vec4 _1513;
vec2 _1517;
ivec2 _1519;
vec2 _1772;
ivec2 _1773;
void main()
{
    highp vec2 _651 = uintBitsToFloat(texelFetch(lightingData, ivec2(int(gl_FragCoord.y), 0), 0).xy);
    highp float _558 = uv.x * 6.283185482025146484375;
    highp vec2 _564 = vec2(cos(_558), sin(_558));
    highp vec2 _726 = vec2(1.0) / _564;
    highp vec2 _1509;
    highp vec4 _1512;
    uint _1515;
    highp vec2 _1516;
    ivec2 _1518;
    _1518 = _1519;
    _1516 = _1517;
    _1515 = 4294967295u;
    _1512 = _1513;
    _1509 = _564 * 1.0;
    int _1335[16];
    highp vec2 _1599;
    highp vec4 _1610;
    highp float _1616;
    uint _1620;
    bool _1684;
    int _1707;
    highp vec2 _1754;
    ivec2 _1759;
    int _1763;
    bool _1505 = false;
    int _1507 = 0;
    highp float _1514 = 1.0;
    int _1657 = 0;
    for (; !_1505; _1657 = _1763, _1518 = _1759, _1516 = _1754, _1515 = _1620, _1514 = _1616, _1512 = _1610, _1509 = _1599, _1507 = _1707, _1505 = _1684)
    {
        highp vec4 _740 = texelFetch(v1LinesBvh, ivec2(_1507, 0), 0);
        highp vec4 _746 = texelFetch(v1LinesBvh, ivec2(_1507 + 1, 0), 0);
        highp vec4 _752 = texelFetch(v1LinesBvh, ivec2(_1507 + 2, 0), 0);
        bool _1527;
        highp vec2 _1534;
        highp vec4 _1545;
        highp float _1551;
        uint _1555;
        highp float _1561;
        int _1573;
        do
        {
            if (floatBitsToInt(_740.xy).x == 1)
            {
                highp vec2 _879 = -_1509;
                highp vec2 _886 = _651 - _746.xy;
                highp float _888 = _879.x;
                highp float _890 = _746.w;
                highp float _893 = _879.y;
                highp float _895 = _746.z;
                highp float _897 = (_888 * _890) - (_893 * _895);
                highp float _899 = _886.x;
                highp float _904 = _886.y;
                uint _922 = floatBitsToUint(_897) & 2147483648u;
                highp float _927 = uintBitsToFloat(floatBitsToUint((_899 * _893) - (_904 * _888)) ^ _922);
                highp float _932 = uintBitsToFloat(floatBitsToUint((_899 * _890) - (_904 * _895)) ^ _922);
                bool _936 = min(_927, _932) > 0.0;
                bool _945;
                if (_936)
                {
                    _945 = max(_927, _932) < abs(_897);
                }
                else
                {
                    _945 = _936;
                }
                highp vec2 _1535;
                highp float _1552;
                uint _1556;
                if (_945)
                {
                    highp vec2 _965 = _1509 * (_932 / abs(_897));
                    _1556 = floatBitsToUint(_740.y);
                    _1552 = dot(_965, _965);
                    _1535 = _965;
                }
                else
                {
                    _1556 = _1515;
                    _1552 = _1514;
                    _1535 = _1509;
                }
                bvec4 _1775 = bvec4(_945);
                _1573 = _1518.x;
                _1561 = _1516.x;
                _1555 = _1556;
                _1551 = _1552;
                _1545 = vec4(_1775.x ? _746.x : _1512.x, _1775.y ? _746.y : _1512.y, _1775.z ? _746.z : _1512.z, _1775.w ? _746.w : _1512.w);
                _1534 = _1535;
                _1527 = false;
                break;
            }
            highp vec2 _989 = (vec2(_746.xz) - _651.xx) * _726.x;
            highp vec2 _1000 = (vec2(_746.yw) - _651.yy) * _726.y;
            highp vec2 _1522;
            if (_989.x > _989.y)
            {
                _1522 = _989.yx;
            }
            else
            {
                _1522 = _989;
            }
            highp vec2 _1523;
            if (_1000.x > _1000.y)
            {
                _1523 = _1000.yx;
            }
            else
            {
                _1523 = _1000;
            }
            highp float _1032 = max(0.0, max(_1522.x, _1523.x));
            bool _1038 = _1032 < min(_1522.y, _1523.y);
            bool _1049;
            if (_1038)
            {
                _1049 = (_1032 * _1032) < _1514;
            }
            else
            {
                _1049 = _1038;
            }
            if (_1049)
            {
                _1573 = floatBitsToInt(_740.y);
                _1561 = _1032;
                _1555 = _1515;
                _1551 = _1514;
                _1545 = _1512;
                _1534 = _1509;
                _1527 = true;
                break;
            }
            _1573 = _1518.x;
            _1561 = _1516.x;
            _1555 = _1515;
            _1551 = _1514;
            _1545 = _1512;
            _1534 = _1509;
            _1527 = false;
            break;
        } while(false);
        highp vec2 _1446 = _1772;
        _1446.x = _1561;
        ivec2 _1448 = _1773;
        _1448.x = _1573;
        bool _1592;
        highp float _1626;
        int _1638;
        do
        {
            if (floatBitsToInt(_740.zw).x == 1)
            {
                highp vec2 _1089 = -_1534;
                highp vec2 _1096 = _651 - _752.xy;
                highp float _1098 = _1089.x;
                highp float _1100 = _752.w;
                highp float _1103 = _1089.y;
                highp float _1105 = _752.z;
                highp float _1107 = (_1098 * _1100) - (_1103 * _1105);
                highp float _1109 = _1096.x;
                highp float _1114 = _1096.y;
                uint _1132 = floatBitsToUint(_1107) & 2147483648u;
                highp float _1137 = uintBitsToFloat(floatBitsToUint((_1109 * _1103) - (_1114 * _1098)) ^ _1132);
                highp float _1142 = uintBitsToFloat(floatBitsToUint((_1109 * _1100) - (_1114 * _1105)) ^ _1132);
                bool _1146 = min(_1137, _1142) > 0.0;
                bool _1155;
                if (_1146)
                {
                    _1155 = max(_1137, _1142) < abs(_1107);
                }
                else
                {
                    _1155 = _1146;
                }
                highp vec2 _1600;
                highp float _1617;
                uint _1621;
                if (_1155)
                {
                    highp vec2 _1175 = _1534 * (_1142 / abs(_1107));
                    _1621 = floatBitsToUint(_740.w);
                    _1617 = dot(_1175, _1175);
                    _1600 = _1175;
                }
                else
                {
                    _1621 = _1555;
                    _1617 = _1551;
                    _1600 = _1534;
                }
                bvec4 _1777 = bvec4(_1155);
                _1638 = _1518.y;
                _1626 = _1516.y;
                _1620 = _1621;
                _1616 = _1617;
                _1610 = vec4(_1777.x ? _752.x : _1545.x, _1777.y ? _752.y : _1545.y, _1777.z ? _752.z : _1545.z, _1777.w ? _752.w : _1545.w);
                _1599 = _1600;
                _1592 = false;
                break;
            }
            highp vec2 _1199 = (vec2(_752.xz) - _651.xx) * _726.x;
            highp vec2 _1210 = (vec2(_752.yw) - _651.yy) * _726.y;
            highp vec2 _1587;
            if (_1199.x > _1199.y)
            {
                _1587 = _1199.yx;
            }
            else
            {
                _1587 = _1199;
            }
            highp vec2 _1588;
            if (_1210.x > _1210.y)
            {
                _1588 = _1210.yx;
            }
            else
            {
                _1588 = _1210;
            }
            highp float _1242 = max(0.0, max(_1587.x, _1588.x));
            bool _1248 = _1242 < min(_1587.y, _1588.y);
            bool _1259;
            if (_1248)
            {
                _1259 = (_1242 * _1242) < _1551;
            }
            else
            {
                _1259 = _1248;
            }
            if (_1259)
            {
                _1638 = floatBitsToInt(_740.w);
                _1626 = _1242;
                _1620 = _1555;
                _1616 = _1551;
                _1610 = _1545;
                _1599 = _1534;
                _1592 = true;
                break;
            }
            _1638 = _1518.y;
            _1626 = _1516.y;
            _1620 = _1555;
            _1616 = _1551;
            _1610 = _1545;
            _1599 = _1534;
            _1592 = false;
            break;
        } while(false);
        highp vec2 _1488 = _1446;
        _1488.y = _1626;
        ivec2 _1490 = _1448;
        _1490.y = _1638;
        if (_1527 && _1592)
        {
            ivec2 _1667;
            highp vec2 _1755;
            if (_1561 < _1626)
            {
                _1755 = _1488.yx;
                _1667 = _1490.yx;
            }
            else
            {
                _1755 = _1488;
                _1667 = _1490;
            }
            int _815 = _1657 + 1;
            _1335[_815] = _1667.x;
            _1763 = _815;
            _1759 = _1667;
            _1754 = _1755;
            _1707 = _1667.y;
            _1684 = _1505;
        }
        else
        {
            bool _1699;
            int _1708;
            int _1764;
            if (_1527)
            {
                _1764 = _1657;
                _1708 = _1573;
                _1699 = _1505;
            }
            else
            {
                bool _1700;
                int _1709;
                int _1765;
                if (_1592)
                {
                    _1765 = _1657;
                    _1709 = _1638;
                    _1700 = _1505;
                }
                else
                {
                    bool _834 = _1657 > 0;
                    int _1710;
                    int _1766;
                    if (_834)
                    {
                        _1766 = _1657 - 1;
                        _1710 = _1335[_1657];
                    }
                    else
                    {
                        _1766 = _1657;
                        _1710 = _1507;
                    }
                    _1765 = _1766;
                    _1709 = _1710;
                    _1700 = _834 ? _1505 : true;
                }
                _1764 = _1765;
                _1708 = _1709;
                _1699 = _1700;
            }
            _1763 = _1764;
            _1759 = _1490;
            _1754 = _1488;
            _1707 = _1708;
            _1684 = _1699;
        }
    }
    highp vec2 _1682;
    highp float _1683;
    if (_1515 != 4294967295u)
    {
        highp vec2 _587 = normalize(vec2(_1512.w, -_1512.z));
        uint _1274 = floatBitsToUint(dot(_587, _1512.xy - _651));
        uint _1275 = _1274 & 2147483648u;
        highp vec2 _1501 = _1772;
        _1501.x = uintBitsToFloat(floatBitsToUint(_587.x) ^ _1275);
        highp vec2 _1504 = _1501;
        _1504.y = uintBitsToFloat(floatBitsToUint(_587.y) ^ _1275);
        _1683 = uintBitsToFloat(_1274 ^ _1275);
        _1682 = _1504;
    }
    else
    {
        _1683 = 1.0;
        _1682 = _564;
    }
    outPlane = vec4((_1682 * 0.5) + vec2(0.5), _1683, 1.0);
}
