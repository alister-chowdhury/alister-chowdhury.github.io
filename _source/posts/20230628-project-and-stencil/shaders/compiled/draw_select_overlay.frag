#version 300 es
precision highp float;
precision highp int;
in highp vec2 localNDC;
layout(location = 0) out highp vec4 outCol;
void main()
{
    highp float _14 = length(localNDC);
    outCol = vec4(1.0) * max(step(_14, 1.0) * step(0.89999997615814208984375, _14), step(_14, 0.100000001490116119384765625));
}
