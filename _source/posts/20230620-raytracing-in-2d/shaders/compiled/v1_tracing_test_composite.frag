#version 300 es
precision highp float;
precision highp int;
uniform highp sampler2D v1LinesBvh;
uniform highp vec2 targetUV;
in highp vec2 uv;
layout(location = 0) out highp vec4 col;
vec2 _1281;
ivec2 _1283;
vec2 _1535;
ivec2 _1536;
void main()
{
    highp vec2 _450 = uv - targetUV;
    highp float _453 = length(_450);
    highp vec2 _458 = _450 / vec2(_453);
    highp float _530 = _453 * _453;
    highp vec2 _541 = vec2(1.0) / _458;
    int _1270;
    int _1272;
    highp vec2 _1273;
    uint _1279;
    highp vec2 _1280;
    ivec2 _1282;
    _1282 = _1283;
    _1280 = _1281;
    _1279 = 4294967295u;
    _1273 = _458 * _453;
    _1272 = 0;
    _1270 = 0;
    int _549;
    int _1123[16];
    int _1357;
    highp vec2 _1363;
    highp float _1380;
    uint _1384;
    bool _1446;
    int _1469;
    highp vec2 _1516;
    ivec2 _1521;
    int _1525;
    bool _1269 = false;
    int _1271 = 0;
    highp float _1278 = _530;
    int _1421 = 0;
    for (; !_1269; _1421 = _1525, _1282 = _1521, _1280 = _1516, _1279 = _1384, _1278 = _1380, _1273 = _1363, _1272 = _1357, _1271 = _1469, _1270 = _549, _1269 = _1446)
    {
        _549 = _1270 + 1;
        highp vec4 _555 = texelFetch(v1LinesBvh, ivec2(_1271, 0), 0);
        highp vec4 _561 = texelFetch(v1LinesBvh, ivec2(_1271 + 1, 0), 0);
        highp vec4 _567 = texelFetch(v1LinesBvh, ivec2(_1271 + 2, 0), 0);
        bool _1291;
        int _1292;
        highp vec2 _1298;
        highp float _1315;
        uint _1319;
        highp float _1325;
        int _1337;
        do
        {
            if (floatBitsToInt(_555.xy).x == 1)
            {
                highp vec2 _694 = -_1273;
                highp vec2 _701 = targetUV - _561.xy;
                highp float _703 = _694.x;
                highp float _705 = _561.w;
                highp float _708 = _694.y;
                highp float _710 = _561.z;
                highp float _712 = (_703 * _705) - (_708 * _710);
                highp float _714 = _701.x;
                highp float _719 = _701.y;
                uint _737 = floatBitsToUint(_712) & 2147483648u;
                highp float _742 = uintBitsToFloat(floatBitsToUint((_714 * _708) - (_719 * _703)) ^ _737);
                highp float _747 = uintBitsToFloat(floatBitsToUint((_714 * _705) - (_719 * _710)) ^ _737);
                bool _751 = min(_742, _747) > 0.0;
                bool _760;
                if (_751)
                {
                    _760 = max(_742, _747) < abs(_712);
                }
                else
                {
                    _760 = _751;
                }
                highp vec2 _1299;
                highp float _1316;
                uint _1320;
                if (_760)
                {
                    highp vec2 _780 = _1273 * (_747 / abs(_712));
                    _1320 = floatBitsToUint(_555.y);
                    _1316 = dot(_780, _780);
                    _1299 = _780;
                }
                else
                {
                    _1320 = _1279;
                    _1316 = _1278;
                    _1299 = _1273;
                }
                _1337 = _1282.x;
                _1325 = _1280.x;
                _1319 = _1320;
                _1315 = _1316;
                _1298 = _1299;
                _1292 = _1272 + 1;
                _1291 = false;
                break;
            }
            highp vec2 _804 = (vec2(_561.xz) - targetUV.xx) * _541.x;
            highp vec2 _815 = (vec2(_561.yw) - targetUV.yy) * _541.y;
            highp vec2 _1286;
            if (_804.x > _804.y)
            {
                _1286 = _804.yx;
            }
            else
            {
                _1286 = _804;
            }
            highp vec2 _1287;
            if (_815.x > _815.y)
            {
                _1287 = _815.yx;
            }
            else
            {
                _1287 = _815;
            }
            highp float _847 = max(0.0, max(_1286.x, _1287.x));
            bool _853 = _847 < min(_1286.y, _1287.y);
            bool _864;
            if (_853)
            {
                _864 = (_847 * _847) < _1278;
            }
            else
            {
                _864 = _853;
            }
            if (_864)
            {
                _1337 = floatBitsToInt(_555.y);
                _1325 = _847;
                _1319 = _1279;
                _1315 = _1278;
                _1298 = _1273;
                _1292 = _1272;
                _1291 = true;
                break;
            }
            _1337 = _1282.x;
            _1325 = _1280.x;
            _1319 = _1279;
            _1315 = _1278;
            _1298 = _1273;
            _1292 = _1272;
            _1291 = false;
            break;
        } while(false);
        highp vec2 _1218 = _1535;
        _1218.x = _1325;
        ivec2 _1220 = _1536;
        _1220.x = _1337;
        bool _1356;
        highp float _1390;
        int _1402;
        do
        {
            if (floatBitsToInt(_555.zw).x == 1)
            {
                highp vec2 _904 = -_1298;
                highp vec2 _911 = targetUV - _567.xy;
                highp float _913 = _904.x;
                highp float _915 = _567.w;
                highp float _918 = _904.y;
                highp float _920 = _567.z;
                highp float _922 = (_913 * _915) - (_918 * _920);
                highp float _924 = _911.x;
                highp float _929 = _911.y;
                uint _947 = floatBitsToUint(_922) & 2147483648u;
                highp float _952 = uintBitsToFloat(floatBitsToUint((_924 * _918) - (_929 * _913)) ^ _947);
                highp float _957 = uintBitsToFloat(floatBitsToUint((_924 * _915) - (_929 * _920)) ^ _947);
                bool _961 = min(_952, _957) > 0.0;
                bool _970;
                if (_961)
                {
                    _970 = max(_952, _957) < abs(_922);
                }
                else
                {
                    _970 = _961;
                }
                highp vec2 _1364;
                highp float _1381;
                uint _1385;
                if (_970)
                {
                    highp vec2 _990 = _1298 * (_957 / abs(_922));
                    _1385 = floatBitsToUint(_555.w);
                    _1381 = dot(_990, _990);
                    _1364 = _990;
                }
                else
                {
                    _1385 = _1319;
                    _1381 = _1315;
                    _1364 = _1298;
                }
                _1402 = _1282.y;
                _1390 = _1280.y;
                _1384 = _1385;
                _1380 = _1381;
                _1363 = _1364;
                _1357 = _1292 + 1;
                _1356 = false;
                break;
            }
            highp vec2 _1014 = (vec2(_567.xz) - targetUV.xx) * _541.x;
            highp vec2 _1025 = (vec2(_567.yw) - targetUV.yy) * _541.y;
            highp vec2 _1351;
            if (_1014.x > _1014.y)
            {
                _1351 = _1014.yx;
            }
            else
            {
                _1351 = _1014;
            }
            highp vec2 _1352;
            if (_1025.x > _1025.y)
            {
                _1352 = _1025.yx;
            }
            else
            {
                _1352 = _1025;
            }
            highp float _1057 = max(0.0, max(_1351.x, _1352.x));
            bool _1063 = _1057 < min(_1351.y, _1352.y);
            bool _1074;
            if (_1063)
            {
                _1074 = (_1057 * _1057) < _1315;
            }
            else
            {
                _1074 = _1063;
            }
            if (_1074)
            {
                _1402 = floatBitsToInt(_555.w);
                _1390 = _1057;
                _1384 = _1319;
                _1380 = _1315;
                _1363 = _1298;
                _1357 = _1292;
                _1356 = true;
                break;
            }
            _1402 = _1282.y;
            _1390 = _1280.y;
            _1384 = _1319;
            _1380 = _1315;
            _1363 = _1298;
            _1357 = _1292;
            _1356 = false;
            break;
        } while(false);
        highp vec2 _1260 = _1218;
        _1260.y = _1390;
        ivec2 _1262 = _1220;
        _1262.y = _1402;
        if (_1291 && _1356)
        {
            ivec2 _1431;
            highp vec2 _1517;
            if (_1325 < _1390)
            {
                _1517 = _1260.yx;
                _1431 = _1262.yx;
            }
            else
            {
                _1517 = _1260;
                _1431 = _1262;
            }
            int _630 = _1421 + 1;
            _1123[_630] = _1431.x;
            _1525 = _630;
            _1521 = _1431;
            _1516 = _1517;
            _1469 = _1431.y;
            _1446 = _1269;
        }
        else
        {
            bool _1461;
            int _1470;
            int _1526;
            if (_1291)
            {
                _1526 = _1421;
                _1470 = _1337;
                _1461 = _1269;
            }
            else
            {
                bool _1462;
                int _1471;
                int _1527;
                if (_1356)
                {
                    _1527 = _1421;
                    _1471 = _1402;
                    _1462 = _1269;
                }
                else
                {
                    bool _649 = _1421 > 0;
                    int _1472;
                    int _1528;
                    if (_649)
                    {
                        _1528 = _1421 - 1;
                        _1472 = _1123[_1421];
                    }
                    else
                    {
                        _1528 = _1421;
                        _1472 = _1271;
                    }
                    _1527 = _1528;
                    _1471 = _1472;
                    _1462 = _649 ? _1269 : true;
                }
                _1526 = _1527;
                _1470 = _1471;
                _1461 = _1462;
            }
            _1525 = _1526;
            _1521 = _1262;
            _1516 = _1260;
            _1469 = _1470;
            _1446 = _1461;
        }
    }
    col = vec4(float(_1270) * 0.03125, float(_1272) * 0.0625, float(_1279 == 4294967295u), 1.0);
}
