#version 300 es
precision highp float;
precision highp int;
uniform highp sampler2D v1LinesBvh;
uniform highp vec2 targetUV;
in highp vec2 uv;
layout(location = 0) out highp vec4 col;
vec2 _1298;
ivec2 _1300;
vec2 _1550;
ivec2 _1551;
void main()
{
    highp vec2 _450 = uv - targetUV;
    highp float _453 = length(_450);
    highp vec2 _458 = _450 / vec2(_453);
    highp float _550 = _453 * _453;
    highp vec2 _561 = vec2(1.0) / _458;
    highp vec2 _1290;
    highp vec2 _1297;
    ivec2 _1299;
    _1299 = _1300;
    _1297 = _1298;
    _1290 = _458 * _453;
    int _1143[16];
    highp vec2 _1380;
    highp float _1397;
    uint _1401;
    uint _1461;
    bool _1463;
    int _1486;
    highp vec2 _1533;
    ivec2 _1538;
    int _1542;
    bool _1286 = false;
    int _1288 = 0;
    highp float _1295 = _550;
    uint _1296 = 4294967295u;
    int _1438 = 0;
    for (;;)
    {
        if (!_1286)
        {
            highp vec4 _575 = texelFetch(v1LinesBvh, ivec2(_1288, 0), 0);
            highp vec4 _581 = texelFetch(v1LinesBvh, ivec2(_1288 + 1, 0), 0);
            highp vec4 _587 = texelFetch(v1LinesBvh, ivec2(_1288 + 2, 0), 0);
            bool _1308;
            highp vec2 _1315;
            highp float _1332;
            uint _1336;
            highp float _1342;
            int _1354;
            do
            {
                if (floatBitsToInt(_575.xy).x == 1)
                {
                    highp vec2 _714 = -_1290;
                    highp vec2 _721 = targetUV - _581.xy;
                    highp float _723 = _714.x;
                    highp float _725 = _581.w;
                    highp float _728 = _714.y;
                    highp float _730 = _581.z;
                    highp float _732 = (_723 * _725) - (_728 * _730);
                    highp float _734 = _721.x;
                    highp float _739 = _721.y;
                    uint _757 = floatBitsToUint(_732) & 2147483648u;
                    highp float _762 = uintBitsToFloat(floatBitsToUint((_734 * _728) - (_739 * _723)) ^ _757);
                    highp float _767 = uintBitsToFloat(floatBitsToUint((_734 * _725) - (_739 * _730)) ^ _757);
                    bool _771 = min(_762, _767) > 0.0;
                    bool _780;
                    if (_771)
                    {
                        _780 = max(_762, _767) < abs(_732);
                    }
                    else
                    {
                        _780 = _771;
                    }
                    highp vec2 _1316;
                    highp float _1333;
                    uint _1337;
                    if (_780)
                    {
                        highp vec2 _800 = _1290 * (_767 / abs(_732));
                        _1337 = floatBitsToUint(_575.y);
                        _1333 = dot(_800, _800);
                        _1316 = _800;
                    }
                    else
                    {
                        _1337 = _1296;
                        _1333 = _1295;
                        _1316 = _1290;
                    }
                    _1354 = _1299.x;
                    _1342 = _1297.x;
                    _1336 = _1337;
                    _1332 = _1333;
                    _1315 = _1316;
                    _1308 = false;
                    break;
                }
                highp vec2 _824 = (vec2(_581.xz) - targetUV.xx) * _561.x;
                highp vec2 _835 = (vec2(_581.yw) - targetUV.yy) * _561.y;
                highp vec2 _1303;
                if (_824.x > _824.y)
                {
                    _1303 = _824.yx;
                }
                else
                {
                    _1303 = _824;
                }
                highp vec2 _1304;
                if (_835.x > _835.y)
                {
                    _1304 = _835.yx;
                }
                else
                {
                    _1304 = _835;
                }
                highp float _867 = max(0.0, max(_1303.x, _1304.x));
                bool _873 = _867 < min(_1303.y, _1304.y);
                bool _884;
                if (_873)
                {
                    _884 = (_867 * _867) < _1295;
                }
                else
                {
                    _884 = _873;
                }
                if (_884)
                {
                    _1354 = floatBitsToInt(_575.y);
                    _1342 = _867;
                    _1336 = _1296;
                    _1332 = _1295;
                    _1315 = _1290;
                    _1308 = true;
                    break;
                }
                _1354 = _1299.x;
                _1342 = _1297.x;
                _1336 = _1296;
                _1332 = _1295;
                _1315 = _1290;
                _1308 = false;
                break;
            } while(false);
            highp vec2 _1235 = _1550;
            _1235.x = _1342;
            ivec2 _1237 = _1551;
            _1237.x = _1354;
            bool _1373;
            highp float _1407;
            int _1419;
            do
            {
                if (floatBitsToInt(_575.zw).x == 1)
                {
                    highp vec2 _924 = -_1315;
                    highp vec2 _931 = targetUV - _587.xy;
                    highp float _933 = _924.x;
                    highp float _935 = _587.w;
                    highp float _938 = _924.y;
                    highp float _940 = _587.z;
                    highp float _942 = (_933 * _935) - (_938 * _940);
                    highp float _944 = _931.x;
                    highp float _949 = _931.y;
                    uint _967 = floatBitsToUint(_942) & 2147483648u;
                    highp float _972 = uintBitsToFloat(floatBitsToUint((_944 * _938) - (_949 * _933)) ^ _967);
                    highp float _977 = uintBitsToFloat(floatBitsToUint((_944 * _935) - (_949 * _940)) ^ _967);
                    bool _981 = min(_972, _977) > 0.0;
                    bool _990;
                    if (_981)
                    {
                        _990 = max(_972, _977) < abs(_942);
                    }
                    else
                    {
                        _990 = _981;
                    }
                    highp vec2 _1381;
                    highp float _1398;
                    uint _1402;
                    if (_990)
                    {
                        highp vec2 _1010 = _1315 * (_977 / abs(_942));
                        _1402 = floatBitsToUint(_575.w);
                        _1398 = dot(_1010, _1010);
                        _1381 = _1010;
                    }
                    else
                    {
                        _1402 = _1336;
                        _1398 = _1332;
                        _1381 = _1315;
                    }
                    _1419 = _1299.y;
                    _1407 = _1297.y;
                    _1401 = _1402;
                    _1397 = _1398;
                    _1380 = _1381;
                    _1373 = false;
                    break;
                }
                highp vec2 _1034 = (vec2(_587.xz) - targetUV.xx) * _561.x;
                highp vec2 _1045 = (vec2(_587.yw) - targetUV.yy) * _561.y;
                highp vec2 _1368;
                if (_1034.x > _1034.y)
                {
                    _1368 = _1034.yx;
                }
                else
                {
                    _1368 = _1034;
                }
                highp vec2 _1369;
                if (_1045.x > _1045.y)
                {
                    _1369 = _1045.yx;
                }
                else
                {
                    _1369 = _1045;
                }
                highp float _1077 = max(0.0, max(_1368.x, _1369.x));
                bool _1083 = _1077 < min(_1368.y, _1369.y);
                bool _1094;
                if (_1083)
                {
                    _1094 = (_1077 * _1077) < _1332;
                }
                else
                {
                    _1094 = _1083;
                }
                if (_1094)
                {
                    _1419 = floatBitsToInt(_575.w);
                    _1407 = _1077;
                    _1401 = _1336;
                    _1397 = _1332;
                    _1380 = _1315;
                    _1373 = true;
                    break;
                }
                _1419 = _1299.y;
                _1407 = _1297.y;
                _1401 = _1336;
                _1397 = _1332;
                _1380 = _1315;
                _1373 = false;
                break;
            } while(false);
            highp vec2 _1277 = _1235;
            _1277.y = _1407;
            ivec2 _1279 = _1237;
            _1279.y = _1419;
            if (_1401 != 4294967295u)
            {
                _1461 = _1401;
                break;
            }
            if (_1308 && _1373)
            {
                ivec2 _1448;
                highp vec2 _1534;
                if (_1342 < _1407)
                {
                    _1534 = _1277.yx;
                    _1448 = _1279.yx;
                }
                else
                {
                    _1534 = _1277;
                    _1448 = _1279;
                }
                int _650 = _1438 + 1;
                _1143[_650] = _1448.x;
                _1542 = _650;
                _1538 = _1448;
                _1533 = _1534;
                _1486 = _1448.y;
                _1463 = _1286;
            }
            else
            {
                bool _1478;
                int _1487;
                int _1543;
                if (_1308)
                {
                    _1543 = _1438;
                    _1487 = _1354;
                    _1478 = _1286;
                }
                else
                {
                    bool _1479;
                    int _1488;
                    int _1544;
                    if (_1373)
                    {
                        _1544 = _1438;
                        _1488 = _1419;
                        _1479 = _1286;
                    }
                    else
                    {
                        bool _669 = _1438 > 0;
                        int _1489;
                        int _1545;
                        if (_669)
                        {
                            _1545 = _1438 - 1;
                            _1489 = _1143[_1438];
                        }
                        else
                        {
                            _1545 = _1438;
                            _1489 = _1288;
                        }
                        _1544 = _1545;
                        _1488 = _1489;
                        _1479 = _669 ? _1286 : true;
                    }
                    _1543 = _1544;
                    _1487 = _1488;
                    _1478 = _1479;
                }
                _1542 = _1543;
                _1538 = _1279;
                _1533 = _1277;
                _1486 = _1487;
                _1463 = _1478;
            }
            _1438 = _1542;
            _1299 = _1538;
            _1297 = _1533;
            _1296 = _1401;
            _1295 = _1397;
            _1290 = _1380;
            _1288 = _1486;
            _1286 = _1463;
            continue;
        }
        else
        {
            _1461 = _1296;
            break;
        }
    }
    col = vec4((normalize(vec3(targetUV, length(targetUV))) * float(_1461 == 4294967295u)) * pow(_453 + 1.0, -10.0), 1.0);
}
