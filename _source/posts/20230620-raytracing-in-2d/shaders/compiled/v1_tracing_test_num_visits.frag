#version 300 es
precision highp float;
precision highp int;
vec2 _1279;
ivec2 _1281;
uniform highp sampler2D v1LinesBvh;
uniform highp vec2 targetUV;
in highp vec2 uv;
layout(location = 0) out highp vec4 col;
void main()
{
    highp vec2 _450 = uv - targetUV;
    highp float _453 = length(_450);
    highp vec2 _458 = _450 / vec2(_453);
    highp float _530 = _453 * _453;
    highp vec2 _541 = vec2(1.0) / _458;
    int _1268;
    highp vec2 _1271;
    highp vec2 _1278;
    ivec2 _1280;
    _1280 = _1281;
    _1278 = _1279;
    _1271 = _458 * _453;
    _1268 = 0;
    int _549;
    int _1123[16];
    highp vec2 _1361;
    highp float _1378;
    bool _1444;
    int _1467;
    highp vec2 _1514;
    ivec2 _1519;
    int _1523;
    bool _1267 = false;
    int _1269 = 0;
    highp float _1276 = _530;
    int _1419 = 0;
    for (; !_1267; _1419 = _1523, _1280 = _1519, _1278 = _1514, _1276 = _1378, _1271 = _1361, _1269 = _1467, _1268 = _549, _1267 = _1444)
    {
        _549 = _1268 + 1;
        highp vec4 _555 = texelFetch(v1LinesBvh, ivec2(_1269, 0), 0);
        highp vec4 _561 = texelFetch(v1LinesBvh, ivec2(_1269 + 1, 0), 0);
        highp vec4 _567 = texelFetch(v1LinesBvh, ivec2(_1269 + 2, 0), 0);
        bool _1289;
        highp vec2 _1296;
        highp float _1313;
        highp float _1323;
        int _1335;
        do
        {
            if (floatBitsToInt(_555.xy).x == 1)
            {
                highp vec2 _694 = -_1271;
                highp vec2 _701 = targetUV - _561.xy;
                highp float _703 = _694.x;
                highp float _705 = _561.w;
                highp float _708 = _694.y;
                highp float _710 = _561.z;
                highp float _712 = _703 * _705 + (-(_708 * _710));
                highp float _714 = _701.x;
                highp float _719 = _701.y;
                uint _737 = floatBitsToUint(_712) & 2147483648u;
                highp float _742 = uintBitsToFloat(floatBitsToUint(_714 * _708 + (-(_719 * _703))) ^ _737);
                highp float _747 = uintBitsToFloat(floatBitsToUint(_714 * _705 + (-(_719 * _710))) ^ _737);
                bool _751 = min(_742, _747) >= 0.0;
                bool _760;
                if (_751)
                {
                    _760 = max(_742, _747) <= abs(_712);
                }
                else
                {
                    _760 = _751;
                }
                highp vec2 _1297;
                highp float _1314;
                if (_760)
                {
                    highp vec2 _780 = _1271 * (_747 / abs(_712));
                    _1314 = dot(_780, _780);
                    _1297 = _780;
                }
                else
                {
                    _1314 = _1276;
                    _1297 = _1271;
                }
                _1335 = _1280.x;
                _1323 = _1278.x;
                _1313 = _1314;
                _1296 = _1297;
                _1289 = false;
                break;
            }
            highp vec2 _804 = (vec2(_561.xz) - targetUV.xx) * _541.x;
            highp vec2 _815 = (vec2(_561.yw) - targetUV.yy) * _541.y;
            highp vec2 _1284;
            if (_804.x > _804.y)
            {
                _1284 = _804.yx;
            }
            else
            {
                _1284 = _804;
            }
            highp vec2 _1285;
            if (_815.x > _815.y)
            {
                _1285 = _815.yx;
            }
            else
            {
                _1285 = _815;
            }
            highp float _847 = max(0.0, max(_1284.x, _1285.x));
            bool _853 = _847 < min(_1284.y, _1285.y);
            bool _864;
            if (_853)
            {
                _864 = (_847 * _847) < _1276;
            }
            else
            {
                _864 = _853;
            }
            if (_864)
            {
                _1335 = floatBitsToInt(_555.y);
                _1323 = _847;
                _1313 = _1276;
                _1296 = _1271;
                _1289 = true;
                break;
            }
            _1335 = _1280.x;
            _1323 = _1278.x;
            _1313 = _1276;
            _1296 = _1271;
            _1289 = false;
            break;
        } while(false);
        bool _1354;
        highp float _1388;
        int _1400;
        do
        {
            if (floatBitsToInt(_555.zw).x == 1)
            {
                highp vec2 _904 = -_1296;
                highp vec2 _911 = targetUV - _567.xy;
                highp float _913 = _904.x;
                highp float _915 = _567.w;
                highp float _918 = _904.y;
                highp float _920 = _567.z;
                highp float _922 = _913 * _915 + (-(_918 * _920));
                highp float _924 = _911.x;
                highp float _929 = _911.y;
                uint _947 = floatBitsToUint(_922) & 2147483648u;
                highp float _952 = uintBitsToFloat(floatBitsToUint(_924 * _918 + (-(_929 * _913))) ^ _947);
                highp float _957 = uintBitsToFloat(floatBitsToUint(_924 * _915 + (-(_929 * _920))) ^ _947);
                bool _961 = min(_952, _957) >= 0.0;
                bool _970;
                if (_961)
                {
                    _970 = max(_952, _957) <= abs(_922);
                }
                else
                {
                    _970 = _961;
                }
                highp vec2 _1362;
                highp float _1379;
                if (_970)
                {
                    highp vec2 _990 = _1296 * (_957 / abs(_922));
                    _1379 = dot(_990, _990);
                    _1362 = _990;
                }
                else
                {
                    _1379 = _1313;
                    _1362 = _1296;
                }
                _1400 = _1280.y;
                _1388 = _1278.y;
                _1378 = _1379;
                _1361 = _1362;
                _1354 = false;
                break;
            }
            highp vec2 _1014 = (vec2(_567.xz) - targetUV.xx) * _541.x;
            highp vec2 _1025 = (vec2(_567.yw) - targetUV.yy) * _541.y;
            highp vec2 _1349;
            if (_1014.x > _1014.y)
            {
                _1349 = _1014.yx;
            }
            else
            {
                _1349 = _1014;
            }
            highp vec2 _1350;
            if (_1025.x > _1025.y)
            {
                _1350 = _1025.yx;
            }
            else
            {
                _1350 = _1025;
            }
            highp float _1057 = max(0.0, max(_1349.x, _1350.x));
            bool _1063 = _1057 < min(_1349.y, _1350.y);
            bool _1074;
            if (_1063)
            {
                _1074 = (_1057 * _1057) < _1313;
            }
            else
            {
                _1074 = _1063;
            }
            if (_1074)
            {
                _1400 = floatBitsToInt(_555.w);
                _1388 = _1057;
                _1378 = _1313;
                _1361 = _1296;
                _1354 = true;
                break;
            }
            _1400 = _1280.y;
            _1388 = _1278.y;
            _1378 = _1313;
            _1361 = _1296;
            _1354 = false;
            break;
        } while(false);
        highp vec2 _1538 = vec2(_1323, _1388);
        ivec2 _1539 = ivec2(_1335, _1400);
        if (_1289 && _1354)
        {
            ivec2 _1429;
            highp vec2 _1515;
            if (_1323 < _1388)
            {
                _1515 = _1538.yx;
                _1429 = _1539.yx;
            }
            else
            {
                _1515 = _1538;
                _1429 = _1539;
            }
            int _630 = _1419 + 1;
            _1123[_630] = _1429.x;
            _1523 = _630;
            _1519 = _1429;
            _1514 = _1515;
            _1467 = _1429.y;
            _1444 = _1267;
        }
        else
        {
            bool _1459;
            int _1468;
            int _1524;
            if (_1289)
            {
                _1524 = _1419;
                _1468 = _1335;
                _1459 = _1267;
            }
            else
            {
                bool _1460;
                int _1469;
                int _1525;
                if (_1354)
                {
                    _1525 = _1419;
                    _1469 = _1400;
                    _1460 = _1267;
                }
                else
                {
                    bool _649 = _1419 > 0;
                    int _1470;
                    int _1526;
                    if (_649)
                    {
                        _1526 = _1419 - 1;
                        _1470 = _1123[_1419];
                    }
                    else
                    {
                        _1526 = _1419;
                        _1470 = _1269;
                    }
                    _1525 = _1526;
                    _1469 = _1470;
                    _1460 = _649 ? _1267 : true;
                }
                _1524 = _1525;
                _1468 = _1469;
                _1459 = _1460;
            }
            _1523 = _1524;
            _1519 = _1539;
            _1514 = _1538;
            _1467 = _1468;
            _1444 = _1459;
        }
    }
    highp float _477 = float(_1268) * 0.03125;
    col = vec4(_477, _477, _477, 1.0);
}
