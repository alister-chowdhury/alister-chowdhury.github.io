#version 300 es
precision highp float;
precision highp int;
uniform highp vec4 v1HybridParams;
uniform highp usampler2D v1DfTexture;
in highp vec2 uv;
layout(location = 0) out highp vec4 col;
void main()
{
    highp float _55 = float(texelFetch(v1DfTexture, ivec2(uv * v1HybridParams.xx), 0).x & 255u) * 0.01568627543747425079345703125;
    col = vec4(_55, _55, _55, 1.0);
}
