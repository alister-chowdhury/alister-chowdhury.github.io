#version 300 es
precision highp float;
precision highp int;
uniform highp sampler2D inTexture;
layout(location = 0) out uvec2 outValue;
uvec4 _1186;
void main()
{
    ivec2 _287 = ivec2(gl_FragCoord.xy) << ivec2(2);
    highp vec4 _322 = vec4(texelFetch(inTexture, _287, 0).x, texelFetch(inTexture, _287 + ivec2(1, 0), 0).x, texelFetch(inTexture, _287 + ivec2(2, 0), 0).x, texelFetch(inTexture, _287 + ivec2(3, 0), 0).x);
    highp vec4 _352 = vec4(texelFetch(inTexture, _287 + ivec2(0, 1), 0).x, texelFetch(inTexture, _287 + ivec2(1), 0).x, texelFetch(inTexture, _287 + ivec2(2, 1), 0).x, texelFetch(inTexture, _287 + ivec2(3, 1), 0).x);
    highp vec4 _382 = vec4(texelFetch(inTexture, _287 + ivec2(0, 2), 0).x, texelFetch(inTexture, _287 + ivec2(1, 2), 0).x, texelFetch(inTexture, _287 + ivec2(2), 0).x, texelFetch(inTexture, _287 + ivec2(3, 2), 0).x);
    highp vec4 _412 = vec4(texelFetch(inTexture, _287 + ivec2(0, 3), 0).x, texelFetch(inTexture, _287 + ivec2(1, 3), 0).x, texelFetch(inTexture, _287 + ivec2(2, 3), 0).x, texelFetch(inTexture, _287 + ivec2(3), 0).x);
    highp vec4 _420 = min(min(_322, _352), min(_382, _412));
    highp vec4 _428 = max(max(_322, _352), max(_382, _412));
    highp float _441 = min(min(_420.x, _420.y), min(_420.z, _420.w));
    highp float _452 = max(max(_428.x, _428.y), max(_428.z, _428.w));
    highp float _496 = 7.0 / (_452 - _441);
    highp vec4 _499 = vec4(_441);
    uvec4 _532 = uvec4(clamp(ivec4(((_322 - _499) * _496) + vec4(0.5)), ivec4(0), ivec4(7)));
    uvec4 _536 = uvec4(clamp(ivec4(((_352 - _499) * _496) + vec4(0.5)), ivec4(0), ivec4(7)));
    uvec4 _540 = uvec4(clamp(ivec4(((_382 - _499) * _496) + vec4(0.5)), ivec4(0), ivec4(7)));
    uvec4 _544 = uvec4(clamp(ivec4(((_412 - _499) * _496) + vec4(0.5)), ivec4(0), ivec4(7)));
    uint _570 = _532.x;
    uint _591 = 7u - _570;
    uint _1025;
    if (_591 != 0u)
    {
        _1025 = uint(8) - _570;
    }
    else
    {
        _1025 = _591;
    }
    uvec4 _963 = _1186;
    _963.x = (_1025 == 8u) ? 1u : _1025;
    uint _575 = _532.y;
    uint _604 = 7u - _575;
    uint _1029;
    if (_604 != 0u)
    {
        _1029 = uint(8) - _575;
    }
    else
    {
        _1029 = _604;
    }
    uvec4 _966 = _963;
    _966.y = (_1029 == 8u) ? 1u : _1029;
    uint _580 = _532.z;
    uint _617 = 7u - _580;
    uint _1033;
    if (_617 != 0u)
    {
        _1033 = uint(8) - _580;
    }
    else
    {
        _1033 = _617;
    }
    uvec4 _969 = _966;
    _969.z = (_1033 == 8u) ? 1u : _1033;
    uint _585 = _532.w;
    uint _630 = 7u - _585;
    uint _1037;
    if (_630 != 0u)
    {
        _1037 = uint(8) - _585;
    }
    else
    {
        _1037 = _630;
    }
    uvec4 _972 = _969;
    _972.w = (_1037 == 8u) ? 1u : _1037;
    uint _647 = _536.x;
    uint _668 = 7u - _647;
    uint _1049;
    if (_668 != 0u)
    {
        _1049 = uint(8) - _647;
    }
    else
    {
        _1049 = _668;
    }
    uvec4 _975 = _1186;
    _975.x = (_1049 == 8u) ? 1u : _1049;
    uint _652 = _536.y;
    uint _681 = 7u - _652;
    uint _1053;
    if (_681 != 0u)
    {
        _1053 = uint(8) - _652;
    }
    else
    {
        _1053 = _681;
    }
    uvec4 _978 = _975;
    _978.y = (_1053 == 8u) ? 1u : _1053;
    uint _657 = _536.z;
    uint _694 = 7u - _657;
    uint _1057;
    if (_694 != 0u)
    {
        _1057 = uint(8) - _657;
    }
    else
    {
        _1057 = _694;
    }
    uvec4 _981 = _978;
    _981.z = (_1057 == 8u) ? 1u : _1057;
    uint _662 = _536.w;
    uint _707 = 7u - _662;
    uint _1061;
    if (_707 != 0u)
    {
        _1061 = uint(8) - _662;
    }
    else
    {
        _1061 = _707;
    }
    uvec4 _984 = _981;
    _984.w = (_1061 == 8u) ? 1u : _1061;
    uint _724 = _540.x;
    uint _745 = 7u - _724;
    uint _1081;
    if (_745 != 0u)
    {
        _1081 = uint(8) - _724;
    }
    else
    {
        _1081 = _745;
    }
    uvec4 _987 = _1186;
    _987.x = (_1081 == 8u) ? 1u : _1081;
    uint _729 = _540.y;
    uint _758 = 7u - _729;
    uint _1085;
    if (_758 != 0u)
    {
        _1085 = uint(8) - _729;
    }
    else
    {
        _1085 = _758;
    }
    uvec4 _990 = _987;
    _990.y = (_1085 == 8u) ? 1u : _1085;
    uint _734 = _540.z;
    uint _771 = 7u - _734;
    uint _1089;
    if (_771 != 0u)
    {
        _1089 = uint(8) - _734;
    }
    else
    {
        _1089 = _771;
    }
    uvec4 _993 = _990;
    _993.z = (_1089 == 8u) ? 1u : _1089;
    uint _739 = _540.w;
    uint _784 = 7u - _739;
    uint _1093;
    if (_784 != 0u)
    {
        _1093 = uint(8) - _739;
    }
    else
    {
        _1093 = _784;
    }
    uvec4 _996 = _993;
    _996.w = (_1093 == 8u) ? 1u : _1093;
    uint _801 = _544.x;
    uint _822 = 7u - _801;
    uint _1121;
    if (_822 != 0u)
    {
        _1121 = uint(8) - _801;
    }
    else
    {
        _1121 = _822;
    }
    uvec4 _999 = _1186;
    _999.x = (_1121 == 8u) ? 1u : _1121;
    uint _806 = _544.y;
    uint _835 = 7u - _806;
    uint _1125;
    if (_835 != 0u)
    {
        _1125 = uint(8) - _806;
    }
    else
    {
        _1125 = _835;
    }
    uvec4 _1002 = _999;
    _1002.y = (_1125 == 8u) ? 1u : _1125;
    uint _811 = _544.z;
    uint _848 = 7u - _811;
    uint _1129;
    if (_848 != 0u)
    {
        _1129 = uint(8) - _811;
    }
    else
    {
        _1129 = _848;
    }
    uvec4 _1005 = _1002;
    _1005.z = (_1129 == 8u) ? 1u : _1129;
    uint _816 = _544.w;
    uint _861 = 7u - _816;
    uint _1133;
    if (_861 != 0u)
    {
        _1133 = uint(8) - _816;
    }
    else
    {
        _1133 = _861;
    }
    uvec4 _1008 = _1005;
    _1008.w = (_1133 == 8u) ? 1u : _1133;
    uvec4 _879 = _972 << uvec4(0u, 3u, 6u, 9u);
    uvec4 _881 = _984 << uvec4(12u, 15u, 18u, 21u);
    uvec4 _883 = _996 << uvec4(0u, 3u, 6u, 9u);
    uvec4 _885 = _1008 << uvec4(12u, 15u, 18u, 21u);
    uint _908 = ((((((_879.x | _879.y) | _879.z) | _879.w) | _881.x) | _881.y) | _881.z) | _881.w;
    outValue = uvec2((uint(_452 * 255.0) | (uint(_441 * 255.0) << uint(8))) | (_908 << uint(16)), (_908 >> uint(16)) | ((((((((_883.x | _883.y) | _883.z) | _883.w) | _885.x) | _885.y) | _885.z) | _885.w) << uint(8)));
}
