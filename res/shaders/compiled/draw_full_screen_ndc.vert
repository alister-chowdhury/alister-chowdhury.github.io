#version 300 es
out vec2 ndc;void main(){ndc=vec2((gl_VertexID==0)?(-4.):1.,(gl_VertexID==2)?4.:(-1.));gl_Position=vec4(ndc,0.,1.);}