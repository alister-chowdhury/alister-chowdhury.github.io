#version 460 core

layout(location=0) out vec2 uv;


void main()
{
    vec2 ndc = vec2(
        gl_VertexID == 0 ? -4 : 1,
        gl_VertexID == 2 ? 4 : -1
    );

    gl_Position = vec4(ndc, 0., 1.);
    uv = ndc * 0.5 + 0.5;
}
