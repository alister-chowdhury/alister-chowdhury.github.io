#version 300 es
precision highp float;
precision highp int;
uniform highp usampler2D lightingData;
uniform highp sampler2D lightPlaneMap;
layout(location = 0) out uvec4 outOOBox;
vec3 _902;
void main()
{
    int _160 = int(gl_FragCoord.x);
    highp vec2 _543 = uintBitsToFloat(texelFetch(lightingData, ivec2(_160, 0), 0).xy);
    ivec2 _174 = textureSize(lightPlaneMap, 0);
    int _175 = _174.x;
    highp float _182 = uintBitsToFloat(2130706432u - floatBitsToUint(float(_175))) * 6.283185482025146484375;
    highp vec2 _815;
    _815 = vec2(0.0);
    highp float _907;
    highp vec2 _909;
    int _812 = 0;
    highp float _859 = -65504.0;
    for (; _812 < _175; _859 = _907, _815 = _909, _812++)
    {
        highp vec2 _593;
        highp vec4 _201 = texelFetch(lightPlaneMap, ivec2(_812, _160), 0);
        highp vec2 _209 = (_201.xy * 2.0) - vec2(1.0);
        highp vec3 _793 = _902;
        _793.x = _209.x;
        highp vec3 _795 = _793;
        _795.y = _209.y;
        highp float _217 = float(_812);
        highp float _220 = (_217 - 1.0) * _182;
        highp vec2 _854;
        do
        {
            highp vec2 _591 = vec2(cos(_220), sin(_220));
            _593 = _795.xy;
            highp float _595 = dot(_593, _591);
            if (abs(_595) <= 0.01745240576565265655517578125)
            {
                _854 = vec2(0.0);
                break;
            }
            _854 = _591 * (_201.z / _595);
            break;
        } while(false);
        highp float _230 = dot(_854, _854);
        highp float _236 = (_217 + 1.0) * _182;
        highp vec2 _856;
        do
        {
            highp vec2 _624 = vec2(cos(_236), sin(_236));
            highp float _628 = dot(_593, _624);
            if (abs(_628) <= 0.01745240576565265655517578125)
            {
                _856 = vec2(0.0);
                break;
            }
            _856 = _624 * (_201.z / _628);
            break;
        } while(false);
        highp float _246 = dot(_856, _856);
        bool _249 = _230 > _859;
        bvec2 _904 = bvec2(_249);
        highp vec2 _905 = vec2(_904.x ? _854.x : _815.x, _904.y ? _854.y : _815.y);
        highp float _906 = _249 ? _230 : _859;
        bool _256 = _246 > _906;
        _907 = _256 ? _246 : _906;
        bvec2 _908 = bvec2(_256);
        _909 = vec2(_908.x ? _856.x : _905.x, _908.y ? _856.y : _905.y);
    }
    highp vec2 _816;
    _816 = vec2(0.0);
    highp float _912;
    highp vec2 _914;
    int _813 = 0;
    highp float _849 = -65504.0;
    for (; _813 < _175; _849 = _912, _816 = _914, _813++)
    {
        highp vec2 _659;
        highp vec4 _280 = texelFetch(lightPlaneMap, ivec2(_813, _160), 0);
        highp vec2 _286 = (_280.xy * 2.0) - vec2(1.0);
        highp vec3 _799 = _902;
        _799.x = _286.x;
        highp vec3 _801 = _799;
        _801.y = _286.y;
        highp float _293 = float(_813);
        highp float _296 = (_293 - 1.0) * _182;
        highp vec2 _842;
        do
        {
            highp vec2 _657 = vec2(cos(_296), sin(_296));
            _659 = _801.xy;
            highp float _661 = dot(_659, _657);
            if (abs(_661) <= 0.01745240576565265655517578125)
            {
                _842 = vec2(0.0);
                break;
            }
            _842 = _657 * (_280.z / _661);
            break;
        } while(false);
        highp vec2 _306 = _842 - _815;
        highp float _310 = dot(_306, _306);
        highp float _316 = (_293 + 1.0) * _182;
        highp vec2 _845;
        do
        {
            highp vec2 _690 = vec2(cos(_316), sin(_316));
            highp float _694 = dot(_659, _690);
            if (abs(_694) <= 0.01745240576565265655517578125)
            {
                _845 = vec2(0.0);
                break;
            }
            _845 = _690 * (_280.z / _694);
            break;
        } while(false);
        highp vec2 _326 = _845 - _815;
        bool _333 = _310 > _849;
        bvec2 _910 = bvec2(_333);
        highp vec2 _911 = vec2(_910.x ? _842.x : _816.x, _910.y ? _842.y : _816.y);
        _912 = _333 ? _310 : _849;
        bvec2 _913 = bvec2(dot(_326, _326) > _912);
        _914 = vec2(_913.x ? _845.x : _911.x, _913.y ? _845.y : _911.y);
    }
    highp vec2 _357 = normalize(_816 - _815);
    highp vec2 _364 = vec2(_357.y, -_357.x);
    highp float _368 = dot(_364, _815);
    highp float _819;
    highp float _820;
    _820 = 0.0;
    _819 = 0.0;
    highp float _882;
    highp float _885;
    for (int _817 = 0; _817 < _175; _820 = _885, _819 = _882, _817++)
    {
        highp vec2 _725;
        highp vec4 _384 = texelFetch(lightPlaneMap, ivec2(_817, _160), 0);
        highp vec2 _390 = (_384.xy * 2.0) - vec2(1.0);
        highp vec3 _807 = _902;
        _807.x = _390.x;
        highp vec3 _809 = _807;
        _809.y = _390.y;
        highp float _397 = float(_817);
        highp float _400 = (_397 - 1.0) * _182;
        highp vec2 _822;
        do
        {
            highp vec2 _723 = vec2(cos(_400), sin(_400));
            _725 = _809.xy;
            highp float _727 = dot(_725, _723);
            if (abs(_727) <= 0.01745240576565265655517578125)
            {
                _822 = vec2(0.0);
                break;
            }
            _822 = _723 * (_384.z / _727);
            break;
        } while(false);
        highp float _412 = dot(_822, _364) - _368;
        highp float _418 = (_397 + 1.0) * _182;
        highp vec2 _824;
        do
        {
            highp vec2 _756 = vec2(cos(_418), sin(_418));
            highp float _760 = dot(_725, _756);
            if (abs(_760) <= 0.01745240576565265655517578125)
            {
                _824 = vec2(0.0);
                break;
            }
            _824 = _756 * (_384.z / _760);
            break;
        } while(false);
        highp float _430 = dot(_824, _364) - _368;
        highp float _829;
        highp float _832;
        if (_412 < 0.0)
        {
            _832 = (abs(_412) > abs(_819)) ? _412 : _819;
            _829 = _820;
        }
        else
        {
            _832 = _819;
            _829 = (_412 > _820) ? _412 : _820;
        }
        if (_430 < 0.0)
        {
            _885 = _829;
            _882 = (abs(_430) > abs(_832)) ? _430 : _832;
        }
        else
        {
            _885 = (_430 > _829) ? _430 : _829;
            _882 = _832;
        }
    }
    highp vec2 _475 = _364 * _819;
    highp vec2 _481 = _364 * _820;
    outOOBox = uvec4(packHalf2x16((_815 + _475) + _543), packHalf2x16((_815 + _481) + _543), packHalf2x16((_816 + _481) + _543), packHalf2x16((_816 + _475) + _543));
}
