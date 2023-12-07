#version 300 es
precision highp float;precision highp int;uniform highp vec4 v1HybridParams;uniform highp usampler2D v1DfTexture;uniform highp sampler2D v1LinesBuffer;uniform highp vec2 targetUV;in highp vec2 uv;layout(location=0)out highp vec4 col;void main(){highp vec2 _=uv-targetUV;highp float a=length(_);highp vec2 b=_/vec2(a);bool c=min(targetUV.x,targetUV.y)<=0.;bool d;if(!c){d=max(targetUV.x,targetUV.y)>=1.;}else{d=c;}highp float e;highp vec2 f;if(d){highp vec2 g=vec2(1.)/b;highp vec2 h=(vec2(0.,1.)-targetUV.xx)*g.x;highp vec2 i=(vec2(0.,1.)-targetUV.yy)*g.y;highp vec2 j;if(h.x>h.y){j=h.yx;}else{j=h;}highp vec2 k;if(i.x>i.y){k=i.yx;}else{k=i;}highp float l=max(0.,max(j.x,k.x));bool m=l<min(j.y,k.y);bool n;if(m){n=(l*l)<(a*a);}else{n=m;}highp float o;highp vec2 p;if(n){highp float q=l+10.e-06;p=targetUV+(b*q);o=q;}else{p=targetUV;o=0.;}f=p;e=o;}else{f=targetUV;e=0.;}highp vec2 r;uint s;highp vec2 t;s=0u;r=f;t=b*a;uint u;uint v;highp vec2 w;uint x;bool y;bool z;bool A;highp float B;highp vec2 C;uint D;bool E=false;uint F=0u;highp float G=e;uint H=0u;bool I=true;for(;;){if(!E){highp vec2 J;J=r;v=F;highp float K;uint L;highp vec2 M;uint N;uint O;uint P;uint Q;highp float R=G;uint S=H;uint T=0u;uint U=0u;for(;;){if(v<128u){bool V=R>=a;bool W;if(!V){W=min(J.x,J.y)<0.;}else{W=V;}bool X;if(!W){X=max(J.x,J.y)>1.;}else{X=W;}if(X){D=S;C=J;B=R;z=false;P=U;O=T;break;}uvec4 Y=texelFetch(v1DfTexture,ivec2(J*v1HybridParams.xx),0);uint Z=Y.x;highp float a_=float(Z&255u)*.003921569;K=R+a_;uint b_=(Z>>8u)&255u;L=Z>>16u;M=J+(b*a_);if(b_>0u){uint c_=Z>>8u;bool d_=S==c_;Q=d_?S:c_;N=d_?0u:b_;}else{Q=S;N=b_;}if(N>0u){D=Q;C=M;B=K;z=I;P=L;O=N;break;}S=Q;J=M;R=K;v++;U=L;T=N;continue;}else{D=S;C=J;B=R;z=I;P=U;O=T;break;}}if(O==0u){y=z;x=v;break;}u=s+O;uint e_=P+O;w=t;A=E;bool f_;highp vec2 g_;for(uint h_=P;h_<e_;w=g_,h_++,A=f_){highp vec4 i_=texelFetch(v1LinesBuffer,ivec2(int(h_),0),0);highp vec2 j_=-w;highp vec2 k_=targetUV-i_.xy;highp float l_=j_.x;highp float m_=i_.w;highp float n_=j_.y;highp float o_=i_.z;highp float p_=(l_*m_)-(n_*o_);highp float q_=k_.x;highp float r_=k_.y;uint s_=floatBitsToUint(p_)&2147483648u;highp float t_=uintBitsToFloat(floatBitsToUint((q_*n_)-(r_*l_))^s_);highp float u_=uintBitsToFloat(floatBitsToUint((q_*m_)-(r_*o_))^s_);bool v_=min(t_,u_)>0.;bool w_;if(v_){w_=max(t_,u_)<abs(p_);}else{w_=v_;}if(w_){g_=w*(u_/abs(p_));}else{g_=w;}f_=w_?true:A;}s=u;H=D;r=C;G=B;F=v;E=A;I=z;t=w;continue;}else{y=I;x=F;break;}}col=vec4(float(x)*.0625,float(s)*.0625,float(!y),1.);}