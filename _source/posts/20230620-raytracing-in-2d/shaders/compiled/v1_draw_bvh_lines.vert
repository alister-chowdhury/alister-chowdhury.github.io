#version 300 es
uniform highp sampler2D v1LinesBvh;
out vec3 vsToFsCol;
void main()
{
    int _108 = gl_VertexID / 2;
    int _114 = _108 / 4;
    int _117 = _114 & 1;
    int _119 = _114 / 2;
    int _131 = _119 * 3;
    vec4 _136 = texelFetch(v1LinesBvh, ivec2(_131, 0), 0);
    vec4 _146 = texelFetch(v1LinesBvh, ivec2((_131 + 1) + _117, 0), 0);
    float _279;
    if (_117 == 0)
    {
        _279 = _136.x;
    }
    else
    {
        _279 = _136.z;
    }
    bool _170 = !(floatBitsToInt(_279) == 0);
    vec2 _282;
    if (_170)
    {
        vec2 _283;
        if ((_108 & 3) == 0)
        {
            vec2 _178 = _146.xy;
            vec2 _284;
            if ((gl_VertexID & 1) == 1)
            {
                _284 = _178 - _146.zw;
            }
            else
            {
                _284 = _178;
            }
            _283 = _284;
        }
        else
        {
            _283 = vec2(0.0);
        }
        _282 = _283;
    }
    else
    {
        _282 = vec2(0.0);
    }
    uint _195 = uint((_119 * 2) + _117) * 123u;
    uint _240 = ((_195 ^ 61u) ^ (_195 >> uint(16))) * 9u;
    uint _246 = (_240 ^ (_240 >> uint(4))) * 668265261u;
    float _258 = float((_246 ^ (_246 >> uint(15))) & 65535u) * 9.15541313588619232177734375e-05;
    vec3 _276 = clamp(vec3(abs(_258 - 3.0) - 1.0, 2.0 - abs(_258 - 2.0), 2.0 - abs(_258 - 4.0)), vec3(0.0), vec3(1.0));
    vec3 _280;
    if (_170)
    {
        _280 = _276 * 2.0;
    }
    else
    {
        _280 = _276;
    }
    vsToFsCol = _280;
    gl_Position = vec4((_282 * 2.0) - vec2(1.0), 0.0, 1.0);
}
