#version 300 es
precision highp float;
precision highp int;
uniform highp sampler2D v1LinesBvh;
uniform highp vec2 targetUV;
in highp vec2 uv;
layout(location = 0) out highp vec4 col;
vec2 _1278;
ivec2 _1280;
vec2 _1530;
ivec2 _1531;
void main()
{
    highp vec2 _450 = uv - targetUV;
    highp float _453 = length(_450);
    highp vec2 _458 = _450 / vec2(_453);
    highp float _530 = _453 * _453;
    highp vec2 _541 = vec2(1.0) / _458;
    highp vec2 _1270;
    highp vec2 _1277;
    ivec2 _1279;
    _1279 = _1280;
    _1277 = _1278;
    _1270 = _458 * _453;
    int _1123[16];
    highp vec2 _1360;
    highp float _1377;
    uint _1381;
    uint _1441;
    bool _1443;
    int _1466;
    highp vec2 _1513;
    ivec2 _1518;
    int _1522;
    bool _1266 = false;
    int _1268 = 0;
    highp float _1275 = _530;
    uint _1276 = 4294967295u;
    int _1418 = 0;
    for (;;)
    {
        if (!_1266)
        {
            highp vec4 _555 = texelFetch(v1LinesBvh, ivec2(_1268, 0), 0);
            highp vec4 _561 = texelFetch(v1LinesBvh, ivec2(_1268 + 1, 0), 0);
            highp vec4 _567 = texelFetch(v1LinesBvh, ivec2(_1268 + 2, 0), 0);
            bool _1288;
            highp vec2 _1295;
            highp float _1312;
            uint _1316;
            highp float _1322;
            int _1334;
            do
            {
                if (floatBitsToInt(_555.xy).x == 1)
                {
                    highp vec2 _694 = -_1270;
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
                    highp vec2 _1296;
                    highp float _1313;
                    uint _1317;
                    if (_760)
                    {
                        highp vec2 _780 = _1270 * (_747 / abs(_712));
                        _1317 = floatBitsToUint(_555.y);
                        _1313 = dot(_780, _780);
                        _1296 = _780;
                    }
                    else
                    {
                        _1317 = _1276;
                        _1313 = _1275;
                        _1296 = _1270;
                    }
                    _1334 = _1279.x;
                    _1322 = _1277.x;
                    _1316 = _1317;
                    _1312 = _1313;
                    _1295 = _1296;
                    _1288 = false;
                    break;
                }
                highp vec2 _804 = (vec2(_561.xz) - targetUV.xx) * _541.x;
                highp vec2 _815 = (vec2(_561.yw) - targetUV.yy) * _541.y;
                highp vec2 _1283;
                if (_804.x > _804.y)
                {
                    _1283 = _804.yx;
                }
                else
                {
                    _1283 = _804;
                }
                highp vec2 _1284;
                if (_815.x > _815.y)
                {
                    _1284 = _815.yx;
                }
                else
                {
                    _1284 = _815;
                }
                highp float _847 = max(0.0, max(_1283.x, _1284.x));
                bool _853 = _847 < min(_1283.y, _1284.y);
                bool _864;
                if (_853)
                {
                    _864 = (_847 * _847) < _1275;
                }
                else
                {
                    _864 = _853;
                }
                if (_864)
                {
                    _1334 = floatBitsToInt(_555.y);
                    _1322 = _847;
                    _1316 = _1276;
                    _1312 = _1275;
                    _1295 = _1270;
                    _1288 = true;
                    break;
                }
                _1334 = _1279.x;
                _1322 = _1277.x;
                _1316 = _1276;
                _1312 = _1275;
                _1295 = _1270;
                _1288 = false;
                break;
            } while(false);
            highp vec2 _1215 = _1530;
            _1215.x = _1322;
            ivec2 _1217 = _1531;
            _1217.x = _1334;
            bool _1353;
            highp float _1387;
            int _1399;
            do
            {
                if (floatBitsToInt(_555.zw).x == 1)
                {
                    highp vec2 _904 = -_1295;
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
                    highp vec2 _1361;
                    highp float _1378;
                    uint _1382;
                    if (_970)
                    {
                        highp vec2 _990 = _1295 * (_957 / abs(_922));
                        _1382 = floatBitsToUint(_555.w);
                        _1378 = dot(_990, _990);
                        _1361 = _990;
                    }
                    else
                    {
                        _1382 = _1316;
                        _1378 = _1312;
                        _1361 = _1295;
                    }
                    _1399 = _1279.y;
                    _1387 = _1277.y;
                    _1381 = _1382;
                    _1377 = _1378;
                    _1360 = _1361;
                    _1353 = false;
                    break;
                }
                highp vec2 _1014 = (vec2(_567.xz) - targetUV.xx) * _541.x;
                highp vec2 _1025 = (vec2(_567.yw) - targetUV.yy) * _541.y;
                highp vec2 _1348;
                if (_1014.x > _1014.y)
                {
                    _1348 = _1014.yx;
                }
                else
                {
                    _1348 = _1014;
                }
                highp vec2 _1349;
                if (_1025.x > _1025.y)
                {
                    _1349 = _1025.yx;
                }
                else
                {
                    _1349 = _1025;
                }
                highp float _1057 = max(0.0, max(_1348.x, _1349.x));
                bool _1063 = _1057 < min(_1348.y, _1349.y);
                bool _1074;
                if (_1063)
                {
                    _1074 = (_1057 * _1057) < _1312;
                }
                else
                {
                    _1074 = _1063;
                }
                if (_1074)
                {
                    _1399 = floatBitsToInt(_555.w);
                    _1387 = _1057;
                    _1381 = _1316;
                    _1377 = _1312;
                    _1360 = _1295;
                    _1353 = true;
                    break;
                }
                _1399 = _1279.y;
                _1387 = _1277.y;
                _1381 = _1316;
                _1377 = _1312;
                _1360 = _1295;
                _1353 = false;
                break;
            } while(false);
            highp vec2 _1257 = _1215;
            _1257.y = _1387;
            ivec2 _1259 = _1217;
            _1259.y = _1399;
            if (_1381 != 4294967295u)
            {
                _1441 = _1381;
                break;
            }
            if (_1288 && _1353)
            {
                ivec2 _1428;
                highp vec2 _1514;
                if (_1322 < _1387)
                {
                    _1514 = _1257.yx;
                    _1428 = _1259.yx;
                }
                else
                {
                    _1514 = _1257;
                    _1428 = _1259;
                }
                int _630 = _1418 + 1;
                _1123[_630] = _1428.x;
                _1522 = _630;
                _1518 = _1428;
                _1513 = _1514;
                _1466 = _1428.y;
                _1443 = _1266;
            }
            else
            {
                bool _1458;
                int _1467;
                int _1523;
                if (_1288)
                {
                    _1523 = _1418;
                    _1467 = _1334;
                    _1458 = _1266;
                }
                else
                {
                    bool _1459;
                    int _1468;
                    int _1524;
                    if (_1353)
                    {
                        _1524 = _1418;
                        _1468 = _1399;
                        _1459 = _1266;
                    }
                    else
                    {
                        bool _649 = _1418 > 0;
                        int _1469;
                        int _1525;
                        if (_649)
                        {
                            _1525 = _1418 - 1;
                            _1469 = _1123[_1418];
                        }
                        else
                        {
                            _1525 = _1418;
                            _1469 = _1268;
                        }
                        _1524 = _1525;
                        _1468 = _1469;
                        _1459 = _649 ? _1266 : true;
                    }
                    _1523 = _1524;
                    _1467 = _1468;
                    _1458 = _1459;
                }
                _1522 = _1523;
                _1518 = _1259;
                _1513 = _1257;
                _1466 = _1467;
                _1443 = _1458;
            }
            _1418 = _1522;
            _1279 = _1518;
            _1277 = _1513;
            _1276 = _1381;
            _1275 = _1377;
            _1270 = _1360;
            _1268 = _1466;
            _1266 = _1443;
            continue;
        }
        else
        {
            _1441 = _1276;
            break;
        }
    }
    highp float _471 = float(_1441 == 4294967295u);
    col = vec4(_471, _471, _471, 1.0);
}
