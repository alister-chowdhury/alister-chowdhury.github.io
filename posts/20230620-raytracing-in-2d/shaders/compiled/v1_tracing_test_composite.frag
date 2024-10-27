#version 300 es
precision highp float;precision highp int;vec2 _;ivec2 a;uniform highp sampler2D v1LinesBvh;uniform highp vec2 targetUV;in highp vec2 uv;layout(location=0)out highp vec4 col;void main(){highp vec2 b=uv-targetUV;highp float c=length(b);highp vec2 d=b/vec2(c);highp float e=c*c;highp vec2 f=vec2(1.)/d;int g;int h;highp vec2 i;uint j;highp vec2 k;ivec2 l;l=a;k=_;j=4294967295u;i=d*c;h=0;g=0;int m;int n[16];int o;highp vec2 p;highp float q;uint r;bool s;int t;highp vec2 u;ivec2 v;int w;bool x=false;int y=0;highp float z=e;int A=0;for(;!x;A=w,l=v,k=u,j=r,z=q,i=p,h=o,y=t,g=m,x=s){m=g+1;highp vec4 B=texelFetch(v1LinesBvh,ivec2(y,0),0);highp vec4 C=texelFetch(v1LinesBvh,ivec2(y+1,0),0);highp vec4 D=texelFetch(v1LinesBvh,ivec2(y+2,0),0);bool E;int F;highp vec2 G;highp float H;uint I;highp float J;int K;do{if(floatBitsToInt(B.xy).x==1){highp vec2 L=-i;highp vec2 M=targetUV-C.xy;highp float N=L.x;highp float O=C.w;highp float P=L.y;highp float Q=C.z;highp float R=N*O+(-(P*Q));highp float S=M.x;highp float T=M.y;uint U=floatBitsToUint(R)&2147483648u;highp float V=uintBitsToFloat(floatBitsToUint(S*P+(-(T*N)))^U);highp float W=uintBitsToFloat(floatBitsToUint(S*O+(-(T*Q)))^U);bool X=min(V,W)>=0.;bool Y;if(X){Y=max(V,W)<=abs(R);}else{Y=X;}highp vec2 Z;highp float a_;uint b_;if(Y){highp vec2 c_=i*(W/abs(R));b_=floatBitsToUint(B.y);a_=dot(c_,c_);Z=c_;}else{b_=j;a_=z;Z=i;}K=l.x;J=k.x;I=b_;H=a_;G=Z;F=h+1;E=false;break;}highp vec2 d_=(vec2(C.xz)-targetUV.xx)*f.x;highp vec2 e_=(vec2(C.yw)-targetUV.yy)*f.y;highp vec2 f_;if(d_.x>d_.y){f_=d_.yx;}else{f_=d_;}highp vec2 g_;if(e_.x>e_.y){g_=e_.yx;}else{g_=e_;}highp float h_=max(0.,max(f_.x,g_.x));bool i_=h_<min(f_.y,g_.y);bool j_;if(i_){j_=(h_*h_)<z;}else{j_=i_;}if(j_){K=floatBitsToInt(B.y);J=h_;I=j;H=z;G=i;F=h;E=true;break;}K=l.x;J=k.x;I=j;H=z;G=i;F=h;E=false;break;}while(false);bool k_;highp float l_;int m_;do{if(floatBitsToInt(B.zw).x==1){highp vec2 n_=-G;highp vec2 o_=targetUV-D.xy;highp float p_=n_.x;highp float q_=D.w;highp float r_=n_.y;highp float s_=D.z;highp float t_=p_*q_+(-(r_*s_));highp float u_=o_.x;highp float v_=o_.y;uint w_=floatBitsToUint(t_)&2147483648u;highp float x_=uintBitsToFloat(floatBitsToUint(u_*r_+(-(v_*p_)))^w_);highp float y_=uintBitsToFloat(floatBitsToUint(u_*q_+(-(v_*s_)))^w_);bool z_=min(x_,y_)>=0.;bool A_;if(z_){A_=max(x_,y_)<=abs(t_);}else{A_=z_;}highp vec2 B_;highp float C_;uint D_;if(A_){highp vec2 E_=G*(y_/abs(t_));D_=floatBitsToUint(B.w);C_=dot(E_,E_);B_=E_;}else{D_=I;C_=H;B_=G;}m_=l.y;l_=k.y;r=D_;q=C_;p=B_;o=F+1;k_=false;break;}highp vec2 F_=(vec2(D.xz)-targetUV.xx)*f.x;highp vec2 G_=(vec2(D.yw)-targetUV.yy)*f.y;highp vec2 H_;if(F_.x>F_.y){H_=F_.yx;}else{H_=F_;}highp vec2 I_;if(G_.x>G_.y){I_=G_.yx;}else{I_=G_;}highp float J_=max(0.,max(H_.x,I_.x));bool K_=J_<min(H_.y,I_.y);bool L_;if(K_){L_=(J_*J_)<H;}else{L_=K_;}if(L_){m_=floatBitsToInt(B.w);l_=J_;r=I;q=H;p=G;o=F;k_=true;break;}m_=l.y;l_=k.y;r=I;q=H;p=G;o=F;k_=false;break;}while(false);highp vec2 M_=vec2(J,l_);ivec2 N_=ivec2(K,m_);if(E&&k_){ivec2 O_;highp vec2 P_;if(J<l_){P_=M_.yx;O_=N_.yx;}else{P_=M_;O_=N_;}int Q_=A+1;n[Q_]=O_.x;w=Q_;v=O_;u=P_;t=O_.y;s=x;}else{bool R_;int S_;int T_;if(E){T_=A;S_=K;R_=x;}else{bool U_;int V_;int W_;if(k_){W_=A;V_=m_;U_=x;}else{bool X_=A>0;int Y_;int Z_;if(X_){Z_=A-1;Y_=n[A];}else{Z_=A;Y_=y;}W_=Z_;V_=Y_;U_=X_?x:true;}T_=W_;S_=V_;R_=U_;}w=T_;v=N_;u=M_;t=S_;s=R_;}}col=vec4(float(g)*.03125,float(h)*.0625,float(j==4294967295u),1.);}