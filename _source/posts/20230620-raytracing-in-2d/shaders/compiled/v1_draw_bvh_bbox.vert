#version 300 es
uniform highp sampler2D v1LinesBvh;
out vec3 vsToFsCol;
void main()
{
    int _106 = gl_VertexID & 1;
    int _109 = gl_VertexID / 2;
    int _115 = _109 / 4;
    int _118 = _115 & 1;
    int _120 = _115 / 2;
    int _132 = _120 * 3;
    vec4 _137 = texelFetch(v1LinesBvh, ivec2(_132, 0), 0);
    vec4 _147 = texelFetch(v1LinesBvh, ivec2((_132 + 1) + _118, 0), 0);
    float _324;
    if (_118 == 0)
    {
        _324 = _137.x;
    }
    else
    {
        _324 = _137.z;
    }
    bool _171 = !(floatBitsToInt(_324) == 0);
    vec2 _331;
    if (_171)
    {
        _331 = vec2(0.0);
    }
    else
    {
        vec2 _332;
        switch (_109 & 3)
        {
            case 0:
            {
                vec2 _328;
                if (_106 == 0)
                {
                    _328 = _147.xy;
                }
                else
                {
                    _328 = _147.zy;
                }
                _332 = _328;
                break;
            }
            case 1:
            {
                vec2 _327;
                if (_106 == 0)
                {
                    _327 = _147.zy;
                }
                else
                {
                    _327 = _147.zw;
                }
                _332 = _327;
                break;
            }
            case 2:
            {
                vec2 _326;
                if (_106 == 0)
                {
                    _326 = _147.zw;
                }
                else
                {
                    _326 = _147.xw;
                }
                _332 = _326;
                break;
            }
            case 3:
            {
                vec2 _325;
                if (_106 == 0)
                {
                    _325 = _147.xw;
                }
                else
                {
                    _325 = _147.xy;
                }
                _332 = _325;
                break;
            }
            default:
            {
                _332 = vec2(0.0);
                break;
            }
        }
        _331 = _332;
    }
    uint _240 = uint((_120 * 2) + _118) * 123u;
    uint _285 = ((_240 ^ 61u) ^ (_240 >> uint(16))) * 9u;
    uint _291 = (_285 ^ (_285 >> uint(4))) * 668265261u;
    float _274 = float((_291 ^ (_291 >> uint(15))) & 65535u);
    vec3 _321 = clamp(vec3(abs(_274 * 9.15541313588619232177734375e-05 + (-3.0)) - 1.0, 2.0 - abs(_274 * 9.15541313588619232177734375e-05 + (-2.0)), 2.0 - abs(_274 * 9.15541313588619232177734375e-05 + (-4.0))), vec3(0.0), vec3(1.0));
    vec3 _329;
    if (_171)
    {
        _329 = _321 * 2.0;
    }
    else
    {
        _329 = _321;
    }
    vsToFsCol = _329;
    gl_Position = vec4((_331 * 2.0) - vec2(1.0), 0.0, 1.0);
}
