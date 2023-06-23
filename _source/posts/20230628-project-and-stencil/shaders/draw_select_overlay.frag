#version 460 core

layout(location=0) in vec2 localNDC;
layout(location=0) out vec4 outCol;

void main()
{
    float l = length(localNDC);
    float outerLine = step(l, 1.0) * step(0.9, l);
    float innerDot = step(l, 0.1);
    outCol = vec4(1.0, 1.0, 1.0, 1.0) * max(outerLine, innerDot);
}
