struct c{d:array<vec4f>,}struct e{d:vec2f,}@group(0)@binding(0)var<storage>f:c;var<private>h:vec2f;@group(0)@binding(1)var<uniform>i:e;var<private>j:vec4f;fn function(){var k:array<i32,9>;var l:i32;var m:vec2i;var n:vec2f;var o:u32;var p:f32;var q:vec2f;var s:i32;var t:bool;var u:vec2f;var v:vec2f;var A:bool;var B:f32;var C:bool;var D:u32;var E:bool;var F:u32;var G:f32;var H:vec2f;var I:u32;var J:f32;var K:vec2f;var L:i32;var M:u32;var N:f32;var O:vec2f;var P:bool;var Q:vec2f;var R:f32;var S:vec2f;var T:f32;var U:vec2f;var V:vec2f;var W:bool;var X:f32;var Y:bool;var Z:u32;var a_:bool;var b_:u32;var c_:f32;var d_:vec2f;var e_:u32;var f_:f32;var g_:vec2f;var h_:i32;var i_:u32;var j_:f32;var k_:vec2f;var l_:bool;var m_:f32;var n_:f32;var o_:i32;var p_:i32;var q_:i32;var r_:i32;var s_:bool;var t_:i32;var u_:i32;var v_:bool;var w_:f32;var x_:f32;var y_:vec2f;var z_:vec2i;var A_:i32;var B_:vec2i;var C_:vec2f;var D_:i32;var E_:bool;var F_:u32;var G_:i32;var H_:vec2i;var I_:vec2f;var J_:u32;var K_:f32;var L_:vec2f;var M_:i32;var N_:bool;var O_:u32;var P_:f32;var Q_:vec2f;var R_:u32;var S_:f32;var T_:vec2f;let U_=h;let V_=i.d;let W_=(U_-V_);let X_=length(W_);let Y_=(W_/vec2(X_));let Z_=(vec2f(1.,1.)/Y_);l=0;m=vec2i();n=vec2f();o=4294967295u;p=(X_*X_);q=(Y_*X_);s=0;t=false;loop{let _a=l;let ca=m;let da=n;let ea=o;let fa=p;let ha=q;let ia=s;let ja=t;F_=ea;if!(ja){let ka=f.d[ia];let la=f.d[(ia+1)];let ma=f.d[(ia+2)];switch bitcast<i32>(0u){default:{switch bitcast<i32>(0u){default:{let na=V_.xx;let oa=((vec2f(la.x,la.z)-na)*Z_.x);let pa=V_.yy;let qa=((vec2f(la.y,la.w)-pa)*Z_.y);u=oa;Q=na;R=Z_.x;S=pa;T=Z_.y;if(oa.x>oa.y){u=oa.yx;}let sa=u;v=qa;if(qa.x>qa.y){v=qa.yx;}let ta=v;let ua=max(0.,max(sa.x,ta.x));let va=(ua<=min(sa.y,ta.y));A=va;if va{A=((ua*ua)<fa);}let Aa=A;if Aa{B=ua;C=true;break;}B=da.x;C=false;break;}}let Ba=B;let Ca=C;I=ea;J=fa;K=ha;m_=Ba;w_=Ba;if Ca{let Da=bitcast<vec2u>(ka.xy);if(Da.x!=0u){D=Da.y;loop{let Ea=D;F=ea;G=fa;H=ha;if(Ea<(Da.y+(Da.x>>bitcast<u32>(1)))){let Fa=f.d[Ea];let Ga=-(ha);let Ha=(V_-Fa.xy);let Ia=fma(Ga.x,Fa.w,-((Ga.y*Fa.z)));let Ja=(bitcast<u32>(Ia)&2147483648u);let Ka=bitcast<f32>((bitcast<u32>(fma(Ha.x,Ga.y,-((Ha.y*Ga.x))))^Ja));let La=bitcast<f32>((bitcast<u32>(fma(Ha.x,Fa.w,-((Ha.y*Fa.z))))^Ja));let Ma=(min(Ka,La)>=0.);E=Ma;if Ma{E=(max(Ka,La)<=abs(Ia));}let Na=E;if Na{let Oa=(ha*(La/abs(Ia)));F=Ea;G=dot(Oa,Oa);H=Oa;break;}continue;}else{break;}continuing{D=(Ea+bitcast<u32>(1));}}let Pa=F;let Qa=G;let Ra=H;O_=Pa;P_=Qa;Q_=Ra;}else{L=bitcast<i32>(ka.y);M=ea;N=fa;O=ha;P=true;break;}let Sa=O_;I=Sa;let Ta=P_;J=Ta;let Ua=Q_;K=Ua;}let Va=I;let Wa=J;let Xa=K;L=ca.x;M=Va;N=Wa;O=Xa;P=false;break;}}let Ya=L;let Za=M;let _b=N;let cb=O;let db=P;switch bitcast<i32>(0u){default:{switch bitcast<i32>(0u){default:{let eb=Q;let fb=R;let hb=((vec2f(ma.x,ma.z)-eb)*fb);let ib=S;let jb=T;let kb=((vec2f(ma.y,ma.w)-ib)*jb);U=hb;if(hb.x>hb.y){U=hb.yx;}let lb=U;V=kb;if(kb.x>kb.y){V=kb.yx;}let mb=V;let nb=max(0.,max(lb.x,mb.x));let ob=(nb<=min(lb.y,mb.y));W=ob;if ob{W=((nb*nb)<_b);}let pb=W;if pb{X=nb;Y=true;break;}X=da.y;Y=false;break;}}let qb=X;let sb=Y;e_=Za;f_=_b;g_=cb;n_=qb;x_=qb;if sb{let tb=bitcast<vec2u>(ka.zw);if(tb.x!=0u){Z=tb.y;loop{let ub=Z;b_=Za;c_=_b;d_=cb;if(ub<(tb.y+(tb.x>>bitcast<u32>(1)))){let vb=f.d[ub];let Ab=-(cb);let Bb=(V_-vb.xy);let Cb=fma(Ab.x,vb.w,-((Ab.y*vb.z)));let Db=(bitcast<u32>(Cb)&2147483648u);let Eb=bitcast<f32>((bitcast<u32>(fma(Bb.x,Ab.y,-((Bb.y*Ab.x))))^Db));let Fb=bitcast<f32>((bitcast<u32>(fma(Bb.x,vb.w,-((Bb.y*vb.z))))^Db));let Gb=(min(Eb,Fb)>=0.);a_=Gb;if Gb{a_=(max(Eb,Fb)<=abs(Cb));}let Hb=a_;if Hb{let Ib=(cb*(Fb/abs(Cb)));b_=ub;c_=dot(Ib,Ib);d_=Ib;break;}continue;}else{break;}continuing{Z=(ub+bitcast<u32>(1));}}let Jb=b_;let Kb=c_;let Lb=d_;R_=Jb;S_=Kb;T_=Lb;}else{h_=bitcast<i32>(ka.w);i_=Za;j_=_b;k_=cb;l_=true;break;}let Mb=R_;e_=Mb;let Nb=S_;f_=Nb;let Ob=T_;g_=Ob;}let Pb=e_;let Qb=f_;let Rb=g_;h_=ca.y;i_=Pb;j_=Qb;k_=Rb;l_=false;break;}}let Sb=h_;let Tb=i_;let Ub=j_;let Vb=k_;let Wb=l_;let Xb=m_;let Yb=n_;let Zb=vec2f(Xb,Yb);let _c=vec2i(Ya,Sb);J_=Tb;K_=Ub;L_=Vb;if(Tb!=4294967295u){F_=Tb;break;}if(db&&Wb){let ac=w_;let bc=x_;y_=Zb;z_=_c;if(ac<bc){y_=Zb.yx;z_=_c.yx;}let cc=y_;let dc=z_;let ec=(_a+1);k[ec]=dc.x;A_=ec;B_=dc;C_=cc;D_=dc.y;E_=ja;}else{if db{t_=_a;u_=Ya;v_=ja;}else{if Wb{q_=_a;r_=Sb;s_=ja;}else{let fc=(_a>0);if fc{let gc=k[_a];o_=(_a - 1);p_=gc;}else{o_=_a;p_=ia;}let hc=o_;let ic=p_;q_=hc;r_=ic;s_=select(true,ja,fc);}let jc=q_;let kc=r_;let lc=s_;t_=jc;u_=kc;v_=lc;}let mc=t_;let nc=u_;let oc=v_;A_=mc;B_=_c;C_=Zb;D_=nc;E_=oc;}let pc=A_;let qc=B_;let rc=C_;let sc=D_;let tc=E_;G_=pc;H_=qc;I_=rc;M_=sc;N_=tc;continue;}else{break;}continuing{let uc=G_;l=uc;let vc=H_;m=vc;let wc=I_;n=wc;let xc=J_;o=xc;let yc=K_;p=yc;let zc=L_;q=zc;let Ac=M_;s=Ac;let Bc=N_;t=Bc;}}let Cc=F_;let Dc=((normalize(vec3f(V_.x,V_.y,length(V_)))*select(0.,1.,(Cc==4294967295u)))*pow((X_+1.),-5.));j=vec4f(Dc.x,Dc.y,Dc.z,1.);return;}@fragment 
fn main(@location(0)Ec:vec2f)->@location(0)vec4f{h=Ec;function();let Fc=j;return Fc;}