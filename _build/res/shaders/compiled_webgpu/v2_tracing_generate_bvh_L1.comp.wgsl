struct c{d:u32,e:u32,f:vec4f,h:u32,}struct i{d:array<vec4f>,}struct j{d:u32,}@group(0)@binding(1)var<storage,read_write>k:i;var<workgroup>l:array<c,4>;var<private>m:vec3u;@group(0)@binding(2)var<uniform>n:j;@group(0)@binding(0)var<storage>o:i;var<workgroup>p:array<u32,4>;fn function(){var q:u32;var s:u32;var t:vec4f;var u:u32;var v:u32;var A:bool;var B:u32;var C:u32;var D:vec4f;var E:u32;var F:u32;var G:u32;var H:u32;var I:u32;var J:u32;var K:vec4f;var L:u32;var M:u32;var N:u32;var O:u32;var P:bool;var Q:u32;var R:u32;var S:vec4f;var T:u32;var U:u32;var V:vec4f;var W:u32;var X:u32;var Y:u32;var Z:vec4f;var a_:u32;var b_:u32;var c_:u32;var d_:vec4f;var e_:u32;var f_:u32;var g_:u32;var h_:vec4f;var i_:u32;var j_:u32;var k_:u32;var l_:vec4f;var m_:u32;var n_:u32;var o_:u32;var p_:u32;let q_=m;let r_=q_.xy;let s_=(q_.x|(q_.y<<bitcast<u32>(16)));let t_=((s_|(s_<<bitcast<u32>(4)))&252645135u);let u_=((t_|(t_<<bitcast<u32>(2)))&858993459u);let v_=((u_|(u_<<bitcast<u32>(1)))&1431655765u);let w_=((v_|(v_>>bitcast<u32>(15)))&65535u);let x_=vec2f(r_);let y_=vec2f((r_+vec2u(1u,1u)));let z_=(vec4f(x_.x,x_.y,y_.x,y_.y)*vec4f(.5,.5,.5,.5));q=0u;s=0u;t=vec4f(1.,1.,-1.,-1.);u=0u;v=0u;loop{let A_=q;let B_=s;let C_=t;let D_=u;let E_=v;let F_=n.d;F=D_;I=D_;K=C_;L=D_;p_=B_;O=A_;if(E_<F_){let G_=o.d[E_];let H_=G_.xy;let I_=G_.zw;let J_=((H_+I_)*.5);let K_=all((J_>=z_.xy));A=K_;if K_{A=all((J_<z_.zw));}let L_=A;B=A_;C=B_;D=C_;E=D_;if L_{let M_=min(H_,I_);let N_=max(H_,I_);let O_=vec4f(M_.x,M_.y,N_.x,N_.y);let P_=min(C_.xy,O_.xy);let Q_=max(C_.zw,O_.zw);B=(E_+1u);C=select(B_,E_,(D_==0u));D=vec4f(P_.x,P_.y,Q_.x,Q_.y);E=(D_+bitcast<u32>(1));}let R_=B;let S_=C;let T_=D;let U_=E;j_=R_;k_=S_;l_=T_;m_=U_;continue;}else{break;}continuing{let V_=j_;q=V_;let W_=k_;s=W_;let X_=l_;t=X_;let Y_=m_;u=Y_;v=(E_+bitcast<u32>(1));}}let Z_=F;p[w_]=Z_;workgroupBarrier();G=9u;H=0u;loop{let _a=G;let ca=H;J=_a;n_=_a;if(ca<w_){continue;}else{break;}continuing{let da=p[ca];G=(_a+da);H=(ca+bitcast<u32>(1));}}let ea=I;let fa=J;let ha=K;let ia=L;l[((q_.y*2u)+q_.x)]=c((1u|(ea<<bitcast<u32>(1))),fa,ha,ia);workgroupBarrier();let ja=n_;M=ja;let ka=p_;N=ka;loop{let la=M;let ma=N;let na=O;if(ma<na){let oa=o.d[ma];let pa=oa.xy;let qa=oa.zw;let sa=((pa+qa)*.5);let ta=all((sa>=z_.xy));P=ta;if ta{P=all((sa<z_.zw));}let ua=P;Q=la;if ua{let va=(pa-qa);k.d[la]=vec4f(oa.x,oa.y,va.x,va.y);Q=(la+bitcast<u32>(1));}let Aa=Q;o_=Aa;continue;}else{break;}continuing{let Ba=o_;M=Ba;N=(ma+bitcast<u32>(1));}}if all((r_<vec2u(1u,1u))){let Ca=(r_*vec2u(2u,2u));let Da=(Ca+vec2u(1u,0u));let Ea=(Ca+vec2u(0u,1u));let Fa=(Ca+vec2u(1u,1u));let Ga=l[((Ca.y*2u)+Ca.x)];let Ha=l[((Da.y*2u)+Da.x)];let Ia=l[((Ea.y*2u)+Ea.x)];let Ja=l[((Fa.y*2u)+Fa.x)];let Ka=(9u*w_);let La=(((Ga.h+Ha.h)+Ia.h)+Ja.h);let Ma=((La<=16u)&&all(((vec4u(Ga.d,Ha.d,Ia.d,Ja.d)&vec4u(1u,1u,1u,1u))==vec4u(1u,1u,1u,1u))));R=u32();S=vec4f();if Ma{let Na=min(Ga.f.xy,Ha.f.xy);let Oa=max(Ga.f.zw,Ha.f.zw);let Pa=vec4f(Na.x,Na.y,Oa.x,Oa.y);let Qa=min(Ia.f.xy,Ja.f.xy);let Ra=max(Ia.f.zw,Ja.f.zw);let Sa=vec4f(Qa.x,Qa.y,Ra.x,Ra.y);let Ta=min(Pa.xy,Sa.xy);let Ua=max(Pa.zw,Sa.zw);R=(1u|(La<<bitcast<u32>(1)));S=vec4f(Ta.x,Ta.y,Ua.x,Ua.y);}let Va=R;let Wa=S;let Xa=select(u32(),0u,Ma);b_=select(u32(),1u,Ma);c_=Xa;d_=select(vec4f(),vec4f(1.,1.,-1.,-1.),vec4(Ma));e_=Xa;f_=Va;g_=select(u32(),Ga.e,Ma);h_=Wa;i_=select(u32(),La,Ma);if!(select(false,true,Ma)){let Ya=Ga.f.xy;let Za=Ha.f.xy;let _b=min(Ya,Za);let cb=Ga.f.zw;let db=Ha.f.zw;let eb=max(cb,db);let fb=vec4f(_b.x,_b.y,eb.x,eb.y);let hb=(fb.zw-fb.xy);let ib=Ia.f.xy;let jb=min(Ya,ib);let kb=Ia.f.zw;let lb=max(cb,kb);let mb=vec4f(jb.x,jb.y,lb.x,lb.y);let nb=(mb.zw-mb.xy);let ob=Ja.f.xy;let pb=min(ib,ob);let qb=Ja.f.zw;let sb=max(kb,qb);let tb=vec4f(pb.x,pb.y,sb.x,sb.y);let ub=(tb.zw-tb.xy);let vb=min(Za,ob);let Ab=max(db,qb);let Bb=vec4f(vb.x,vb.y,Ab.x,Ab.y);let Cb=(Bb.zw-Bb.xy);let Db=((max(0.,(hb.x*hb.y))+max(0.,(ub.x*ub.y)))>(max(0.,(nb.x*nb.y))+max(0.,(Cb.x*Cb.y))));let Eb=select(Ia.d,Ha.d,Db);let Fb=select(Ia.e,Ha.e,Db);let Gb=vec4(Db);let Hb=select(Ia.f,Ha.f,Gb);let Ib=select(Ia.h,Ha.h,Db);let Jb=select(Ha.d,Ia.d,Db);let Kb=select(Ha.e,Ia.e,Db);let Lb=select(Ha.f,Ia.f,Gb);let Mb=select(Ha.h,Ia.h,Db);let Nb=(Ka+3u);switch bitcast<i32>(0u){default:{k.d[Nb]=bitcast<vec4f>(vec4u(Ga.d,Ga.e,Jb,Kb));let Ob=(Ga.h==0u);k.d[(Ka+4u)]=select(Ga.f,vec4f(0.,0.,0.,0.),vec4(Ob));let Pb=(Mb==0u);k.d[(Ka+5u)]=select(Lb,vec4f(0.,0.,0.,0.),vec4(Pb));if Pb{T=Ga.d;U=Ga.e;V=Ga.f;W=Ga.h;break;}else{if Ob{T=Jb;U=Kb;V=Lb;W=Mb;break;}}let Qb=min(Ya,Lb.xy);let Rb=max(cb,Lb.zw);T=0u;U=Nb;V=vec4f(Qb.x,Qb.y,Rb.x,Rb.y);W=(Ga.h+Mb);break;}}let Sb=T;let Tb=U;let Ub=V;let Vb=W;let Wb=(Ka+6u);switch bitcast<i32>(0u){default:{k.d[Wb]=bitcast<vec4f>(vec4u(Eb,Fb,Ja.d,Ja.e));let Xb=(Ib==0u);k.d[(Ka+7u)]=select(Hb,vec4f(0.,0.,0.,0.),vec4(Xb));let Yb=(Ja.h==0u);k.d[(Ka+8u)]=select(Ja.f,vec4f(0.,0.,0.,0.),vec4(Yb));if Yb{X=Eb;Y=Fb;Z=Hb;a_=Ib;break;}else{if Xb{X=Ja.d;Y=Ja.e;Z=Ja.f;a_=Ja.h;break;}}let Zb=min(Hb.xy,ob);let _c=max(Hb.zw,qb);X=0u;Y=Wb;Z=vec4f(Zb.x,Zb.y,_c.x,_c.y);a_=(Ib+Ja.h);break;}}let ac=X;let bc=Y;let cc=Z;let dc=a_;b_=ac;c_=bc;d_=cc;e_=dc;f_=Sb;g_=Tb;h_=Ub;i_=Vb;}let ec=b_;let fc=c_;let gc=d_;let hc=e_;let ic=f_;let jc=g_;let kc=h_;let lc=i_;switch bitcast<i32>(0u){default:{k.d[Ka]=bitcast<vec4f>(vec4u(ic,jc,ec,fc));let mc=(lc==0u);k.d[(Ka+1u)]=select(kc,vec4f(0.,0.,0.,0.),vec4(mc));let nc=(hc==0u);k.d[(Ka+2u)]=select(gc,vec4f(0.,0.,0.,0.),vec4(nc));if nc{break;}else{if mc{break;}}break;}}}workgroupBarrier();return;}@compute @workgroup_size(2,2,1)fn main(@builtin(local_invocation_id)oc:vec3u){m=oc;function();}