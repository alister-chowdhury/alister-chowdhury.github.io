#version 300 es
precision highp float;
precision highp int;
uniform highp vec4 constCol;
layout(location = 0) out highp vec4 outValue;
void main()
{
    outValue = constCol;
}
