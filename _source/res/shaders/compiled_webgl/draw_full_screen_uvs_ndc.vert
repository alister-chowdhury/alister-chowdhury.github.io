#version 300 es
out vec2 ndc;
out vec2 uv;
void main()
{
    ndc = vec2((gl_VertexID == 0) ? (-4.0) : 1.0, (gl_VertexID == 2) ? 4.0 : (-1.0));
    uv = (ndc * 0.5) + vec2(0.5);
    gl_Position = vec4(ndc, 0.0, 1.0);
}
