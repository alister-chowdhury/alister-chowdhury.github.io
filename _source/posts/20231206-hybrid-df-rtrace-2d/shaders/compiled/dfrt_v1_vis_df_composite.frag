#version 300 es
precision highp float;
precision highp int;
uniform highp vec4 v1HybridParams;
uniform highp usampler2D v1DfTexture;
in highp vec2 uv;
layout(location = 0) out highp vec4 col;
void main()
{
    uvec4 _36 = texelFetch(v1DfTexture, ivec2(uv * v1HybridParams.xx), 0);
    uint _38 = _36.x;
    highp float _55 = float(_38 & 255u) * 0.01568627543747425079345703125;
    highp float _58 = float((_38 >> uint(8)) & 255u) * 0.25;
    col = vec4(_55, _58, length(vec2(_55, _58)), 1.0);
}
