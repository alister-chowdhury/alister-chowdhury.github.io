#version 300 es
out vec2 uv;
void main()
{
    float _21 = float((gl_VertexID == 0) ? (-4) : 1);
    float _28 = float((gl_VertexID == 2) ? 4 : (-1));
    gl_Position = vec4(_21, _28, 0.0, 1.0);
    uv = (vec2(_21, _28) * 0.5) + vec2(0.5);
}
