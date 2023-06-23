#version 300 es
uniform highp sampler2D lines;
uniform highp vec2 playerPosition;
void main()
{
    uint _228 = uint(gl_VertexID);
    vec4 _236 = texelFetch(lines, ivec2(int(_228 / 9u), 0), 0);
    uint _489;
    switch (_228 % 9u)
    {
        case 0u:
        case 8u:
        {
            _489 = 0u;
            break;
        }
        case 1u:
        {
            _489 = 1u;
            break;
        }
        case 2u:
        case 3u:
        case 6u:
        {
            _489 = 2u;
            break;
        }
        case 4u:
        {
            _489 = 3u;
            break;
        }
        default:
        {
            _489 = 4u;
            break;
        }
    }
    vec2 _249 = _236.xy;
    vec2 _252 = _236.zw;
    vec2 _494;
    do
    {
        if (_489 == 0u)
        {
            _494 = _249;
            break;
        }
        if (_489 == 1u)
        {
            _494 = _252;
            break;
        }
        vec2 _326 = _252 - playerPosition;
        float _328 = _326.x;
        float _338 = _326.y;
        vec2 _353 = _252 + (_326 * max(0.0, max((((_328 >= 0.0) ? 1.0 : (-1.0)) - _236.z) / _328, (((_338 >= 0.0) ? 1.0 : (-1.0)) - _236.w) / _338)));
        if (_489 == 2u)
        {
            _494 = _353;
            break;
        }
        vec2 _361 = _249 - playerPosition;
        float _363 = _361.x;
        float _373 = _361.y;
        vec2 _388 = _249 + (_361 * max(0.0, max((((_363 >= 0.0) ? 1.0 : (-1.0)) - _236.x) / _363, (((_373 >= 0.0) ? 1.0 : (-1.0)) - _236.y) / _373)));
        if (_489 == 4u)
        {
            _494 = _388;
            break;
        }
        vec2 _402 = (_361 * length(_326)) + (_326 * length(_361));
        vec2 _407 = vec2(_388.x, _353.y);
        vec2 _412 = vec2(_353.x, _388.y);
        bvec2 _495 = bvec2(dot(_402, _407 - playerPosition) <= 0.0);
        vec2 _496 = vec2(_495.x ? vec2(0.0).x : _407.x, _495.y ? vec2(0.0).y : _407.y);
        bvec2 _497 = bvec2(dot(_402, _412 - playerPosition) <= 0.0);
        vec2 _498 = vec2(_497.x ? vec2(0.0).x : _412.x, _497.y ? vec2(0.0).y : _412.y);
        bvec2 _438 = bvec2(abs(_496.x) > abs(_498.x));
        vec2 _439 = vec2(_438.x ? _496.x : _498.x, _438.y ? _496.y : _498.y);
        bvec2 _449 = bvec2(abs(_496.y) > abs(_498.y));
        vec2 _450 = vec2(_449.x ? _496.x : _498.x, _449.y ? _496.y : _498.y);
        bvec2 _460 = bvec2(abs(_439.x) > abs(_450.y));
        _494 = vec2(_460.x ? _439.x : _450.x, _460.y ? _439.y : _450.y);
        break;
    } while(false);
    gl_Position = vec4(_494, 0.0, 1.0);
}
