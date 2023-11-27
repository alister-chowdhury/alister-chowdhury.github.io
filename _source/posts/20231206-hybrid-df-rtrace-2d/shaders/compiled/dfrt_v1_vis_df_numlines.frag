#version 300 es
precision highp float;
precision highp int;
uniform highp vec4 v1HybridParams;
uniform highp usampler2D v1DfTexture;
in highp vec2 uv;
layout(location = 0) out highp vec4 col;
void main()
{
    highp float _58 = float((texelFetch(v1DfTexture, ivec2(uv * v1HybridParams.xx), 0).x >> uint(8)) & 255u) * 0.25;
    col = vec4(_58, _58, _58, 1.0);
}
