struct c{d:array<vec4f>,}struct e{d:vec2f,}@group(0)@binding(0)var<storage>f:c;var<private>h:vec2f;@group(0)@binding(1)var<uniform>i:e;var<private>j:vec4f;fn function(){var k:array<i32,9>;var l:i32;var m:vec2i;var n:vec2f;var o:u32;var p:f32;var q:vec2f;var s:i32;var t:i32;var u:i32;var v:bool;var A:vec2f;var B:vec2f;var C:bool;var D:f32;var E:bool;var F:vec2f;var G:u32;var H:u32;var I:f32;var J:bool;var K:vec2f;var L:f32;var M:u32;var N:f32;var O:vec2f;var P:i32;var Q:i32;var R:u32;var S:f32;var T:vec2f;var U:i32;var V:bool;var W:vec2f;var X:f32;var Y:vec2f;var Z:f32;var a_:vec2f;var b_:vec2f;var c_:bool;var d_:f32;var e_:bool;var f_:vec2f;var g_:u32;var h_:u32;var i_:f32;var j_:bool;var k_:vec2f;var l_:f32;var m_:u32;var n_:f32;var o_:vec2f;var p_:i32;var q_:i32;var r_:u32;var s_:f32;var t_:vec2f;var u_:i32;var v_:bool;var w_:f32;var x_:f32;var y_:i32;var z_:i32;var A_:i32;var B_:i32;var C_:bool;var D_:i32;var E_:i32;var F_:bool;var G_:f32;var H_:f32;var I_:vec2f;var J_:vec2i;var K_:i32;var L_:vec2i;var M_:vec2f;var N_:i32;var O_:bool;var P_:u32;var Q_:i32;var R_:i32;var S_:i32;var T_:vec2i;var U_:vec2f;var V_:u32;var W_:f32;var X_:vec2f;var Y_:i32;var Z_:i32;var _a:i32;var ca:bool;var da:vec2f;var ea:u32;var fa:f32;var ha:u32;var ia:f32;var ja:vec2f;var ka:i32;var la:vec2f;var ma:u32;var na:f32;var oa:u32;var pa:f32;var qa:vec2f;var sa:i32;let ta=h;let ua=i.d;let va=(ta-ua);let Aa=length(va);let Ba=(va/vec2(Aa));let Ca=(vec2f(1.,1.)/Ba);l=0;m=vec2i();n=vec2f();o=4294967295u;p=(Aa*Aa);q=(Ba*Aa);s=0;t=0;u=0;v=false;loop{let Da=l;let Ea=m;let Fa=n;let Ga=o;let Ha=p;let Ia=q;let Ja=s;let Ka=t;let La=u;let Ma=v;P_=Ga;Q_=La;R_=Ja;if!(Ma){let Na=f.d[Ka];let Oa=f.d[(Ka+1)];let Pa=f.d[(Ka+2)];_a=(La+1);switch bitcast<i32>(0u){default:{switch bitcast<i32>(0u){default:{let Qa=ua.xx;let Ra=((vec2f(Oa.x,Oa.z)-Qa)*Ca.x);let Sa=ua.yy;let Ta=((vec2f(Oa.y,Oa.w)-Sa)*Ca.y);A=Ra;W=Qa;X=Ca.x;Y=Sa;Z=Ca.y;if(Ra.x>Ra.y){A=Ra.yx;}let Ua=A;B=Ta;if(Ta.x>Ta.y){B=Ta.yx;}let Va=B;let Wa=max(0.,max(Ua.x,Va.x));let Xa=(Wa<=min(Ua.y,Va.y));C=Xa;if Xa{C=((Wa*Wa)<Ha);}let Ya=C;if Ya{D=Wa;E=true;break;}D=Fa.x;E=false;break;}}let Za=D;let _b=E;M=Ga;N=Ha;O=Ia;P=Ja;w_=Za;G_=Za;if _b{let cb=bitcast<vec2u>(Na.xy);if(cb.x!=0u){let db=(cb.x>>bitcast<u32>(1));F=Ia;G=cb.y;H=Ga;I=Ha;ka=(Ja+bitcast<i32>(db));loop{let eb=F;let fb=G;let hb=H;let ib=I;ha=hb;ia=ib;ja=eb;if(fb<(cb.y+db)){let jb=f.d[fb];let kb=-(eb);let lb=(ua-jb.xy);let mb=fma(kb.x,jb.w,-((kb.y*jb.z)));let nb=(bitcast<u32>(mb)&2147483648u);let ob=bitcast<f32>((bitcast<u32>(fma(lb.x,kb.y,-((lb.y*kb.x))))^nb));let pb=bitcast<f32>((bitcast<u32>(fma(lb.x,jb.w,-((lb.y*jb.z))))^nb));let qb=(min(ob,pb)>=0.);J=qb;if qb{J=(max(ob,pb)<=abs(mb));}let sb=J;K=eb;L=ib;if sb{let tb=(eb*(pb/abs(mb)));K=tb;L=dot(tb,tb);}let ub=K;let vb=L;da=ub;ea=select(hb,fb,sb);fa=vb;continue;}else{break;}continuing{let Ab=da;F=Ab;G=(fb+bitcast<u32>(1));let Bb=ea;H=Bb;let Cb=fa;I=Cb;}}}else{Q=bitcast<i32>(Na.y);R=Ga;S=Ha;T=Ia;U=Ja;V=true;break;}let Db=ha;M=Db;let Eb=ia;N=Eb;let Fb=ja;O=Fb;let Gb=ka;P=Gb;}let Hb=M;let Ib=N;let Jb=O;let Kb=P;Q=Ea.x;R=Hb;S=Ib;T=Jb;U=Kb;V=false;break;}}let Lb=Q;let Mb=R;let Nb=S;let Ob=T;let Pb=U;let Qb=V;switch bitcast<i32>(0u){default:{switch bitcast<i32>(0u){default:{let Rb=W;let Sb=X;let Tb=((vec2f(Pa.x,Pa.z)-Rb)*Sb);let Ub=Y;let Vb=Z;let Wb=((vec2f(Pa.y,Pa.w)-Ub)*Vb);a_=Tb;if(Tb.x>Tb.y){a_=Tb.yx;}let Xb=a_;b_=Wb;if(Wb.x>Wb.y){b_=Wb.yx;}let Yb=b_;let Zb=max(0.,max(Xb.x,Yb.x));let _c=(Zb<=min(Xb.y,Yb.y));c_=_c;if _c{c_=((Zb*Zb)<Nb);}let ac=c_;if ac{d_=Zb;e_=true;break;}d_=Fa.y;e_=false;break;}}let bc=d_;let cc=e_;m_=Mb;n_=Nb;o_=Ob;p_=Pb;x_=bc;H_=bc;if cc{let dc=bitcast<vec2u>(Na.zw);if(dc.x!=0u){let ec=(dc.x>>bitcast<u32>(1));f_=Ob;g_=dc.y;h_=Mb;i_=Nb;sa=(Pb+bitcast<i32>(ec));loop{let fc=f_;let gc=g_;let hc=h_;let ic=i_;oa=hc;pa=ic;qa=fc;if(gc<(dc.y+ec)){let jc=f.d[gc];let kc=-(fc);let lc=(ua-jc.xy);let mc=fma(kc.x,jc.w,-((kc.y*jc.z)));let nc=(bitcast<u32>(mc)&2147483648u);let oc=bitcast<f32>((bitcast<u32>(fma(lc.x,kc.y,-((lc.y*kc.x))))^nc));let pc=bitcast<f32>((bitcast<u32>(fma(lc.x,jc.w,-((lc.y*jc.z))))^nc));let qc=(min(oc,pc)>=0.);j_=qc;if qc{j_=(max(oc,pc)<=abs(mc));}let rc=j_;k_=fc;l_=ic;if rc{let sc=(fc*(pc/abs(mc)));k_=sc;l_=dot(sc,sc);}let tc=k_;let uc=l_;la=tc;ma=select(hc,gc,rc);na=uc;continue;}else{break;}continuing{let vc=la;f_=vc;g_=(gc+bitcast<u32>(1));let wc=ma;h_=wc;let xc=na;i_=xc;}}}else{q_=bitcast<i32>(Na.w);r_=Mb;s_=Nb;t_=Ob;u_=Pb;v_=true;break;}let yc=oa;m_=yc;let zc=pa;n_=zc;let Ac=qa;o_=Ac;let Bc=sa;p_=Bc;}let Cc=m_;let Dc=n_;let Ec=o_;let Fc=p_;q_=Ea.y;r_=Cc;s_=Dc;t_=Ec;u_=Fc;v_=false;break;}}let Gc=q_;let Hc=r_;let Ic=s_;let Jc=t_;let Kc=u_;let Lc=v_;let Mc=w_;let Nc=x_;let Oc=vec2f(Mc,Nc);let Pc=vec2i(Lb,Gc);V_=Hc;W_=Ic;X_=Jc;Y_=Kc;if(Qb&&Lc){let Qc=G_;let Rc=H_;I_=Oc;J_=Pc;if(Qc<Rc){I_=Oc.yx;J_=Pc.yx;}let Sc=I_;let Tc=J_;let Uc=(Da+1);k[Uc]=Tc.x;K_=Uc;L_=Tc;M_=Sc;N_=Tc.y;O_=Ma;}else{if Qb{D_=Da;E_=Lb;F_=Ma;}else{if Lc{A_=Da;B_=Gc;C_=Ma;}else{let Vc=(Da>0);if Vc{let Wc=k[Da];y_=(Da - 1);z_=Wc;}else{y_=Da;z_=Ka;}let Xc=y_;let Yc=z_;A_=Xc;B_=Yc;C_=select(true,Ma,Vc);}let Zc=A_;let _d=B_;let ad=C_;D_=Zc;E_=_d;F_=ad;}let bd=D_;let cd=E_;let dd=F_;K_=bd;L_=Pc;M_=Oc;N_=cd;O_=dd;}let ed=K_;let fd=L_;let gd=M_;let hd=N_;let jd=O_;S_=ed;T_=fd;U_=gd;Z_=hd;ca=jd;continue;}else{break;}continuing{let kd=S_;l=kd;let ld=T_;m=ld;let md=U_;n=md;let nd=V_;o=nd;let od=W_;p=od;let pd=X_;q=pd;let qd=Y_;s=qd;let rd=Z_;t=rd;let sd=_a;u=sd;let td=ca;v=td;}}let ud=P_;let vd=Q_;let wd=R_;j=vec4f((f32(vd)*.03125),(f32(wd)*.015625),select(0.,1.,(ud==4294967295u)),1.);return;}@fragment 
fn main(@location(0)xd:vec2f)->@location(0)vec4f{h=xd;function();let yd=j;return yd;}