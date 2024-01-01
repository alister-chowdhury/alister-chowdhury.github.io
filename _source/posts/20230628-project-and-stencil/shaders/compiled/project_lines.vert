#version 300 es
uniform highp sampler2D lines;
uniform highp vec2 playerPosition;
void main()
{
    uint _233 = uint(gl_VertexID);
    vec4 _241 = texelFetch(lines, ivec2(int(_233 / 9u), 0), 0);
    uint _498;
    switch (_233 % 9u)
    {
        case 0u:
        case 8u:
        {
            _498 = 0u;
            break;
        }
        case 1u:
        {
            _498 = 1u;
            break;
        }
        case 2u:
        case 3u:
        case 6u:
        {
            _498 = 2u;
            break;
        }
        case 4u:
        {
            _498 = 3u;
            break;
        }
        default:
        {
            _498 = 4u;
            break;
        }
    }
    vec2 _254 = _241.xy;
    vec2 _257 = _241.zw;
    vec2 _503;
    do
    {
        if (_498 == 0u)
        {
            _503 = _254;
            break;
        }
        if (_498 == 1u)
        {
            _503 = _257;
            break;
        }
        vec2 _331 = _257 - playerPosition;
        float _333 = _331.x;
        float _343 = _331.y;
        vec2 _360 = _257 + (_331 * min(max(0.0, max((((_333 >= 0.0) ? 1.0 : (-1.0)) - _241.z) / _333, (((_343 >= 0.0) ? 1.0 : (-1.0)) - _241.w) / _343)), 1.0000000409184787596297531937522e+35));
        if (_498 == 2u)
        {
            _503 = _360;
            break;
        }
        vec2 _368 = _254 - playerPosition;
        float _370 = _368.x;
        float _380 = _368.y;
        vec2 _397 = _254 + (_368 * min(max(0.0, max((((_370 >= 0.0) ? 1.0 : (-1.0)) - _241.x) / _370, (((_380 >= 0.0) ? 1.0 : (-1.0)) - _241.y) / _380)), 1.0000000409184787596297531937522e+35));
        if (_498 == 4u)
        {
            _503 = _397;
            break;
        }
        vec2 _411 = (_368 * length(_331)) + (_331 * length(_368));
        vec2 _416 = vec2(_397.x, _360.y);
        vec2 _421 = vec2(_360.x, _397.y);
        bvec2 _504 = bvec2(dot(_411, _416 - playerPosition) <= 0.0);
        vec2 _505 = vec2(_504.x ? vec2(0.0).x : _416.x, _504.y ? vec2(0.0).y : _416.y);
        bvec2 _506 = bvec2(dot(_411, _421 - playerPosition) <= 0.0);
        vec2 _507 = vec2(_506.x ? vec2(0.0).x : _421.x, _506.y ? vec2(0.0).y : _421.y);
        bvec2 _447 = bvec2(abs(_505.x) > abs(_507.x));
        vec2 _448 = vec2(_447.x ? _505.x : _507.x, _447.y ? _505.y : _507.y);
        bvec2 _458 = bvec2(abs(_505.y) > abs(_507.y));
        vec2 _459 = vec2(_458.x ? _505.x : _507.x, _458.y ? _505.y : _507.y);
        bvec2 _469 = bvec2(abs(_448.x) > abs(_459.y));
        _503 = vec2(_469.x ? _448.x : _459.x, _469.y ? _448.y : _459.y);
        break;
    } while(false);
    gl_Position = vec4(_503, 0.0, 1.0);
}
