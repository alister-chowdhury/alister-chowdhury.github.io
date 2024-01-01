#version 300 es
uniform highp sampler2D v1LinesBvh;
out vec3 vsToFsCol;
void main()
{
    int _106 = gl_VertexID & 1;
    int _109 = gl_VertexID / 2;
    int _113 = _109 & 3;
    int _115 = _109 / 4;
    int _118 = _115 & 1;
    int _120 = _115 / 2;
    int _132 = _120 * 3;
    vec4 _137 = texelFetch(v1LinesBvh, ivec2(_132, 0), 0);
    vec4 _147 = texelFetch(v1LinesBvh, ivec2((_132 + 1) + _118, 0), 0);
    float _338;
    if (_118 == 0)
    {
        _338 = _137.x;
    }
    else
    {
        _338 = _137.z;
    }
    bool _171 = !(floatBitsToInt(_338) == 0);
    vec2 _345;
    if (_171)
    {
        vec2 _346;
        if (_113 == 0)
        {
            vec2 _179 = _147.xy;
            vec2 _347;
            if (_106 == 1)
            {
                _347 = _179 - _147.zw;
            }
            else
            {
                _347 = _179;
            }
            _346 = _347;
        }
        else
        {
            _346 = vec2(0.0);
        }
        _345 = _346;
    }
    else
    {
        vec2 _348;
        switch (_113)
        {
            case 0:
            {
                vec2 _342;
                if (_106 == 0)
                {
                    _342 = _147.xy;
                }
                else
                {
                    _342 = _147.zy;
                }
                _348 = _342;
                break;
            }
            case 1:
            {
                vec2 _341;
                if (_106 == 0)
                {
                    _341 = _147.zy;
                }
                else
                {
                    _341 = _147.zw;
                }
                _348 = _341;
                break;
            }
            case 2:
            {
                vec2 _340;
                if (_106 == 0)
                {
                    _340 = _147.zw;
                }
                else
                {
                    _340 = _147.xw;
                }
                _348 = _340;
                break;
            }
            case 3:
            {
                vec2 _339;
                if (_106 == 0)
                {
                    _339 = _147.xw;
                }
                else
                {
                    _339 = _147.xy;
                }
                _348 = _339;
                break;
            }
            default:
            {
                _348 = vec2(0.0);
                break;
            }
        }
        _345 = _348;
    }
    uint _254 = uint((_120 * 2) + _118) * 123u;
    uint _299 = ((_254 ^ 61u) ^ (_254 >> uint(16))) * 9u;
    uint _305 = (_299 ^ (_299 >> uint(4))) * 668265261u;
    float _288 = float((_305 ^ (_305 >> uint(15))) & 65535u);
    vec3 _335 = clamp(vec3(abs(_288 * 9.15541313588619232177734375e-05 + (-3.0)) - 1.0, 2.0 - abs(_288 * 9.15541313588619232177734375e-05 + (-2.0)), 2.0 - abs(_288 * 9.15541313588619232177734375e-05 + (-4.0))), vec3(0.0), vec3(1.0));
    vec3 _343;
    if (_171)
    {
        _343 = _335 * 2.0;
    }
    else
    {
        _343 = _335;
    }
    vsToFsCol = _343;
    gl_Position = vec4((_345 * 2.0) - vec2(1.0), 0.0, 1.0);
}
