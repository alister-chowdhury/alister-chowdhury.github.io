#version 460 core

// WebGL doesn't support 1D textures
#if TARGETTING_WEBGL
layout(binding=0) uniform sampler2D lines;
#define LINES_TEXEL_FETCH(P) texelFetch(lines, ivec2((P), 0), 0)
#else // TARGETTING_WEBGL
layout(binding=0) uniform sampler1D lines;
#define LINES_TEXEL_FETCH(P) texelFetch(lines, (P), 0)
#endif // TARGETTING_WEBGL


void main()
{
    vec4 line = LINES_TEXEL_FETCH(int(gl_VertexID / 2u));
    vec2 uv = ((gl_VertexID & 1u) == 0) ? line.xy : line.zw;
    gl_Position = vec4(uv * 2.0 - 1.0, 0., 1.);
}
