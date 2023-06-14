#version 300 es
uniform highp sampler2D v1LinesBvh;
out vec3 vsToFsCol;
void main()
{
    int _105 = gl_VertexID & 1;
    int _108 = gl_VertexID / 2;
    int _114 = _108 / 4;
    int _117 = _114 & 1;
    int _119 = _114 / 2;
    int _131 = _119 * 3;
    vec4 _136 = texelFetch(v1LinesBvh, ivec2(_131, 0), 0);
    vec4 _146 = texelFetch(v1LinesBvh, ivec2((_131 + 1) + _117, 0), 0);
    float _323;
    if (_117 == 0)
    {
        _323 = _136.x;
    }
    else
    {
        _323 = _136.z;
    }
    bool _170 = !(floatBitsToInt(_323) == 0);
    vec2 _330;
    if (_170)
    {
        _330 = vec2(0.0);
    }
    else
    {
        vec2 _331;
        switch (_108 & 3)
        {
            case 0:
            {
                vec2 _327;
                if (_105 == 0)
                {
                    _327 = _146.xy;
                }
                else
                {
                    _327 = _146.zy;
                }
                _331 = _327;
                break;
            }
            case 1:
            {
                vec2 _326;
                if (_105 == 0)
                {
                    _326 = _146.zy;
                }
                else
                {
                    _326 = _146.zw;
                }
                _331 = _326;
                break;
            }
            case 2:
            {
                vec2 _325;
                if (_105 == 0)
                {
                    _325 = _146.zw;
                }
                else
                {
                    _325 = _146.xw;
                }
                _331 = _325;
                break;
            }
            case 3:
            {
                vec2 _324;
                if (_105 == 0)
                {
                    _324 = _146.xw;
                }
                else
                {
                    _324 = _146.xy;
                }
                _331 = _324;
                break;
            }
            default:
            {
                _331 = vec2(0.0);
                break;
            }
        }
        _330 = _331;
    }
    uint _239 = uint((_119 * 2) + _117) * 123u;
    uint _284 = ((_239 ^ 61u) ^ (_239 >> uint(16))) * 9u;
    uint _290 = (_284 ^ (_284 >> uint(4))) * 668265261u;
    float _302 = float((_290 ^ (_290 >> uint(15))) & 65535u) * 9.15541313588619232177734375e-05;
    vec3 _320 = clamp(vec3(abs(_302 - 3.0) - 1.0, 2.0 - abs(_302 - 2.0), 2.0 - abs(_302 - 4.0)), vec3(0.0), vec3(1.0));
    vec3 _328;
    if (_170)
    {
        _328 = _320 * 2.0;
    }
    else
    {
        _328 = _320;
    }
    vsToFsCol = _328;
    gl_Position = vec4((_330 * 2.0) - vec2(1.0), 0.0, 1.0);
}
