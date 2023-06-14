#version 300 es
precision highp float;
precision highp int;
uniform highp sampler2D v1LinesBvh;
uniform highp vec2 targetUV;
in highp vec2 uv;
layout(location = 0) out highp vec4 col;
vec2 _1277;
ivec2 _1279;
vec2 _1529;
ivec2 _1530;
void main()
{
    highp vec2 _449 = uv - targetUV;
    highp float _452 = length(_449);
    highp vec2 _457 = _449 / vec2(_452);
    highp float _529 = _452 * _452;
    highp vec2 _540 = vec2(1.0) / _457;
    highp vec2 _1269;
    highp vec2 _1276;
    ivec2 _1278;
    _1278 = _1279;
    _1276 = _1277;
    _1269 = _457 * _452;
    int _1122[16];
    highp vec2 _1359;
    highp float _1376;
    uint _1380;
    uint _1440;
    bool _1442;
    int _1465;
    highp vec2 _1512;
    ivec2 _1517;
    int _1521;
    bool _1265 = false;
    int _1267 = 0;
    highp float _1274 = _529;
    uint _1275 = 4294967295u;
    int _1417 = 0;
    for (;;)
    {
        if (!_1265)
        {
            highp vec4 _554 = texelFetch(v1LinesBvh, ivec2(_1267, 0), 0);
            highp vec4 _560 = texelFetch(v1LinesBvh, ivec2(_1267 + 1, 0), 0);
            highp vec4 _566 = texelFetch(v1LinesBvh, ivec2(_1267 + 2, 0), 0);
            bool _1287;
            highp vec2 _1294;
            highp float _1311;
            uint _1315;
            highp float _1321;
            int _1333;
            do
            {
                if (floatBitsToInt(_554.xy).x == 1)
                {
                    highp vec2 _693 = -_1269;
                    highp vec2 _700 = targetUV - _560.xy;
                    highp float _702 = _693.x;
                    highp float _704 = _560.w;
                    highp float _707 = _693.y;
                    highp float _709 = _560.z;
                    highp float _711 = (_702 * _704) - (_707 * _709);
                    highp float _713 = _700.x;
                    highp float _718 = _700.y;
                    uint _736 = floatBitsToUint(_711) & 2147483648u;
                    highp float _741 = uintBitsToFloat(floatBitsToUint((_713 * _707) - (_718 * _702)) ^ _736);
                    highp float _746 = uintBitsToFloat(floatBitsToUint((_713 * _704) - (_718 * _709)) ^ _736);
                    bool _750 = min(_741, _746) > 0.0;
                    bool _759;
                    if (_750)
                    {
                        _759 = max(_741, _746) < abs(_711);
                    }
                    else
                    {
                        _759 = _750;
                    }
                    highp vec2 _1295;
                    highp float _1312;
                    uint _1316;
                    if (_759)
                    {
                        highp vec2 _779 = _1269 * (_746 / abs(_711));
                        _1316 = floatBitsToUint(_554.y);
                        _1312 = dot(_779, _779);
                        _1295 = _779;
                    }
                    else
                    {
                        _1316 = _1275;
                        _1312 = _1274;
                        _1295 = _1269;
                    }
                    _1333 = _1278.x;
                    _1321 = _1276.x;
                    _1315 = _1316;
                    _1311 = _1312;
                    _1294 = _1295;
                    _1287 = false;
                    break;
                }
                highp vec2 _803 = (vec2(_560.xz) - targetUV.xx) * _540.x;
                highp vec2 _814 = (vec2(_560.yw) - targetUV.yy) * _540.y;
                highp vec2 _1282;
                if (_803.x > _803.y)
                {
                    _1282 = _803.yx;
                }
                else
                {
                    _1282 = _803;
                }
                highp vec2 _1283;
                if (_814.x > _814.y)
                {
                    _1283 = _814.yx;
                }
                else
                {
                    _1283 = _814;
                }
                highp float _846 = max(0.0, max(_1282.x, _1283.x));
                bool _852 = _846 < min(_1282.y, _1283.y);
                bool _863;
                if (_852)
                {
                    _863 = (_846 * _846) < _1274;
                }
                else
                {
                    _863 = _852;
                }
                if (_863)
                {
                    _1333 = floatBitsToInt(_554.y);
                    _1321 = _846;
                    _1315 = _1275;
                    _1311 = _1274;
                    _1294 = _1269;
                    _1287 = true;
                    break;
                }
                _1333 = _1278.x;
                _1321 = _1276.x;
                _1315 = _1275;
                _1311 = _1274;
                _1294 = _1269;
                _1287 = false;
                break;
            } while(false);
            highp vec2 _1214 = _1529;
            _1214.x = _1321;
            ivec2 _1216 = _1530;
            _1216.x = _1333;
            bool _1352;
            highp float _1386;
            int _1398;
            do
            {
                if (floatBitsToInt(_554.zw).x == 1)
                {
                    highp vec2 _903 = -_1294;
                    highp vec2 _910 = targetUV - _566.xy;
                    highp float _912 = _903.x;
                    highp float _914 = _566.w;
                    highp float _917 = _903.y;
                    highp float _919 = _566.z;
                    highp float _921 = (_912 * _914) - (_917 * _919);
                    highp float _923 = _910.x;
                    highp float _928 = _910.y;
                    uint _946 = floatBitsToUint(_921) & 2147483648u;
                    highp float _951 = uintBitsToFloat(floatBitsToUint((_923 * _917) - (_928 * _912)) ^ _946);
                    highp float _956 = uintBitsToFloat(floatBitsToUint((_923 * _914) - (_928 * _919)) ^ _946);
                    bool _960 = min(_951, _956) > 0.0;
                    bool _969;
                    if (_960)
                    {
                        _969 = max(_951, _956) < abs(_921);
                    }
                    else
                    {
                        _969 = _960;
                    }
                    highp vec2 _1360;
                    highp float _1377;
                    uint _1381;
                    if (_969)
                    {
                        highp vec2 _989 = _1294 * (_956 / abs(_921));
                        _1381 = floatBitsToUint(_554.w);
                        _1377 = dot(_989, _989);
                        _1360 = _989;
                    }
                    else
                    {
                        _1381 = _1315;
                        _1377 = _1311;
                        _1360 = _1294;
                    }
                    _1398 = _1278.y;
                    _1386 = _1276.y;
                    _1380 = _1381;
                    _1376 = _1377;
                    _1359 = _1360;
                    _1352 = false;
                    break;
                }
                highp vec2 _1013 = (vec2(_566.xz) - targetUV.xx) * _540.x;
                highp vec2 _1024 = (vec2(_566.yw) - targetUV.yy) * _540.y;
                highp vec2 _1347;
                if (_1013.x > _1013.y)
                {
                    _1347 = _1013.yx;
                }
                else
                {
                    _1347 = _1013;
                }
                highp vec2 _1348;
                if (_1024.x > _1024.y)
                {
                    _1348 = _1024.yx;
                }
                else
                {
                    _1348 = _1024;
                }
                highp float _1056 = max(0.0, max(_1347.x, _1348.x));
                bool _1062 = _1056 < min(_1347.y, _1348.y);
                bool _1073;
                if (_1062)
                {
                    _1073 = (_1056 * _1056) < _1311;
                }
                else
                {
                    _1073 = _1062;
                }
                if (_1073)
                {
                    _1398 = floatBitsToInt(_554.w);
                    _1386 = _1056;
                    _1380 = _1315;
                    _1376 = _1311;
                    _1359 = _1294;
                    _1352 = true;
                    break;
                }
                _1398 = _1278.y;
                _1386 = _1276.y;
                _1380 = _1315;
                _1376 = _1311;
                _1359 = _1294;
                _1352 = false;
                break;
            } while(false);
            highp vec2 _1256 = _1214;
            _1256.y = _1386;
            ivec2 _1258 = _1216;
            _1258.y = _1398;
            if (_1380 != 4294967295u)
            {
                _1440 = _1380;
                break;
            }
            if (_1287 && _1352)
            {
                ivec2 _1427;
                highp vec2 _1513;
                if (_1321 < _1386)
                {
                    _1513 = _1256.yx;
                    _1427 = _1258.yx;
                }
                else
                {
                    _1513 = _1256;
                    _1427 = _1258;
                }
                int _629 = _1417 + 1;
                _1122[_629] = _1427.x;
                _1521 = _629;
                _1517 = _1427;
                _1512 = _1513;
                _1465 = _1427.y;
                _1442 = _1265;
            }
            else
            {
                bool _1457;
                int _1466;
                int _1522;
                if (_1287)
                {
                    _1522 = _1417;
                    _1466 = _1333;
                    _1457 = _1265;
                }
                else
                {
                    bool _1458;
                    int _1467;
                    int _1523;
                    if (_1352)
                    {
                        _1523 = _1417;
                        _1467 = _1398;
                        _1458 = _1265;
                    }
                    else
                    {
                        bool _648 = _1417 > 0;
                        int _1468;
                        int _1524;
                        if (_648)
                        {
                            _1524 = _1417 - 1;
                            _1468 = _1122[_1417];
                        }
                        else
                        {
                            _1524 = _1417;
                            _1468 = _1267;
                        }
                        _1523 = _1524;
                        _1467 = _1468;
                        _1458 = _648 ? _1265 : true;
                    }
                    _1522 = _1523;
                    _1466 = _1467;
                    _1457 = _1458;
                }
                _1521 = _1522;
                _1517 = _1258;
                _1512 = _1256;
                _1465 = _1466;
                _1442 = _1457;
            }
            _1417 = _1521;
            _1278 = _1517;
            _1276 = _1512;
            _1275 = _1380;
            _1274 = _1376;
            _1269 = _1359;
            _1267 = _1465;
            _1265 = _1442;
            continue;
        }
        else
        {
            _1440 = _1275;
            break;
        }
    }
    highp float _470 = float(_1440 == 4294967295u);
    col = vec4(_470, _470, _470, 1.0);
}
