#version 300 es
precision highp float;
precision highp int;
uniform highp sampler2D v1LinesBvh;
uniform highp vec2 targetUV;
in highp vec2 uv;
layout(location = 0) out highp vec4 col;
vec2 _1280;
ivec2 _1282;
vec2 _1534;
ivec2 _1535;
void main()
{
    highp vec2 _449 = uv - targetUV;
    highp float _452 = length(_449);
    highp vec2 _457 = _449 / vec2(_452);
    highp float _529 = _452 * _452;
    highp vec2 _540 = vec2(1.0) / _457;
    int _1269;
    int _1271;
    highp vec2 _1272;
    uint _1278;
    highp vec2 _1279;
    ivec2 _1281;
    _1281 = _1282;
    _1279 = _1280;
    _1278 = 4294967295u;
    _1272 = _457 * _452;
    _1271 = 0;
    _1269 = 0;
    int _548;
    int _1122[16];
    int _1356;
    highp vec2 _1362;
    highp float _1379;
    uint _1383;
    bool _1445;
    int _1468;
    highp vec2 _1515;
    ivec2 _1520;
    int _1524;
    bool _1268 = false;
    int _1270 = 0;
    highp float _1277 = _529;
    int _1420 = 0;
    for (; !_1268; _1420 = _1524, _1281 = _1520, _1279 = _1515, _1278 = _1383, _1277 = _1379, _1272 = _1362, _1271 = _1356, _1270 = _1468, _1269 = _548, _1268 = _1445)
    {
        _548 = _1269 + 1;
        highp vec4 _554 = texelFetch(v1LinesBvh, ivec2(_1270, 0), 0);
        highp vec4 _560 = texelFetch(v1LinesBvh, ivec2(_1270 + 1, 0), 0);
        highp vec4 _566 = texelFetch(v1LinesBvh, ivec2(_1270 + 2, 0), 0);
        bool _1290;
        int _1291;
        highp vec2 _1297;
        highp float _1314;
        uint _1318;
        highp float _1324;
        int _1336;
        do
        {
            if (floatBitsToInt(_554.xy).x == 1)
            {
                highp vec2 _693 = -_1272;
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
                highp vec2 _1298;
                highp float _1315;
                uint _1319;
                if (_759)
                {
                    highp vec2 _779 = _1272 * (_746 / abs(_711));
                    _1319 = floatBitsToUint(_554.y);
                    _1315 = dot(_779, _779);
                    _1298 = _779;
                }
                else
                {
                    _1319 = _1278;
                    _1315 = _1277;
                    _1298 = _1272;
                }
                _1336 = _1281.x;
                _1324 = _1279.x;
                _1318 = _1319;
                _1314 = _1315;
                _1297 = _1298;
                _1291 = _1271 + 1;
                _1290 = false;
                break;
            }
            highp vec2 _803 = (vec2(_560.xz) - targetUV.xx) * _540.x;
            highp vec2 _814 = (vec2(_560.yw) - targetUV.yy) * _540.y;
            highp vec2 _1285;
            if (_803.x > _803.y)
            {
                _1285 = _803.yx;
            }
            else
            {
                _1285 = _803;
            }
            highp vec2 _1286;
            if (_814.x > _814.y)
            {
                _1286 = _814.yx;
            }
            else
            {
                _1286 = _814;
            }
            highp float _846 = max(0.0, max(_1285.x, _1286.x));
            bool _852 = _846 < min(_1285.y, _1286.y);
            bool _863;
            if (_852)
            {
                _863 = (_846 * _846) < _1277;
            }
            else
            {
                _863 = _852;
            }
            if (_863)
            {
                _1336 = floatBitsToInt(_554.y);
                _1324 = _846;
                _1318 = _1278;
                _1314 = _1277;
                _1297 = _1272;
                _1291 = _1271;
                _1290 = true;
                break;
            }
            _1336 = _1281.x;
            _1324 = _1279.x;
            _1318 = _1278;
            _1314 = _1277;
            _1297 = _1272;
            _1291 = _1271;
            _1290 = false;
            break;
        } while(false);
        highp vec2 _1217 = _1534;
        _1217.x = _1324;
        ivec2 _1219 = _1535;
        _1219.x = _1336;
        bool _1355;
        highp float _1389;
        int _1401;
        do
        {
            if (floatBitsToInt(_554.zw).x == 1)
            {
                highp vec2 _903 = -_1297;
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
                highp vec2 _1363;
                highp float _1380;
                uint _1384;
                if (_969)
                {
                    highp vec2 _989 = _1297 * (_956 / abs(_921));
                    _1384 = floatBitsToUint(_554.w);
                    _1380 = dot(_989, _989);
                    _1363 = _989;
                }
                else
                {
                    _1384 = _1318;
                    _1380 = _1314;
                    _1363 = _1297;
                }
                _1401 = _1281.y;
                _1389 = _1279.y;
                _1383 = _1384;
                _1379 = _1380;
                _1362 = _1363;
                _1356 = _1291 + 1;
                _1355 = false;
                break;
            }
            highp vec2 _1013 = (vec2(_566.xz) - targetUV.xx) * _540.x;
            highp vec2 _1024 = (vec2(_566.yw) - targetUV.yy) * _540.y;
            highp vec2 _1350;
            if (_1013.x > _1013.y)
            {
                _1350 = _1013.yx;
            }
            else
            {
                _1350 = _1013;
            }
            highp vec2 _1351;
            if (_1024.x > _1024.y)
            {
                _1351 = _1024.yx;
            }
            else
            {
                _1351 = _1024;
            }
            highp float _1056 = max(0.0, max(_1350.x, _1351.x));
            bool _1062 = _1056 < min(_1350.y, _1351.y);
            bool _1073;
            if (_1062)
            {
                _1073 = (_1056 * _1056) < _1314;
            }
            else
            {
                _1073 = _1062;
            }
            if (_1073)
            {
                _1401 = floatBitsToInt(_554.w);
                _1389 = _1056;
                _1383 = _1318;
                _1379 = _1314;
                _1362 = _1297;
                _1356 = _1291;
                _1355 = true;
                break;
            }
            _1401 = _1281.y;
            _1389 = _1279.y;
            _1383 = _1318;
            _1379 = _1314;
            _1362 = _1297;
            _1356 = _1291;
            _1355 = false;
            break;
        } while(false);
        highp vec2 _1259 = _1217;
        _1259.y = _1389;
        ivec2 _1261 = _1219;
        _1261.y = _1401;
        if (_1290 && _1355)
        {
            ivec2 _1430;
            highp vec2 _1516;
            if (_1324 < _1389)
            {
                _1516 = _1259.yx;
                _1430 = _1261.yx;
            }
            else
            {
                _1516 = _1259;
                _1430 = _1261;
            }
            int _629 = _1420 + 1;
            _1122[_629] = _1430.x;
            _1524 = _629;
            _1520 = _1430;
            _1515 = _1516;
            _1468 = _1430.y;
            _1445 = _1268;
        }
        else
        {
            bool _1460;
            int _1469;
            int _1525;
            if (_1290)
            {
                _1525 = _1420;
                _1469 = _1336;
                _1460 = _1268;
            }
            else
            {
                bool _1461;
                int _1470;
                int _1526;
                if (_1355)
                {
                    _1526 = _1420;
                    _1470 = _1401;
                    _1461 = _1268;
                }
                else
                {
                    bool _648 = _1420 > 0;
                    int _1471;
                    int _1527;
                    if (_648)
                    {
                        _1527 = _1420 - 1;
                        _1471 = _1122[_1420];
                    }
                    else
                    {
                        _1527 = _1420;
                        _1471 = _1270;
                    }
                    _1526 = _1527;
                    _1470 = _1471;
                    _1461 = _648 ? _1268 : true;
                }
                _1525 = _1526;
                _1469 = _1470;
                _1460 = _1461;
            }
            _1524 = _1525;
            _1520 = _1261;
            _1515 = _1259;
            _1468 = _1469;
            _1445 = _1460;
        }
    }
    col = vec4(float(_1269) * 0.03125, float(_1271) * 0.0625, float(_1278 == 4294967295u), 1.0);
}
