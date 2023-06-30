#version 460 core

layout(location=0) in vec3 vsToFsCol;
layout(location=0) out vec4 outCol;


void main()
{
    outCol = vec4(vsToFsCol, 1.0);
}

