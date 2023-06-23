#version 300 es
uniform highp sampler2D lines;void main(){uint _=uint(gl_VertexID);vec4 a=texelFetch(lines,ivec2(int(_/2u),0),0);vec2 b;if((_&1u)==0u){b=a.xy;}else{b=a.zw;}gl_Position=vec4(b,0.,1.);}