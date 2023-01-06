#version 460 core

#ifdef VS_OUTPUT_UV
layout(location=VS_OUTPUT_UV) out vec2 uv;
#endif

#ifdef VS_OUTPUT_NDC
layout(location=VS_OUTPUT_NDC) out vec2 ndc;
#endif


void main()
{
    vec2 ndc = vec2(
        gl_VertexID == 0 ? -4 : 1,
        gl_VertexID == 2 ? 4 : -1
    );

    gl_Position = vec4(ndc, 0., 1.);


#ifdef VS_OUTPUT_UV
    uv = ndc * 0.5 + 0.5;
#endif

}
