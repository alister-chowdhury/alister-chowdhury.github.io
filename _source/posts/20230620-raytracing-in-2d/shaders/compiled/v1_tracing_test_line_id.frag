#version 300 es
precision highp float;
precision highp int;
uniform highp sampler2D v1LinesBvh;
uniform highp vec2 targetUV;
in highp vec2 uv;
layout(location = 0) out highp vec4 col;
vec2 _1421;
ivec2 _1423;
vec2 _1675;
ivec2 _1676;
void main()
{
    highp vec2 _530 = uv - targetUV;
    highp float _533 = length(_530);
    highp vec2 _538 = _530 / vec2(_533);
    highp float _617 = _533 * _533;
    highp vec2 _628 = vec2(1.0) / _538;
    highp vec2 _1413;
    uint _1419;
    highp vec2 _1420;
    ivec2 _1422;
    _1422 = _1423;
    _1420 = _1421;
    _1419 = 4294967295u;
    _1413 = _538 * _533;
    int _1266[16];
    highp vec2 _1503;
    highp float _1520;
    uint _1524;
    bool _1586;
    int _1609;
    highp vec2 _1656;
    ivec2 _1661;
    int _1665;
    bool _1409 = false;
    int _1411 = 0;
    highp float _1418 = _617;
    int _1561 = 0;
    for (; !_1409; _1561 = _1665, _1422 = _1661, _1420 = _1656, _1419 = _1524, _1418 = _1520, _1413 = _1503, _1411 = _1609, _1409 = _1586)
    {
        highp vec4 _642 = texelFetch(v1LinesBvh, ivec2(_1411, 0), 0);
        highp vec4 _648 = texelFetch(v1LinesBvh, ivec2(_1411 + 1, 0), 0);
        highp vec4 _654 = texelFetch(v1LinesBvh, ivec2(_1411 + 2, 0), 0);
        bool _1431;
        highp vec2 _1438;
        highp float _1455;
        uint _1459;
        highp float _1465;
        int _1477;
        do
        {
            if (floatBitsToInt(_642.xy).x == 1)
            {
                highp vec2 _781 = -_1413;
                highp vec2 _788 = targetUV - _648.xy;
                highp float _790 = _781.x;
                highp float _792 = _648.w;
                highp float _795 = _781.y;
                highp float _797 = _648.z;
                highp float _799 = (_790 * _792) - (_795 * _797);
                highp float _801 = _788.x;
                highp float _806 = _788.y;
                uint _824 = floatBitsToUint(_799) & 2147483648u;
                highp float _829 = uintBitsToFloat(floatBitsToUint((_801 * _795) - (_806 * _790)) ^ _824);
                highp float _834 = uintBitsToFloat(floatBitsToUint((_801 * _792) - (_806 * _797)) ^ _824);
                bool _838 = min(_829, _834) > 0.0;
                bool _847;
                if (_838)
                {
                    _847 = max(_829, _834) < abs(_799);
                }
                else
                {
                    _847 = _838;
                }
                highp vec2 _1439;
                highp float _1456;
                uint _1460;
                if (_847)
                {
                    highp vec2 _867 = _1413 * (_834 / abs(_799));
                    _1460 = floatBitsToUint(_642.y);
                    _1456 = dot(_867, _867);
                    _1439 = _867;
                }
                else
                {
                    _1460 = _1419;
                    _1456 = _1418;
                    _1439 = _1413;
                }
                _1477 = _1422.x;
                _1465 = _1420.x;
                _1459 = _1460;
                _1455 = _1456;
                _1438 = _1439;
                _1431 = false;
                break;
            }
            highp vec2 _891 = (vec2(_648.xz) - targetUV.xx) * _628.x;
            highp vec2 _902 = (vec2(_648.yw) - targetUV.yy) * _628.y;
            highp vec2 _1426;
            if (_891.x > _891.y)
            {
                _1426 = _891.yx;
            }
            else
            {
                _1426 = _891;
            }
            highp vec2 _1427;
            if (_902.x > _902.y)
            {
                _1427 = _902.yx;
            }
            else
            {
                _1427 = _902;
            }
            highp float _934 = max(0.0, max(_1426.x, _1427.x));
            bool _940 = _934 < min(_1426.y, _1427.y);
            bool _951;
            if (_940)
            {
                _951 = (_934 * _934) < _1418;
            }
            else
            {
                _951 = _940;
            }
            if (_951)
            {
                _1477 = floatBitsToInt(_642.y);
                _1465 = _934;
                _1459 = _1419;
                _1455 = _1418;
                _1438 = _1413;
                _1431 = true;
                break;
            }
            _1477 = _1422.x;
            _1465 = _1420.x;
            _1459 = _1419;
            _1455 = _1418;
            _1438 = _1413;
            _1431 = false;
            break;
        } while(false);
        highp vec2 _1358 = _1675;
        _1358.x = _1465;
        ivec2 _1360 = _1676;
        _1360.x = _1477;
        bool _1496;
        highp float _1530;
        int _1542;
        do
        {
            if (floatBitsToInt(_642.zw).x == 1)
            {
                highp vec2 _991 = -_1438;
                highp vec2 _998 = targetUV - _654.xy;
                highp float _1000 = _991.x;
                highp float _1002 = _654.w;
                highp float _1005 = _991.y;
                highp float _1007 = _654.z;
                highp float _1009 = (_1000 * _1002) - (_1005 * _1007);
                highp float _1011 = _998.x;
                highp float _1016 = _998.y;
                uint _1034 = floatBitsToUint(_1009) & 2147483648u;
                highp float _1039 = uintBitsToFloat(floatBitsToUint((_1011 * _1005) - (_1016 * _1000)) ^ _1034);
                highp float _1044 = uintBitsToFloat(floatBitsToUint((_1011 * _1002) - (_1016 * _1007)) ^ _1034);
                bool _1048 = min(_1039, _1044) > 0.0;
                bool _1057;
                if (_1048)
                {
                    _1057 = max(_1039, _1044) < abs(_1009);
                }
                else
                {
                    _1057 = _1048;
                }
                highp vec2 _1504;
                highp float _1521;
                uint _1525;
                if (_1057)
                {
                    highp vec2 _1077 = _1438 * (_1044 / abs(_1009));
                    _1525 = floatBitsToUint(_642.w);
                    _1521 = dot(_1077, _1077);
                    _1504 = _1077;
                }
                else
                {
                    _1525 = _1459;
                    _1521 = _1455;
                    _1504 = _1438;
                }
                _1542 = _1422.y;
                _1530 = _1420.y;
                _1524 = _1525;
                _1520 = _1521;
                _1503 = _1504;
                _1496 = false;
                break;
            }
            highp vec2 _1101 = (vec2(_654.xz) - targetUV.xx) * _628.x;
            highp vec2 _1112 = (vec2(_654.yw) - targetUV.yy) * _628.y;
            highp vec2 _1491;
            if (_1101.x > _1101.y)
            {
                _1491 = _1101.yx;
            }
            else
            {
                _1491 = _1101;
            }
            highp vec2 _1492;
            if (_1112.x > _1112.y)
            {
                _1492 = _1112.yx;
            }
            else
            {
                _1492 = _1112;
            }
            highp float _1144 = max(0.0, max(_1491.x, _1492.x));
            bool _1150 = _1144 < min(_1491.y, _1492.y);
            bool _1161;
            if (_1150)
            {
                _1161 = (_1144 * _1144) < _1455;
            }
            else
            {
                _1161 = _1150;
            }
            if (_1161)
            {
                _1542 = floatBitsToInt(_642.w);
                _1530 = _1144;
                _1524 = _1459;
                _1520 = _1455;
                _1503 = _1438;
                _1496 = true;
                break;
            }
            _1542 = _1422.y;
            _1530 = _1420.y;
            _1524 = _1459;
            _1520 = _1455;
            _1503 = _1438;
            _1496 = false;
            break;
        } while(false);
        highp vec2 _1400 = _1358;
        _1400.y = _1530;
        ivec2 _1402 = _1360;
        _1402.y = _1542;
        if (_1431 && _1496)
        {
            ivec2 _1571;
            highp vec2 _1657;
            if (_1465 < _1530)
            {
                _1657 = _1400.yx;
                _1571 = _1402.yx;
            }
            else
            {
                _1657 = _1400;
                _1571 = _1402;
            }
            int _717 = _1561 + 1;
            _1266[_717] = _1571.x;
            _1665 = _717;
            _1661 = _1571;
            _1656 = _1657;
            _1609 = _1571.y;
            _1586 = _1409;
        }
        else
        {
            bool _1601;
            int _1610;
            int _1666;
            if (_1431)
            {
                _1666 = _1561;
                _1610 = _1477;
                _1601 = _1409;
            }
            else
            {
                bool _1602;
                int _1611;
                int _1667;
                if (_1496)
                {
                    _1667 = _1561;
                    _1611 = _1542;
                    _1602 = _1409;
                }
                else
                {
                    bool _736 = _1561 > 0;
                    int _1612;
                    int _1668;
                    if (_736)
                    {
                        _1668 = _1561 - 1;
                        _1612 = _1266[_1561];
                    }
                    else
                    {
                        _1668 = _1561;
                        _1612 = _1411;
                    }
                    _1667 = _1668;
                    _1611 = _1612;
                    _1602 = _736 ? _1409 : true;
                }
                _1666 = _1667;
                _1610 = _1611;
                _1601 = _1602;
            }
            _1665 = _1666;
            _1661 = _1402;
            _1656 = _1400;
            _1609 = _1610;
            _1586 = _1601;
        }
    }
    uint _1190 = ((_1419 ^ 61u) ^ (_1419 >> uint(16))) * 9u;
    uint _1196 = (_1190 ^ (_1190 >> uint(4))) * 668265261u;
    highp float _1208 = float((_1196 ^ (_1196 >> uint(15))) & 65535u) * 9.15541313588619232177734375e-05;
    col = vec4(clamp(vec3(abs(_1208 - 3.0) - 1.0, 2.0 - abs(_1208 - 2.0), 2.0 - abs(_1208 - 4.0)), vec3(0.0), vec3(1.0)) * (1.0 - float(_1419 == 4294967295u)), 1.0);
}
