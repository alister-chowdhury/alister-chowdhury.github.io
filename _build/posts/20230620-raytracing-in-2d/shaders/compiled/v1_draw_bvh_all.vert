#version 300 es
uniform highp sampler2D v1LinesBvh;out vec3 vsToFsCol;void main(){int _=gl_VertexID&1;int a=gl_VertexID/2;int b=a&3;int c=a/4;int d=c&1;int e=c/2;int f=e*3;vec4 g=texelFetch(v1LinesBvh,ivec2(f,0),0);vec4 h=texelFetch(v1LinesBvh,ivec2((f+1)+d,0),0);float i;if(d==0){i=g.x;}else{i=g.z;}bool j=!(floatBitsToInt(i)==0);vec2 k;if(j){vec2 l;if(b==0){vec2 m=h.xy;vec2 n;if(_==1){n=m-h.zw;}else{n=m;}l=n;}else{l=vec2(0.);}k=l;}else{vec2 o;switch(b){case 0:{vec2 p;if(_==0){p=h.xy;}else{p=h.zy;}o=p;break;}case 1:{vec2 q;if(_==0){q=h.zy;}else{q=h.zw;}o=q;break;}case 2:{vec2 r;if(_==0){r=h.zw;}else{r=h.xw;}o=r;break;}case 3:{vec2 s;if(_==0){s=h.xw;}else{s=h.xy;}o=s;break;}default:{o=vec2(0.);break;}}k=o;}uint t=uint((e*2)+d)*123u;uint u=((t^61u)^(t>>16u))*9u;uint v=(u^(u>>4u))*668265261u;float w=float((v^(v>>15u))&65535u);vec3 x=clamp(vec3(abs(w*9.155413e-05+(-3.))-1.,2.-abs(w*9.155413e-05+(-2.)),2.-abs(w*9.155413e-05+(-4.))),vec3(0.),vec3(1.));vec3 y;if(j){y=x*2.;}else{y=x;}vsToFsCol=y;gl_Position=vec4((k*2.)-vec2(1.),0.,1.);}