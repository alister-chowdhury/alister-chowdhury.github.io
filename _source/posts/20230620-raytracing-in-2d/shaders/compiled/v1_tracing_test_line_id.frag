#version 300 es
precision highp float;
precision highp int;
uniform highp sampler2D v1LinesBvh;
uniform highp vec2 targetUV;
in highp vec2 uv;
layout(location = 0) out highp vec4 col;
vec2 _1422;
ivec2 _1424;
vec2 _1676;
ivec2 _1677;
void main()
{
    highp vec2 _531 = uv - targetUV;
    highp float _534 = length(_531);
    highp vec2 _539 = _531 / vec2(_534);
    highp float _618 = _534 * _534;
    highp vec2 _629 = vec2(1.0) / _539;
    highp vec2 _1414;
    uint _1420;
    highp vec2 _1421;
    ivec2 _1423;
    _1423 = _1424;
    _1421 = _1422;
    _1420 = 4294967295u;
    _1414 = _539 * _534;
    int _1267[16];
    highp vec2 _1504;
    highp float _1521;
    uint _1525;
    bool _1587;
    int _1610;
    highp vec2 _1657;
    ivec2 _1662;
    int _1666;
    bool _1410 = false;
    int _1412 = 0;
    highp float _1419 = _618;
    int _1562 = 0;
    for (; !_1410; _1562 = _1666, _1423 = _1662, _1421 = _1657, _1420 = _1525, _1419 = _1521, _1414 = _1504, _1412 = _1610, _1410 = _1587)
    {
        highp vec4 _643 = texelFetch(v1LinesBvh, ivec2(_1412, 0), 0);
        highp vec4 _649 = texelFetch(v1LinesBvh, ivec2(_1412 + 1, 0), 0);
        highp vec4 _655 = texelFetch(v1LinesBvh, ivec2(_1412 + 2, 0), 0);
        bool _1432;
        highp vec2 _1439;
        highp float _1456;
        uint _1460;
        highp float _1466;
        int _1478;
        do
        {
            if (floatBitsToInt(_643.xy).x == 1)
            {
                highp vec2 _782 = -_1414;
                highp vec2 _789 = targetUV - _649.xy;
                highp float _791 = _782.x;
                highp float _793 = _649.w;
                highp float _796 = _782.y;
                highp float _798 = _649.z;
                highp float _800 = (_791 * _793) - (_796 * _798);
                highp float _802 = _789.x;
                highp float _807 = _789.y;
                uint _825 = floatBitsToUint(_800) & 2147483648u;
                highp float _830 = uintBitsToFloat(floatBitsToUint((_802 * _796) - (_807 * _791)) ^ _825);
                highp float _835 = uintBitsToFloat(floatBitsToUint((_802 * _793) - (_807 * _798)) ^ _825);
                bool _839 = min(_830, _835) > 0.0;
                bool _848;
                if (_839)
                {
                    _848 = max(_830, _835) < abs(_800);
                }
                else
                {
                    _848 = _839;
                }
                highp vec2 _1440;
                highp float _1457;
                uint _1461;
                if (_848)
                {
                    highp vec2 _868 = _1414 * (_835 / abs(_800));
                    _1461 = floatBitsToUint(_643.y);
                    _1457 = dot(_868, _868);
                    _1440 = _868;
                }
                else
                {
                    _1461 = _1420;
                    _1457 = _1419;
                    _1440 = _1414;
                }
                _1478 = _1423.x;
                _1466 = _1421.x;
                _1460 = _1461;
                _1456 = _1457;
                _1439 = _1440;
                _1432 = false;
                break;
            }
            highp vec2 _892 = (vec2(_649.xz) - targetUV.xx) * _629.x;
            highp vec2 _903 = (vec2(_649.yw) - targetUV.yy) * _629.y;
            highp vec2 _1427;
            if (_892.x > _892.y)
            {
                _1427 = _892.yx;
            }
            else
            {
                _1427 = _892;
            }
            highp vec2 _1428;
            if (_903.x > _903.y)
            {
                _1428 = _903.yx;
            }
            else
            {
                _1428 = _903;
            }
            highp float _935 = max(0.0, max(_1427.x, _1428.x));
            bool _941 = _935 < min(_1427.y, _1428.y);
            bool _952;
            if (_941)
            {
                _952 = (_935 * _935) < _1419;
            }
            else
            {
                _952 = _941;
            }
            if (_952)
            {
                _1478 = floatBitsToInt(_643.y);
                _1466 = _935;
                _1460 = _1420;
                _1456 = _1419;
                _1439 = _1414;
                _1432 = true;
                break;
            }
            _1478 = _1423.x;
            _1466 = _1421.x;
            _1460 = _1420;
            _1456 = _1419;
            _1439 = _1414;
            _1432 = false;
            break;
        } while(false);
        highp vec2 _1359 = _1676;
        _1359.x = _1466;
        ivec2 _1361 = _1677;
        _1361.x = _1478;
        bool _1497;
        highp float _1531;
        int _1543;
        do
        {
            if (floatBitsToInt(_643.zw).x == 1)
            {
                highp vec2 _992 = -_1439;
                highp vec2 _999 = targetUV - _655.xy;
                highp float _1001 = _992.x;
                highp float _1003 = _655.w;
                highp float _1006 = _992.y;
                highp float _1008 = _655.z;
                highp float _1010 = (_1001 * _1003) - (_1006 * _1008);
                highp float _1012 = _999.x;
                highp float _1017 = _999.y;
                uint _1035 = floatBitsToUint(_1010) & 2147483648u;
                highp float _1040 = uintBitsToFloat(floatBitsToUint((_1012 * _1006) - (_1017 * _1001)) ^ _1035);
                highp float _1045 = uintBitsToFloat(floatBitsToUint((_1012 * _1003) - (_1017 * _1008)) ^ _1035);
                bool _1049 = min(_1040, _1045) > 0.0;
                bool _1058;
                if (_1049)
                {
                    _1058 = max(_1040, _1045) < abs(_1010);
                }
                else
                {
                    _1058 = _1049;
                }
                highp vec2 _1505;
                highp float _1522;
                uint _1526;
                if (_1058)
                {
                    highp vec2 _1078 = _1439 * (_1045 / abs(_1010));
                    _1526 = floatBitsToUint(_643.w);
                    _1522 = dot(_1078, _1078);
                    _1505 = _1078;
                }
                else
                {
                    _1526 = _1460;
                    _1522 = _1456;
                    _1505 = _1439;
                }
                _1543 = _1423.y;
                _1531 = _1421.y;
                _1525 = _1526;
                _1521 = _1522;
                _1504 = _1505;
                _1497 = false;
                break;
            }
            highp vec2 _1102 = (vec2(_655.xz) - targetUV.xx) * _629.x;
            highp vec2 _1113 = (vec2(_655.yw) - targetUV.yy) * _629.y;
            highp vec2 _1492;
            if (_1102.x > _1102.y)
            {
                _1492 = _1102.yx;
            }
            else
            {
                _1492 = _1102;
            }
            highp vec2 _1493;
            if (_1113.x > _1113.y)
            {
                _1493 = _1113.yx;
            }
            else
            {
                _1493 = _1113;
            }
            highp float _1145 = max(0.0, max(_1492.x, _1493.x));
            bool _1151 = _1145 < min(_1492.y, _1493.y);
            bool _1162;
            if (_1151)
            {
                _1162 = (_1145 * _1145) < _1456;
            }
            else
            {
                _1162 = _1151;
            }
            if (_1162)
            {
                _1543 = floatBitsToInt(_643.w);
                _1531 = _1145;
                _1525 = _1460;
                _1521 = _1456;
                _1504 = _1439;
                _1497 = true;
                break;
            }
            _1543 = _1423.y;
            _1531 = _1421.y;
            _1525 = _1460;
            _1521 = _1456;
            _1504 = _1439;
            _1497 = false;
            break;
        } while(false);
        highp vec2 _1401 = _1359;
        _1401.y = _1531;
        ivec2 _1403 = _1361;
        _1403.y = _1543;
        if (_1432 && _1497)
        {
            ivec2 _1572;
            highp vec2 _1658;
            if (_1466 < _1531)
            {
                _1658 = _1401.yx;
                _1572 = _1403.yx;
            }
            else
            {
                _1658 = _1401;
                _1572 = _1403;
            }
            int _718 = _1562 + 1;
            _1267[_718] = _1572.x;
            _1666 = _718;
            _1662 = _1572;
            _1657 = _1658;
            _1610 = _1572.y;
            _1587 = _1410;
        }
        else
        {
            bool _1602;
            int _1611;
            int _1667;
            if (_1432)
            {
                _1667 = _1562;
                _1611 = _1478;
                _1602 = _1410;
            }
            else
            {
                bool _1603;
                int _1612;
                int _1668;
                if (_1497)
                {
                    _1668 = _1562;
                    _1612 = _1543;
                    _1603 = _1410;
                }
                else
                {
                    bool _737 = _1562 > 0;
                    int _1613;
                    int _1669;
                    if (_737)
                    {
                        _1669 = _1562 - 1;
                        _1613 = _1267[_1562];
                    }
                    else
                    {
                        _1669 = _1562;
                        _1613 = _1412;
                    }
                    _1668 = _1669;
                    _1612 = _1613;
                    _1603 = _737 ? _1410 : true;
                }
                _1667 = _1668;
                _1611 = _1612;
                _1602 = _1603;
            }
            _1666 = _1667;
            _1662 = _1403;
            _1657 = _1401;
            _1610 = _1611;
            _1587 = _1602;
        }
    }
    uint _1191 = ((_1420 ^ 61u) ^ (_1420 >> uint(16))) * 9u;
    uint _1197 = (_1191 ^ (_1191 >> uint(4))) * 668265261u;
    highp float _1209 = float((_1197 ^ (_1197 >> uint(15))) & 65535u) * 9.15541313588619232177734375e-05;
    col = vec4(clamp(vec3(abs(_1209 - 3.0) - 1.0, 2.0 - abs(_1209 - 2.0), 2.0 - abs(_1209 - 4.0)), vec3(0.0), vec3(1.0)) * (1.0 - float(_1420 == 4294967295u)), 1.0);
}
