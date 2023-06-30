#version 300 es
uniform highp sampler2D v1LinesBvh;
out vec3 vsToFsCol;
void main()
{
    int _109 = gl_VertexID / 2;
    int _115 = _109 / 4;
    int _118 = _115 & 1;
    int _120 = _115 / 2;
    int _132 = _120 * 3;
    vec4 _137 = texelFetch(v1LinesBvh, ivec2(_132, 0), 0);
    vec4 _147 = texelFetch(v1LinesBvh, ivec2((_132 + 1) + _118, 0), 0);
    float _280;
    if (_118 == 0)
    {
        _280 = _137.x;
    }
    else
    {
        _280 = _137.z;
    }
    bool _171 = !(floatBitsToInt(_280) == 0);
    vec2 _283;
    if (_171)
    {
        vec2 _284;
        if ((_109 & 3) == 0)
        {
            vec2 _179 = _147.xy;
            vec2 _285;
            if ((gl_VertexID & 1) == 1)
            {
                _285 = _179 - _147.zw;
            }
            else
            {
                _285 = _179;
            }
            _284 = _285;
        }
        else
        {
            _284 = vec2(0.0);
        }
        _283 = _284;
    }
    else
    {
        _283 = vec2(0.0);
    }
    uint _196 = uint((_120 * 2) + _118) * 123u;
    uint _241 = ((_196 ^ 61u) ^ (_196 >> uint(16))) * 9u;
    uint _247 = (_241 ^ (_241 >> uint(4))) * 668265261u;
    float _259 = float((_247 ^ (_247 >> uint(15))) & 65535u) * 9.15541313588619232177734375e-05;
    vec3 _277 = clamp(vec3(abs(_259 - 3.0) - 1.0, 2.0 - abs(_259 - 2.0), 2.0 - abs(_259 - 4.0)), vec3(0.0), vec3(1.0));
    vec3 _281;
    if (_171)
    {
        _281 = _277 * 2.0;
    }
    else
    {
        _281 = _277;
    }
    vsToFsCol = _281;
    gl_Position = vec4((_283 * 2.0) - vec2(1.0), 0.0, 1.0);
}
