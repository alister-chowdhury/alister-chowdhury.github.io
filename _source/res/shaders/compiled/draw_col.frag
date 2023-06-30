#version 300 es
precision highp float;
precision highp int;
layout(location = 0) out highp vec4 outCol;
in highp vec3 vsToFsCol;
void main()
{
    outCol = vec4(vsToFsCol, 1.0);
}
