#version 300 es
uniform highp sampler2D lines;
void main()
{
    uint _21 = uint(gl_VertexID);
    vec4 _29 = texelFetch(lines, ivec2(int(_21 / 2u), 0), 0);
    vec2 _62;
    if ((_21 & 1u) == 0u)
    {
        _62 = _29.xy;
    }
    else
    {
        _62 = _29.zw;
    }
    gl_Position = vec4(_62, 0.0, 1.0);
}
