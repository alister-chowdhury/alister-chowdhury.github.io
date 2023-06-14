#version 300 es
precision highp float;
precision highp int;
uniform highp sampler2D v1LinesBvh;
uniform highp vec2 targetUV;
in highp vec2 uv;
layout(location = 0) out highp vec4 col;
vec2 _1278;
ivec2 _1280;
vec2 _1531;
ivec2 _1532;
void main()
{
    highp vec2 _449 = uv - targetUV;
    highp float _452 = length(_449);
    highp vec2 _457 = _449 / vec2(_452);
    highp float _529 = _452 * _452;
    highp vec2 _540 = vec2(1.0) / _457;
    int _1267;
    highp vec2 _1270;
    highp vec2 _1277;
    ivec2 _1279;
    _1279 = _1280;
    _1277 = _1278;
    _1270 = _457 * _452;
    _1267 = 0;
    int _548;
    int _1122[16];
    highp vec2 _1360;
    highp float _1377;
    bool _1443;
    int _1466;
    highp vec2 _1513;
    ivec2 _1518;
    int _1522;
    bool _1266 = false;
    int _1268 = 0;
    highp float _1275 = _529;
    int _1418 = 0;
    for (; !_1266; _1418 = _1522, _1279 = _1518, _1277 = _1513, _1275 = _1377, _1270 = _1360, _1268 = _1466, _1267 = _548, _1266 = _1443)
    {
        _548 = _1267 + 1;
        highp vec4 _554 = texelFetch(v1LinesBvh, ivec2(_1268, 0), 0);
        highp vec4 _560 = texelFetch(v1LinesBvh, ivec2(_1268 + 1, 0), 0);
        highp vec4 _566 = texelFetch(v1LinesBvh, ivec2(_1268 + 2, 0), 0);
        bool _1288;
        highp vec2 _1295;
        highp float _1312;
        highp float _1322;
        int _1334;
        do
        {
            if (floatBitsToInt(_554.xy).x == 1)
            {
                highp vec2 _693 = -_1270;
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
                highp vec2 _1296;
                highp float _1313;
                if (_759)
                {
                    highp vec2 _779 = _1270 * (_746 / abs(_711));
                    _1313 = dot(_779, _779);
                    _1296 = _779;
                }
                else
                {
                    _1313 = _1275;
                    _1296 = _1270;
                }
                _1334 = _1279.x;
                _1322 = _1277.x;
                _1312 = _1313;
                _1295 = _1296;
                _1288 = false;
                break;
            }
            highp vec2 _803 = (vec2(_560.xz) - targetUV.xx) * _540.x;
            highp vec2 _814 = (vec2(_560.yw) - targetUV.yy) * _540.y;
            highp vec2 _1283;
            if (_803.x > _803.y)
            {
                _1283 = _803.yx;
            }
            else
            {
                _1283 = _803;
            }
            highp vec2 _1284;
            if (_814.x > _814.y)
            {
                _1284 = _814.yx;
            }
            else
            {
                _1284 = _814;
            }
            highp float _846 = max(0.0, max(_1283.x, _1284.x));
            bool _852 = _846 < min(_1283.y, _1284.y);
            bool _863;
            if (_852)
            {
                _863 = (_846 * _846) < _1275;
            }
            else
            {
                _863 = _852;
            }
            if (_863)
            {
                _1334 = floatBitsToInt(_554.y);
                _1322 = _846;
                _1312 = _1275;
                _1295 = _1270;
                _1288 = true;
                break;
            }
            _1334 = _1279.x;
            _1322 = _1277.x;
            _1312 = _1275;
            _1295 = _1270;
            _1288 = false;
            break;
        } while(false);
        highp vec2 _1215 = _1531;
        _1215.x = _1322;
        ivec2 _1217 = _1532;
        _1217.x = _1334;
        bool _1353;
        highp float _1387;
        int _1399;
        do
        {
            if (floatBitsToInt(_554.zw).x == 1)
            {
                highp vec2 _903 = -_1295;
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
                highp vec2 _1361;
                highp float _1378;
                if (_969)
                {
                    highp vec2 _989 = _1295 * (_956 / abs(_921));
                    _1378 = dot(_989, _989);
                    _1361 = _989;
                }
                else
                {
                    _1378 = _1312;
                    _1361 = _1295;
                }
                _1399 = _1279.y;
                _1387 = _1277.y;
                _1377 = _1378;
                _1360 = _1361;
                _1353 = false;
                break;
            }
            highp vec2 _1013 = (vec2(_566.xz) - targetUV.xx) * _540.x;
            highp vec2 _1024 = (vec2(_566.yw) - targetUV.yy) * _540.y;
            highp vec2 _1348;
            if (_1013.x > _1013.y)
            {
                _1348 = _1013.yx;
            }
            else
            {
                _1348 = _1013;
            }
            highp vec2 _1349;
            if (_1024.x > _1024.y)
            {
                _1349 = _1024.yx;
            }
            else
            {
                _1349 = _1024;
            }
            highp float _1056 = max(0.0, max(_1348.x, _1349.x));
            bool _1062 = _1056 < min(_1348.y, _1349.y);
            bool _1073;
            if (_1062)
            {
                _1073 = (_1056 * _1056) < _1312;
            }
            else
            {
                _1073 = _1062;
            }
            if (_1073)
            {
                _1399 = floatBitsToInt(_554.w);
                _1387 = _1056;
                _1377 = _1312;
                _1360 = _1295;
                _1353 = true;
                break;
            }
            _1399 = _1279.y;
            _1387 = _1277.y;
            _1377 = _1312;
            _1360 = _1295;
            _1353 = false;
            break;
        } while(false);
        highp vec2 _1257 = _1215;
        _1257.y = _1387;
        ivec2 _1259 = _1217;
        _1259.y = _1399;
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
            int _629 = _1418 + 1;
            _1122[_629] = _1428.x;
            _1522 = _629;
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
                    bool _648 = _1418 > 0;
                    int _1469;
                    int _1525;
                    if (_648)
                    {
                        _1525 = _1418 - 1;
                        _1469 = _1122[_1418];
                    }
                    else
                    {
                        _1525 = _1418;
                        _1469 = _1268;
                    }
                    _1524 = _1525;
                    _1468 = _1469;
                    _1459 = _648 ? _1266 : true;
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
    }
    highp float _476 = float(_1267) * 0.03125;
    col = vec4(_476, _476, _476, 1.0);
}
