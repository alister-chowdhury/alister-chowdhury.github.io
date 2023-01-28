#version 300 es
void main(){gl_Position=vec4(float((gl_VertexID==0)?(-4):1),float((gl_VertexID==2)?4:(-1)),0.,1.);}