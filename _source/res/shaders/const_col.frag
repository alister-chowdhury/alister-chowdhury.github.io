#version 460 core

layout(location=1) uniform vec4 constCol;
layout(location=0) out vec4 outValue;

void main()
{
    outValue = constCol;
}
