#version 300 es
precision highp float;
precision highp int;
uniform highp sampler2D v1LinesBvh;
uniform highp vec2 targetUV;
in highp vec2 uv;
layout(location = 0) out highp vec4 col;
vec2 _1297;
ivec2 _1299;
vec2 _1549;
ivec2 _1550;
void main()
{
    highp vec2 _449 = uv - targetUV;
    highp float _452 = length(_449);
    highp vec2 _457 = _449 / vec2(_452);
    highp float _549 = _452 * _452;
    highp vec2 _560 = vec2(1.0) / _457;
    highp vec2 _1289;
    highp vec2 _1296;
    ivec2 _1298;
    _1298 = _1299;
    _1296 = _1297;
    _1289 = _457 * _452;
    int _1142[16];
    highp vec2 _1379;
    highp float _1396;
    uint _1400;
    uint _1460;
    bool _1462;
    int _1485;
    highp vec2 _1532;
    ivec2 _1537;
    int _1541;
    bool _1285 = false;
    int _1287 = 0;
    highp float _1294 = _549;
    uint _1295 = 4294967295u;
    int _1437 = 0;
    for (;;)
    {
        if (!_1285)
        {
            highp vec4 _574 = texelFetch(v1LinesBvh, ivec2(_1287, 0), 0);
            highp vec4 _580 = texelFetch(v1LinesBvh, ivec2(_1287 + 1, 0), 0);
            highp vec4 _586 = texelFetch(v1LinesBvh, ivec2(_1287 + 2, 0), 0);
            bool _1307;
            highp vec2 _1314;
            highp float _1331;
            uint _1335;
            highp float _1341;
            int _1353;
            do
            {
                if (floatBitsToInt(_574.xy).x == 1)
                {
                    highp vec2 _713 = -_1289;
                    highp vec2 _720 = targetUV - _580.xy;
                    highp float _722 = _713.x;
                    highp float _724 = _580.w;
                    highp float _727 = _713.y;
                    highp float _729 = _580.z;
                    highp float _731 = (_722 * _724) - (_727 * _729);
                    highp float _733 = _720.x;
                    highp float _738 = _720.y;
                    uint _756 = floatBitsToUint(_731) & 2147483648u;
                    highp float _761 = uintBitsToFloat(floatBitsToUint((_733 * _727) - (_738 * _722)) ^ _756);
                    highp float _766 = uintBitsToFloat(floatBitsToUint((_733 * _724) - (_738 * _729)) ^ _756);
                    bool _770 = min(_761, _766) > 0.0;
                    bool _779;
                    if (_770)
                    {
                        _779 = max(_761, _766) < abs(_731);
                    }
                    else
                    {
                        _779 = _770;
                    }
                    highp vec2 _1315;
                    highp float _1332;
                    uint _1336;
                    if (_779)
                    {
                        highp vec2 _799 = _1289 * (_766 / abs(_731));
                        _1336 = floatBitsToUint(_574.y);
                        _1332 = dot(_799, _799);
                        _1315 = _799;
                    }
                    else
                    {
                        _1336 = _1295;
                        _1332 = _1294;
                        _1315 = _1289;
                    }
                    _1353 = _1298.x;
                    _1341 = _1296.x;
                    _1335 = _1336;
                    _1331 = _1332;
                    _1314 = _1315;
                    _1307 = false;
                    break;
                }
                highp vec2 _823 = (vec2(_580.xz) - targetUV.xx) * _560.x;
                highp vec2 _834 = (vec2(_580.yw) - targetUV.yy) * _560.y;
                highp vec2 _1302;
                if (_823.x > _823.y)
                {
                    _1302 = _823.yx;
                }
                else
                {
                    _1302 = _823;
                }
                highp vec2 _1303;
                if (_834.x > _834.y)
                {
                    _1303 = _834.yx;
                }
                else
                {
                    _1303 = _834;
                }
                highp float _866 = max(0.0, max(_1302.x, _1303.x));
                bool _872 = _866 < min(_1302.y, _1303.y);
                bool _883;
                if (_872)
                {
                    _883 = (_866 * _866) < _1294;
                }
                else
                {
                    _883 = _872;
                }
                if (_883)
                {
                    _1353 = floatBitsToInt(_574.y);
                    _1341 = _866;
                    _1335 = _1295;
                    _1331 = _1294;
                    _1314 = _1289;
                    _1307 = true;
                    break;
                }
                _1353 = _1298.x;
                _1341 = _1296.x;
                _1335 = _1295;
                _1331 = _1294;
                _1314 = _1289;
                _1307 = false;
                break;
            } while(false);
            highp vec2 _1234 = _1549;
            _1234.x = _1341;
            ivec2 _1236 = _1550;
            _1236.x = _1353;
            bool _1372;
            highp float _1406;
            int _1418;
            do
            {
                if (floatBitsToInt(_574.zw).x == 1)
                {
                    highp vec2 _923 = -_1314;
                    highp vec2 _930 = targetUV - _586.xy;
                    highp float _932 = _923.x;
                    highp float _934 = _586.w;
                    highp float _937 = _923.y;
                    highp float _939 = _586.z;
                    highp float _941 = (_932 * _934) - (_937 * _939);
                    highp float _943 = _930.x;
                    highp float _948 = _930.y;
                    uint _966 = floatBitsToUint(_941) & 2147483648u;
                    highp float _971 = uintBitsToFloat(floatBitsToUint((_943 * _937) - (_948 * _932)) ^ _966);
                    highp float _976 = uintBitsToFloat(floatBitsToUint((_943 * _934) - (_948 * _939)) ^ _966);
                    bool _980 = min(_971, _976) > 0.0;
                    bool _989;
                    if (_980)
                    {
                        _989 = max(_971, _976) < abs(_941);
                    }
                    else
                    {
                        _989 = _980;
                    }
                    highp vec2 _1380;
                    highp float _1397;
                    uint _1401;
                    if (_989)
                    {
                        highp vec2 _1009 = _1314 * (_976 / abs(_941));
                        _1401 = floatBitsToUint(_574.w);
                        _1397 = dot(_1009, _1009);
                        _1380 = _1009;
                    }
                    else
                    {
                        _1401 = _1335;
                        _1397 = _1331;
                        _1380 = _1314;
                    }
                    _1418 = _1298.y;
                    _1406 = _1296.y;
                    _1400 = _1401;
                    _1396 = _1397;
                    _1379 = _1380;
                    _1372 = false;
                    break;
                }
                highp vec2 _1033 = (vec2(_586.xz) - targetUV.xx) * _560.x;
                highp vec2 _1044 = (vec2(_586.yw) - targetUV.yy) * _560.y;
                highp vec2 _1367;
                if (_1033.x > _1033.y)
                {
                    _1367 = _1033.yx;
                }
                else
                {
                    _1367 = _1033;
                }
                highp vec2 _1368;
                if (_1044.x > _1044.y)
                {
                    _1368 = _1044.yx;
                }
                else
                {
                    _1368 = _1044;
                }
                highp float _1076 = max(0.0, max(_1367.x, _1368.x));
                bool _1082 = _1076 < min(_1367.y, _1368.y);
                bool _1093;
                if (_1082)
                {
                    _1093 = (_1076 * _1076) < _1331;
                }
                else
                {
                    _1093 = _1082;
                }
                if (_1093)
                {
                    _1418 = floatBitsToInt(_574.w);
                    _1406 = _1076;
                    _1400 = _1335;
                    _1396 = _1331;
                    _1379 = _1314;
                    _1372 = true;
                    break;
                }
                _1418 = _1298.y;
                _1406 = _1296.y;
                _1400 = _1335;
                _1396 = _1331;
                _1379 = _1314;
                _1372 = false;
                break;
            } while(false);
            highp vec2 _1276 = _1234;
            _1276.y = _1406;
            ivec2 _1278 = _1236;
            _1278.y = _1418;
            if (_1400 != 4294967295u)
            {
                _1460 = _1400;
                break;
            }
            if (_1307 && _1372)
            {
                ivec2 _1447;
                highp vec2 _1533;
                if (_1341 < _1406)
                {
                    _1533 = _1276.yx;
                    _1447 = _1278.yx;
                }
                else
                {
                    _1533 = _1276;
                    _1447 = _1278;
                }
                int _649 = _1437 + 1;
                _1142[_649] = _1447.x;
                _1541 = _649;
                _1537 = _1447;
                _1532 = _1533;
                _1485 = _1447.y;
                _1462 = _1285;
            }
            else
            {
                bool _1477;
                int _1486;
                int _1542;
                if (_1307)
                {
                    _1542 = _1437;
                    _1486 = _1353;
                    _1477 = _1285;
                }
                else
                {
                    bool _1478;
                    int _1487;
                    int _1543;
                    if (_1372)
                    {
                        _1543 = _1437;
                        _1487 = _1418;
                        _1478 = _1285;
                    }
                    else
                    {
                        bool _668 = _1437 > 0;
                        int _1488;
                        int _1544;
                        if (_668)
                        {
                            _1544 = _1437 - 1;
                            _1488 = _1142[_1437];
                        }
                        else
                        {
                            _1544 = _1437;
                            _1488 = _1287;
                        }
                        _1543 = _1544;
                        _1487 = _1488;
                        _1478 = _668 ? _1285 : true;
                    }
                    _1542 = _1543;
                    _1486 = _1487;
                    _1477 = _1478;
                }
                _1541 = _1542;
                _1537 = _1278;
                _1532 = _1276;
                _1485 = _1486;
                _1462 = _1477;
            }
            _1437 = _1541;
            _1298 = _1537;
            _1296 = _1532;
            _1295 = _1400;
            _1294 = _1396;
            _1289 = _1379;
            _1287 = _1485;
            _1285 = _1462;
            continue;
        }
        else
        {
            _1460 = _1295;
            break;
        }
    }
    col = vec4((normalize(vec3(targetUV, length(targetUV))) * float(_1460 == 4294967295u)) * pow(_452 + 1.0, -10.0), 1.0);
}
