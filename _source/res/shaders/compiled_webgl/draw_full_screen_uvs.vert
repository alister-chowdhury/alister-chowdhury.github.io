#version 300 es
out vec2 uv;
void main()
{
    float _21 = (gl_VertexID == 0) ? (-4.0) : 1.0;
    float _27 = (gl_VertexID == 2) ? 4.0 : (-1.0);
    uv = (vec2(_21, _27) * 0.5) + vec2(0.5);
    gl_Position = vec4(_21, _27, 0.0, 1.0);
}
