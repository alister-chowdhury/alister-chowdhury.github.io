#version 300 es
precision highp float;precision highp int;vec2 _;ivec2 a;uniform highp sampler2D v1LinesBvh;uniform highp vec2 targetUV;in highp vec2 uv;layout(location=0)out highp vec4 col;void main(){highp vec2 b=uv-targetUV;highp float c=length(b);highp vec2 d=b/vec2(c);highp float e=c*c;highp vec2 f=vec2(1.)/d;int g;highp vec2 h;highp vec2 i;ivec2 j;j=a;i=_;h=d*c;g=0;int k[16];int l;highp vec2 m;highp float n;bool o;int p;highp vec2 q;ivec2 r;int s;bool t=false;int u=0;highp float v=e;int w=0;for(;!t;w=s,j=r,i=q,v=n,h=m,g=l,u=p,t=o){highp vec4 x=texelFetch(v1LinesBvh,ivec2(u,0),0);highp vec4 y=texelFetch(v1LinesBvh,ivec2(u+1,0),0);highp vec4 z=texelFetch(v1LinesBvh,ivec2(u+2,0),0);bool A;int B;highp vec2 C;highp float D;highp float E;int F;do{if(floatBitsToInt(x.xy).x==1){highp vec2 G=-h;highp vec2 H=targetUV-y.xy;highp float I=G.x;highp float J=y.w;highp float K=G.y;highp float L=y.z;highp float M=I*J+(-(K*L));highp float N=H.x;highp float O=H.y;uint P=floatBitsToUint(M)&2147483648u;highp float Q=uintBitsToFloat(floatBitsToUint(N*K+(-(O*I)))^P);highp float R=uintBitsToFloat(floatBitsToUint(N*J+(-(O*L)))^P);bool S=min(Q,R)>=0.;bool T;if(S){T=max(Q,R)<=abs(M);}else{T=S;}highp vec2 U;highp float V;if(T){highp vec2 W=h*(R/abs(M));V=dot(W,W);U=W;}else{V=v;U=h;}F=j.x;E=i.x;D=V;C=U;B=g+1;A=false;break;}highp vec2 X=(vec2(y.xz)-targetUV.xx)*f.x;highp vec2 Y=(vec2(y.yw)-targetUV.yy)*f.y;highp vec2 Z;if(X.x>X.y){Z=X.yx;}else{Z=X;}highp vec2 a_;if(Y.x>Y.y){a_=Y.yx;}else{a_=Y;}highp float b_=max(0.,max(Z.x,a_.x));bool c_=b_<min(Z.y,a_.y);bool d_;if(c_){d_=(b_*b_)<v;}else{d_=c_;}if(d_){F=floatBitsToInt(x.y);E=b_;D=v;C=h;B=g;A=true;break;}F=j.x;E=i.x;D=v;C=h;B=g;A=false;break;}while(false);bool e_;highp float f_;int g_;do{if(floatBitsToInt(x.zw).x==1){highp vec2 h_=-C;highp vec2 i_=targetUV-z.xy;highp float j_=h_.x;highp float k_=z.w;highp float l_=h_.y;highp float m_=z.z;highp float n_=j_*k_+(-(l_*m_));highp float o_=i_.x;highp float p_=i_.y;uint q_=floatBitsToUint(n_)&2147483648u;highp float r_=uintBitsToFloat(floatBitsToUint(o_*l_+(-(p_*j_)))^q_);highp float s_=uintBitsToFloat(floatBitsToUint(o_*k_+(-(p_*m_)))^q_);bool t_=min(r_,s_)>=0.;bool u_;if(t_){u_=max(r_,s_)<=abs(n_);}else{u_=t_;}highp vec2 v_;highp float w_;if(u_){highp vec2 x_=C*(s_/abs(n_));w_=dot(x_,x_);v_=x_;}else{w_=D;v_=C;}g_=j.y;f_=i.y;n=w_;m=v_;l=B+1;e_=false;break;}highp vec2 y_=(vec2(z.xz)-targetUV.xx)*f.x;highp vec2 z_=(vec2(z.yw)-targetUV.yy)*f.y;highp vec2 A_;if(y_.x>y_.y){A_=y_.yx;}else{A_=y_;}highp vec2 B_;if(z_.x>z_.y){B_=z_.yx;}else{B_=z_;}highp float C_=max(0.,max(A_.x,B_.x));bool D_=C_<min(A_.y,B_.y);bool E_;if(D_){E_=(C_*C_)<D;}else{E_=D_;}if(E_){g_=floatBitsToInt(x.w);f_=C_;n=D;m=C;l=B;e_=true;break;}g_=j.y;f_=i.y;n=D;m=C;l=B;e_=false;break;}while(false);highp vec2 F_=vec2(E,f_);ivec2 G_=ivec2(F,g_);if(A&&e_){ivec2 H_;highp vec2 I_;if(E<f_){I_=F_.yx;H_=G_.yx;}else{I_=F_;H_=G_;}int J_=w+1;k[J_]=H_.x;s=J_;r=H_;q=I_;p=H_.y;o=t;}else{bool K_;int L_;int M_;if(A){M_=w;L_=F;K_=t;}else{bool N_;int O_;int P_;if(e_){P_=w;O_=g_;N_=t;}else{bool Q_=w>0;int R_;int S_;if(Q_){S_=w-1;R_=k[w];}else{S_=w;R_=u;}P_=S_;O_=R_;N_=Q_?t:true;}M_=P_;L_=O_;K_=N_;}s=M_;r=G_;q=F_;p=L_;o=K_;}}highp float T_=float(g)*.0625;col=vec4(T_,T_,T_,1.);}