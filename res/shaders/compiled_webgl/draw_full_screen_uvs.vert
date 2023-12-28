#version 300 es
out vec2 uv;void main(){float _=(gl_VertexID==0)?(-4.):1.;float a=(gl_VertexID==2)?4.:(-1.);uv=(vec2(_,a)*.5)+vec2(.5);gl_Position=vec4(_,a,0.,1.);}