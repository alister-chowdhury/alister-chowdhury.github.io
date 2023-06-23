#version 300 es
void main()
{
    gl_Position = vec4((gl_VertexID == 0) ? (-4.0) : 1.0, (gl_VertexID == 2) ? 4.0 : (-1.0), 0.0, 1.0);
}
