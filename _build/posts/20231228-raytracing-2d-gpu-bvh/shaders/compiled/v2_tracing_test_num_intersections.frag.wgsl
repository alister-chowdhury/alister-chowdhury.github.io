struct c{d:array<vec4f>,}struct e{d:vec2f,}@group(0)@binding(0)var<storage>f:c;var<private>h:vec2f;@group(0)@binding(1)var<uniform>i:e;var<private>j:vec4f;fn function(){var k:array<i32,9>;var l:i32;var m:vec2i;var n:vec2f;var o:f32;var p:vec2f;var q:i32;var s:i32;var t:bool;var u:vec2f;var v:vec2f;var A:bool;var B:f32;var C:bool;var D:vec2f;var E:u32;var F:f32;var G:bool;var H:vec2f;var I:f32;var J:f32;var K:vec2f;var L:i32;var M:i32;var N:f32;var O:vec2f;var P:i32;var Q:bool;var R:vec2f;var S:f32;var T:vec2f;var U:f32;var V:vec2f;var W:vec2f;var X:bool;var Y:f32;var Z:bool;var a_:vec2f;var b_:u32;var c_:f32;var d_:bool;var e_:vec2f;var f_:f32;var g_:f32;var h_:vec2f;var i_:i32;var j_:i32;var k_:f32;var l_:vec2f;var m_:i32;var n_:bool;var o_:f32;var p_:f32;var q_:i32;var r_:i32;var s_:i32;var t_:i32;var u_:bool;var v_:i32;var w_:i32;var x_:bool;var y_:f32;var z_:f32;var A_:vec2f;var B_:vec2i;var C_:i32;var D_:vec2i;var E_:vec2f;var F_:i32;var G_:bool;var H_:i32;var I_:i32;var J_:vec2i;var K_:vec2f;var L_:f32;var M_:vec2f;var N_:i32;var O_:i32;var P_:bool;var Q_:vec2f;var R_:f32;var S_:f32;var T_:vec2f;var U_:i32;var V_:vec2f;var W_:f32;var X_:f32;var Y_:vec2f;var Z_:i32;let _a=h;let ca=i.d;let da=(_a-ca);let ea=length(da);let fa=(da/vec2(ea));let ha=(vec2f(1.,1.)/fa);l=0;m=vec2i();n=vec2f();o=(ea*ea);p=(fa*ea);q=0;s=0;t=false;loop{let ia=l;let ja=m;let ka=n;let la=o;let ma=p;let na=q;let oa=s;let pa=t;H_=na;if!(pa){let qa=f.d[oa];let sa=f.d[(oa+1)];let ta=f.d[(oa+2)];switch bitcast<i32>(0u){default:{switch bitcast<i32>(0u){default:{let ua=ca.xx;let va=((vec2f(sa.x,sa.z)-ua)*ha.x);let Aa=ca.yy;let Ba=((vec2f(sa.y,sa.w)-Aa)*ha.y);u=va;R=ua;S=ha.x;T=Aa;U=ha.y;if(va.x>va.y){u=va.yx;}let Ca=u;v=Ba;if(Ba.x>Ba.y){v=Ba.yx;}let Da=v;let Ea=max(0.,max(Ca.x,Da.x));let Fa=(Ea<=min(Ca.y,Da.y));A=Fa;if Fa{A=((Ea*Ea)<la);}let Ga=A;if Ga{B=Ea;C=true;break;}B=ka.x;C=false;break;}}let Ha=B;let Ia=C;J=la;K=ma;L=na;o_=Ha;y_=Ha;if Ia{let Ja=bitcast<vec2u>(qa.xy);if(Ja.x!=0u){let Ka=(Ja.x>>bitcast<u32>(1));D=ma;E=Ja.y;F=la;U_=(na+bitcast<i32>(Ka));loop{let La=D;let Ma=E;let Na=F;S_=Na;T_=La;if(Ma<(Ja.y+Ka)){let Oa=f.d[Ma];let Pa=-(La);let Qa=(ca-Oa.xy);let Ra=fma(Pa.x,Oa.w,-((Pa.y*Oa.z)));let Sa=(bitcast<u32>(Ra)&2147483648u);let Ta=bitcast<f32>((bitcast<u32>(fma(Qa.x,Pa.y,-((Qa.y*Pa.x))))^Sa));let Ua=bitcast<f32>((bitcast<u32>(fma(Qa.x,Oa.w,-((Qa.y*Oa.z))))^Sa));let Va=(min(Ta,Ua)>0.);G=Va;if Va{G=(max(Ta,Ua)<abs(Ra));}let Wa=G;H=La;I=Na;if Wa{let Xa=(La*(Ua/abs(Ra)));H=Xa;I=dot(Xa,Xa);}let Ya=H;let Za=I;Q_=Ya;R_=Za;continue;}else{break;}continuing{let _b=Q_;D=_b;E=(Ma+bitcast<u32>(1));let cb=R_;F=cb;}}}else{M=bitcast<i32>(qa.y);N=la;O=ma;P=na;Q=true;break;}let db=S_;J=db;let eb=T_;K=eb;let fb=U_;L=fb;}let hb=J;let ib=K;let jb=L;M=ja.x;N=hb;O=ib;P=jb;Q=false;break;}}let kb=M;let lb=N;let mb=O;let nb=P;let ob=Q;switch bitcast<i32>(0u){default:{switch bitcast<i32>(0u){default:{let pb=R;let qb=S;let sb=((vec2f(ta.x,ta.z)-pb)*qb);let tb=T;let ub=U;let vb=((vec2f(ta.y,ta.w)-tb)*ub);V=sb;if(sb.x>sb.y){V=sb.yx;}let Ab=V;W=vb;if(vb.x>vb.y){W=vb.yx;}let Bb=W;let Cb=max(0.,max(Ab.x,Bb.x));let Db=(Cb<=min(Ab.y,Bb.y));X=Db;if Db{X=((Cb*Cb)<lb);}let Eb=X;if Eb{Y=Cb;Z=true;break;}Y=ka.y;Z=false;break;}}let Fb=Y;let Gb=Z;g_=lb;h_=mb;i_=nb;p_=Fb;z_=Fb;if Gb{let Hb=bitcast<vec2u>(qa.zw);if(Hb.x!=0u){let Ib=(Hb.x>>bitcast<u32>(1));a_=mb;b_=Hb.y;c_=lb;Z_=(nb+bitcast<i32>(Ib));loop{let Jb=a_;let Kb=b_;let Lb=c_;X_=Lb;Y_=Jb;if(Kb<(Hb.y+Ib)){let Mb=f.d[Kb];let Nb=-(Jb);let Ob=(ca-Mb.xy);let Pb=fma(Nb.x,Mb.w,-((Nb.y*Mb.z)));let Qb=(bitcast<u32>(Pb)&2147483648u);let Rb=bitcast<f32>((bitcast<u32>(fma(Ob.x,Nb.y,-((Ob.y*Nb.x))))^Qb));let Sb=bitcast<f32>((bitcast<u32>(fma(Ob.x,Mb.w,-((Ob.y*Mb.z))))^Qb));let Tb=(min(Rb,Sb)>0.);d_=Tb;if Tb{d_=(max(Rb,Sb)<abs(Pb));}let Ub=d_;e_=Jb;f_=Lb;if Ub{let Vb=(Jb*(Sb/abs(Pb)));e_=Vb;f_=dot(Vb,Vb);}let Wb=e_;let Xb=f_;V_=Wb;W_=Xb;continue;}else{break;}continuing{let Yb=V_;a_=Yb;b_=(Kb+bitcast<u32>(1));let Zb=W_;c_=Zb;}}}else{j_=bitcast<i32>(qa.w);k_=lb;l_=mb;m_=nb;n_=true;break;}let _c=X_;g_=_c;let ac=Y_;h_=ac;let bc=Z_;i_=bc;}let cc=g_;let dc=h_;let ec=i_;j_=ja.y;k_=cc;l_=dc;m_=ec;n_=false;break;}}let fc=j_;let gc=k_;let hc=l_;let ic=m_;let jc=n_;let kc=o_;let lc=p_;let mc=vec2f(kc,lc);let nc=vec2i(kb,fc);L_=gc;M_=hc;N_=ic;if(ob&&jc){let oc=y_;let pc=z_;A_=mc;B_=nc;if(oc<pc){A_=mc.yx;B_=nc.yx;}let qc=A_;let rc=B_;let sc=(ia+1);k[sc]=rc.x;C_=sc;D_=rc;E_=qc;F_=rc.y;G_=pa;}else{if ob{v_=ia;w_=kb;x_=pa;}else{if jc{s_=ia;t_=fc;u_=pa;}else{let tc=(ia>0);if tc{let uc=k[ia];q_=(ia - 1);r_=uc;}else{q_=ia;r_=oa;}let vc=q_;let wc=r_;s_=vc;t_=wc;u_=select(true,pa,tc);}let xc=s_;let yc=t_;let zc=u_;v_=xc;w_=yc;x_=zc;}let Ac=v_;let Bc=w_;let Cc=x_;C_=Ac;D_=nc;E_=mc;F_=Bc;G_=Cc;}let Dc=C_;let Ec=D_;let Fc=E_;let Gc=F_;let Hc=G_;I_=Dc;J_=Ec;K_=Fc;O_=Gc;P_=Hc;continue;}else{break;}continuing{let Ic=I_;l=Ic;let Jc=J_;m=Jc;let Kc=K_;n=Kc;let Lc=L_;o=Lc;let Mc=M_;p=Mc;let Nc=N_;q=Nc;let Oc=O_;s=Oc;let Pc=P_;t=Pc;}}let Qc=H_;let Rc=(f32(Qc)*.015625);j=vec4f(Rc,Rc,Rc,1.);return;}@fragment 
fn main(@location(0)Sc:vec2f)->@location(0)vec4f{h=Sc;function();let Tc=j;return Tc;}