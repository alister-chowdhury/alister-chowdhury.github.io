#version 300 es
uniform highp sampler2D lightBBox;out vec3 vsToFsCol;void main(){int _=gl_VertexID&1;int a=gl_VertexID/2;int b=a/4;vec4 c=texelFetch(lightBBox,ivec2(b,0),0);vec2 d;switch(a&3){case 0:{vec2 e;if(_==0){e=c.xy;}else{e=c.zy;}d=e;break;}case 1:{vec2 f;if(_==0){f=c.zy;}else{f=c.zw;}d=f;break;}case 2:{vec2 g;if(_==0){g=c.zw;}else{g=c.xw;}d=g;break;}case 3:{vec2 h;if(_==0){h=c.xw;}else{h=c.xy;}d=h;break;}default:{d=vec2(0.);break;}}uint i=(uint(b)*5123u)+9128u;uint j=((i^61u)^(i>>16u))*9u;uint k=(j^(j>>4u))*668265261u;float l=float((k^(k>>15u))&65535u)*9.155413e-05;vsToFsCol=clamp(vec3(abs(l-3.)-1.,2.-abs(l-2.),2.-abs(l-4.)),vec3(0.),vec3(1.));gl_Position=vec4((d*2.)-vec2(1.),0.,1.);}