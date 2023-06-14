#version 300 es
uniform highp sampler2D v1LinesBvh;
out vec3 vsToFsCol;
void main()
{
    int _105 = gl_VertexID & 1;
    int _108 = gl_VertexID / 2;
    int _112 = _108 & 3;
    int _114 = _108 / 4;
    int _117 = _114 & 1;
    int _119 = _114 / 2;
    int _131 = _119 * 3;
    vec4 _136 = texelFetch(v1LinesBvh, ivec2(_131, 0), 0);
    vec4 _146 = texelFetch(v1LinesBvh, ivec2((_131 + 1) + _117, 0), 0);
    float _337;
    if (_117 == 0)
    {
        _337 = _136.x;
    }
    else
    {
        _337 = _136.z;
    }
    bool _170 = !(floatBitsToInt(_337) == 0);
    vec2 _344;
    if (_170)
    {
        vec2 _345;
        if (_112 == 0)
        {
            vec2 _178 = _146.xy;
            vec2 _346;
            if (_105 == 1)
            {
                _346 = _178 - _146.zw;
            }
            else
            {
                _346 = _178;
            }
            _345 = _346;
        }
        else
        {
            _345 = vec2(0.0);
        }
        _344 = _345;
    }
    else
    {
        vec2 _347;
        switch (_112)
        {
            case 0:
            {
                vec2 _341;
                if (_105 == 0)
                {
                    _341 = _146.xy;
                }
                else
                {
                    _341 = _146.zy;
                }
                _347 = _341;
                break;
            }
            case 1:
            {
                vec2 _340;
                if (_105 == 0)
                {
                    _340 = _146.zy;
                }
                else
                {
                    _340 = _146.zw;
                }
                _347 = _340;
                break;
            }
            case 2:
            {
                vec2 _339;
                if (_105 == 0)
                {
                    _339 = _146.zw;
                }
                else
                {
                    _339 = _146.xw;
                }
                _347 = _339;
                break;
            }
            case 3:
            {
                vec2 _338;
                if (_105 == 0)
                {
                    _338 = _146.xw;
                }
                else
                {
                    _338 = _146.xy;
                }
                _347 = _338;
                break;
            }
            default:
            {
                _347 = vec2(0.0);
                break;
            }
        }
        _344 = _347;
    }
    uint _253 = uint((_119 * 2) + _117) * 123u;
    uint _298 = ((_253 ^ 61u) ^ (_253 >> uint(16))) * 9u;
    uint _304 = (_298 ^ (_298 >> uint(4))) * 668265261u;
    float _316 = float((_304 ^ (_304 >> uint(15))) & 65535u) * 9.15541313588619232177734375e-05;
    vec3 _334 = clamp(vec3(abs(_316 - 3.0) - 1.0, 2.0 - abs(_316 - 2.0), 2.0 - abs(_316 - 4.0)), vec3(0.0), vec3(1.0));
    vec3 _342;
    if (_170)
    {
        _342 = _334 * 2.0;
    }
    else
    {
        _342 = _334;
    }
    vsToFsCol = _342;
    gl_Position = vec4((_344 * 2.0) - vec2(1.0), 0.0, 1.0);
}
