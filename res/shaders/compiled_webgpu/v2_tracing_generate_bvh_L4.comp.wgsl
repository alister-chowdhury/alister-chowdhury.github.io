struct c{d:u32,e:u32,f:vec4f,h:u32,}struct i{d:array<vec4f>,}struct j{d:u32,}@group(0)@binding(1)var<storage,read_write>k:i;var<workgroup>l:array<c,256>;var<workgroup>m:array<c,64>;var<private>n:vec3u;@group(0)@binding(2)var<uniform>o:j;@group(0)@binding(0)var<storage>p:i;var<workgroup>q:array<u32,256>;fn function(){var s:u32;var t:u32;var u:vec4f;var v:u32;var A:u32;var B:bool;var C:u32;var D:u32;var E:vec4f;var F:u32;var G:u32;var H:u32;var I:u32;var J:u32;var K:u32;var L:vec4f;var M:u32;var N:u32;var O:u32;var P:u32;var Q:bool;var R:u32;var S:u32;var T:vec4f;var U:u32;var V:u32;var W:vec4f;var X:u32;var Y:u32;var Z:u32;var a_:vec4f;var b_:u32;var c_:u32;var d_:u32;var e_:vec4f;var f_:u32;var g_:u32;var h_:u32;var i_:vec4f;var j_:u32;var k_:u32;var l_:u32;var m_:vec4f;var n_:u32;var o_:u32;var p_:u32;var q_:vec4f;var r_:u32;var s_:u32;var t_:u32;var u_:vec4f;var v_:u32;var w_:u32;var x_:vec4f;var y_:u32;var z_:u32;var A_:vec4f;var B_:u32;var C_:u32;var D_:u32;var E_:vec4f;var F_:u32;var G_:u32;var H_:u32;var I_:vec4f;var J_:u32;var K_:u32;var L_:u32;var M_:vec4f;var N_:u32;var O_:u32;var P_:u32;var Q_:vec4f;var R_:u32;var S_:u32;var T_:u32;var U_:vec4f;var V_:u32;var W_:u32;var X_:u32;var Y_:vec4f;var Z_:u32;var _a:u32;var ca:vec4f;var da:u32;var ea:u32;var fa:vec4f;var ha:u32;var ia:u32;var ja:u32;var ka:vec4f;var la:u32;var ma:u32;var na:u32;var oa:vec4f;var pa:u32;var qa:u32;var sa:u32;var ta:vec4f;var ua:u32;var va:u32;var Aa:u32;var Ba:vec4f;var Ca:u32;var Da:u32;var Ea:u32;var Fa:vec4f;var Ga:u32;var Ha:u32;var Ia:u32;var Ja:vec4f;var Ka:u32;var La:u32;var Ma:vec4f;var Na:u32;var Oa:u32;var Pa:vec4f;var Qa:u32;var Ra:u32;var Sa:u32;var Ta:vec4f;var Ua:u32;var Va:u32;var Wa:u32;var Xa:vec4f;var Ya:u32;var Za:u32;var _b:u32;var cb:vec4f;var db:u32;var eb:u32;var fb:u32;var hb:vec4f;var ib:u32;var jb:u32;var kb:u32;var lb:u32;let mb=n;let nb=mb.xy;let ob=(mb.x|(mb.y<<bitcast<u32>(16)));let pb=((ob|(ob<<bitcast<u32>(4)))&252645135u);let qb=((pb|(pb<<bitcast<u32>(2)))&858993459u);let sb=((qb|(qb<<bitcast<u32>(1)))&1431655765u);let tb=((sb|(sb>>bitcast<u32>(15)))&65535u);let ub=vec2f(nb);let vb=vec2f((nb+vec2u(1u,1u)));let Ab=(vec4f(ub.x,ub.y,vb.x,vb.y)*vec4f(.0625,.0625,.0625,.0625));s=0u;t=0u;u=vec4f(1.,1.,-1.,-1.);v=0u;A=0u;loop{let Bb=s;let Cb=t;let Db=u;let Eb=v;let Fb=A;let Gb=o.d;G=Eb;J=Eb;L=Db;M=Eb;lb=Cb;P=Bb;if(Fb<Gb){let Hb=p.d[Fb];let Ib=Hb.xy;let Jb=Hb.zw;let Kb=((Ib+Jb)*.5);let Lb=all((Kb>=Ab.xy));B=Lb;if Lb{B=all((Kb<Ab.zw));}let Mb=B;C=Bb;D=Cb;E=Db;F=Eb;if Mb{let Nb=min(Ib,Jb);let Ob=max(Ib,Jb);let Pb=vec4f(Nb.x,Nb.y,Ob.x,Ob.y);let Qb=min(Db.xy,Pb.xy);let Rb=max(Db.zw,Pb.zw);C=(Fb+1u);D=select(Cb,Fb,(Eb==0u));E=vec4f(Qb.x,Qb.y,Rb.x,Rb.y);F=(Eb+bitcast<u32>(1));}let Sb=C;let Tb=D;let Ub=E;let Vb=F;eb=Sb;fb=Tb;hb=Ub;ib=Vb;continue;}else{break;}continuing{let Wb=eb;s=Wb;let Xb=fb;t=Xb;let Yb=hb;u=Yb;let Zb=ib;v=Zb;A=(Fb+bitcast<u32>(1));}}let _c=G;q[tb]=_c;workgroupBarrier();H=765u;I=0u;loop{let ac=H;let bc=I;K=ac;jb=ac;if(bc<tb){continue;}else{break;}continuing{let cc=q[bc];H=(ac+cc);I=(bc+bitcast<u32>(1));}}let dc=J;let ec=K;let fc=L;let gc=M;l[((mb.y*16u)+mb.x)]=c((1u|(dc<<bitcast<u32>(1))),ec,fc,gc);workgroupBarrier();let hc=jb;N=hc;let ic=lb;O=ic;loop{let jc=N;let kc=O;let lc=P;if(kc<lc){let mc=p.d[kc];let nc=mc.xy;let oc=mc.zw;let pc=((nc+oc)*.5);let qc=all((pc>=Ab.xy));Q=qc;if qc{Q=all((pc<Ab.zw));}let rc=Q;R=jc;if rc{let sc=(nc-oc);k.d[jc]=vec4f(mc.x,mc.y,sc.x,sc.y);R=(jc+bitcast<u32>(1));}let tc=R;kb=tc;continue;}else{break;}continuing{let uc=kb;N=uc;O=(kc+bitcast<u32>(1));}}o_=u32();p_=u32();q_=vec4f();r_=u32();s_=u32();t_=u32();u_=vec4f();v_=u32();if all((nb<vec2u(8u,8u))){let vc=(nb*vec2u(2u,2u));let wc=(vc+vec2u(1u,0u));let xc=(vc+vec2u(0u,1u));let yc=(vc+vec2u(1u,1u));let zc=l[((vc.y*16u)+vc.x)];let Ac=l[((wc.y*16u)+wc.x)];let Bc=l[((xc.y*16u)+xc.x)];let Cc=l[((yc.y*16u)+yc.x)];let Dc=(9u*tb);let Ec=(189u+Dc);let Fc=(((zc.h+Ac.h)+Bc.h)+Cc.h);let Gc=((Fc<=16u)&&all(((vec4u(zc.d,Ac.d,Bc.d,Cc.d)&vec4u(1u,1u,1u,1u))==vec4u(1u,1u,1u,1u))));S=u32();T=vec4f();if Gc{let Hc=min(zc.f.xy,Ac.f.xy);let Ic=max(zc.f.zw,Ac.f.zw);let Jc=vec4f(Hc.x,Hc.y,Ic.x,Ic.y);let Kc=min(Bc.f.xy,Cc.f.xy);let Lc=max(Bc.f.zw,Cc.f.zw);let Mc=vec4f(Kc.x,Kc.y,Lc.x,Lc.y);let Nc=min(Jc.xy,Mc.xy);let Oc=max(Jc.zw,Mc.zw);S=(1u|(Fc<<bitcast<u32>(1)));T=vec4f(Nc.x,Nc.y,Oc.x,Oc.y);}let Pc=S;let Qc=T;let Rc=select(u32(),0u,Gc);c_=select(u32(),1u,Gc);d_=Rc;e_=select(vec4f(),vec4f(1.,1.,-1.,-1.),vec4(Gc));f_=Rc;g_=Pc;h_=select(u32(),zc.e,Gc);i_=Qc;j_=select(u32(),Fc,Gc);if!(select(false,true,Gc)){let Sc=zc.f.xy;let Tc=Ac.f.xy;let Uc=min(Sc,Tc);let Vc=zc.f.zw;let Wc=Ac.f.zw;let Xc=max(Vc,Wc);let Yc=vec4f(Uc.x,Uc.y,Xc.x,Xc.y);let Zc=(Yc.zw-Yc.xy);let _d=Bc.f.xy;let ad=min(Sc,_d);let bd=Bc.f.zw;let cd=max(Vc,bd);let dd=vec4f(ad.x,ad.y,cd.x,cd.y);let ed=(dd.zw-dd.xy);let fd=Cc.f.xy;let gd=min(_d,fd);let hd=Cc.f.zw;let jd=max(bd,hd);let kd=vec4f(gd.x,gd.y,jd.x,jd.y);let ld=(kd.zw-kd.xy);let md=min(Tc,fd);let nd=max(Wc,hd);let od=vec4f(md.x,md.y,nd.x,nd.y);let pd=(od.zw-od.xy);let qd=((max(0.,(Zc.x*Zc.y))+max(0.,(ld.x*ld.y)))>(max(0.,(ed.x*ed.y))+max(0.,(pd.x*pd.y))));let rd=select(Bc.d,Ac.d,qd);let sd=select(Bc.e,Ac.e,qd);let td=vec4(qd);let ud=select(Bc.f,Ac.f,td);let vd=select(Bc.h,Ac.h,qd);let wd=select(Ac.d,Bc.d,qd);let xd=select(Ac.e,Bc.e,qd);let yd=select(Ac.f,Bc.f,td);let zd=select(Ac.h,Bc.h,qd);let Ad=(Dc+192u);switch bitcast<i32>(0u){default:{k.d[Ad]=bitcast<vec4f>(vec4u(zc.d,zc.e,wd,xd));let Bd=(zc.h==0u);k.d[(Dc+193u)]=select(zc.f,vec4f(0.,0.,0.,0.),vec4(Bd));let Cd=(zd==0u);k.d[(Dc+194u)]=select(yd,vec4f(0.,0.,0.,0.),vec4(Cd));if Cd{U=zc.d;V=zc.e;W=zc.f;X=zc.h;break;}else{if Bd{U=wd;V=xd;W=yd;X=zd;break;}}let Dd=min(Sc,yd.xy);let Ed=max(Vc,yd.zw);U=0u;V=Ad;W=vec4f(Dd.x,Dd.y,Ed.x,Ed.y);X=(zc.h+zd);break;}}let Fd=U;let Gd=V;let Hd=W;let Id=X;let Jd=(Dc+195u);switch bitcast<i32>(0u){default:{k.d[Jd]=bitcast<vec4f>(vec4u(rd,sd,Cc.d,Cc.e));let Kd=(vd==0u);k.d[(Dc+196u)]=select(ud,vec4f(0.,0.,0.,0.),vec4(Kd));let Ld=(Cc.h==0u);k.d[(Dc+197u)]=select(Cc.f,vec4f(0.,0.,0.,0.),vec4(Ld));if Ld{Y=rd;Z=sd;a_=ud;b_=vd;break;}else{if Kd{Y=Cc.d;Z=Cc.e;a_=Cc.f;b_=Cc.h;break;}}let Md=min(ud.xy,fd);let Nd=max(ud.zw,hd);Y=0u;Z=Jd;a_=vec4f(Md.x,Md.y,Nd.x,Nd.y);b_=(vd+Cc.h);break;}}let Od=Y;let Pd=Z;let Qd=a_;let Rd=b_;c_=Od;d_=Pd;e_=Qd;f_=Rd;g_=Fd;h_=Gd;i_=Hd;j_=Id;}let Sd=c_;let Td=d_;let Ud=e_;let Vd=f_;let Wd=g_;let Xd=h_;let Yd=i_;let Zd=j_;switch bitcast<i32>(0u){default:{k.d[Ec]=bitcast<vec4f>(vec4u(Wd,Xd,Sd,Td));let _e=(Zd==0u);k.d[(Dc+190u)]=select(Yd,vec4f(0.,0.,0.,0.),vec4(_e));let ae=(Vd==0u);k.d[(Dc+191u)]=select(Ud,vec4f(0.,0.,0.,0.),vec4(ae));if ae{k_=Wd;l_=Xd;m_=Yd;n_=Zd;break;}else{if _e{k_=Sd;l_=Td;m_=Ud;n_=Vd;break;}}let be=min(Yd.xy,Ud.xy);let ce=max(Yd.zw,Ud.zw);k_=0u;l_=Ec;m_=vec4f(be.x,be.y,ce.x,ce.y);n_=(Zd+Vd);break;}}let de=k_;let ee=l_;let fe=m_;let ge=n_;m[((mb.y*8u)+mb.x)]=c(de,ee,fe,ge);o_=Sd;p_=Td;q_=Ud;r_=Vd;s_=Wd;t_=Xd;u_=Yd;v_=Zd;}let he=o_;let ie=p_;let je=q_;let ke=r_;let le=s_;let me=t_;let ne=u_;workgroupBarrier();let oe=v_;S_=he;T_=ie;U_=je;V_=ke;W_=le;X_=me;Y_=ne;Z_=oe;if all((nb<vec2u(4u,4u))){let pe=(nb*vec2u(2u,2u));let qe=(pe+vec2u(1u,0u));let re=(pe+vec2u(0u,1u));let se=(pe+vec2u(1u,1u));let te=m[((pe.y*8u)+pe.x)];let ue=m[((qe.y*8u)+qe.x)];let ve=m[((re.y*8u)+re.x)];let we=m[((se.y*8u)+se.x)];let xe=(9u*tb);let ye=(45u+xe);let ze=(((te.h+ue.h)+ve.h)+we.h);let Ae=((ze<=16u)&&all(((vec4u(te.d,ue.d,ve.d,we.d)&vec4u(1u,1u,1u,1u))==vec4u(1u,1u,1u,1u))));w_=le;x_=ne;if Ae{let Be=min(te.f.xy,ue.f.xy);let Ce=max(te.f.zw,ue.f.zw);let De=vec4f(Be.x,Be.y,Ce.x,Ce.y);let Ee=min(ve.f.xy,we.f.xy);let Fe=max(ve.f.zw,we.f.zw);let Ge=vec4f(Ee.x,Ee.y,Fe.x,Fe.y);let He=min(De.xy,Ge.xy);let Ie=max(De.zw,Ge.zw);w_=(1u|(ze<<bitcast<u32>(1)));x_=vec4f(He.x,He.y,Ie.x,Ie.y);}let Je=w_;let Ke=x_;G_=select(he,1u,Ae);H_=select(ie,0u,Ae);I_=select(je,vec4f(1.,1.,-1.,-1.),vec4(Ae));J_=select(ke,0u,Ae);K_=Je;L_=select(me,te.e,Ae);M_=Ke;N_=select(oe,ze,Ae);if!(select(false,true,Ae)){let Le=te.f.xy;let Me=ue.f.xy;let Ne=min(Le,Me);let Oe=te.f.zw;let Pe=ue.f.zw;let Qe=max(Oe,Pe);let Re=vec4f(Ne.x,Ne.y,Qe.x,Qe.y);let Se=(Re.zw-Re.xy);let Te=ve.f.xy;let Ue=min(Le,Te);let Ve=ve.f.zw;let We=max(Oe,Ve);let Xe=vec4f(Ue.x,Ue.y,We.x,We.y);let Ye=(Xe.zw-Xe.xy);let Ze=we.f.xy;let _f=min(Te,Ze);let af=we.f.zw;let bf=max(Ve,af);let cf=vec4f(_f.x,_f.y,bf.x,bf.y);let df=(cf.zw-cf.xy);let ef=min(Me,Ze);let ff=max(Pe,af);let gf=vec4f(ef.x,ef.y,ff.x,ff.y);let hf=(gf.zw-gf.xy);let jf=((max(0.,(Se.x*Se.y))+max(0.,(df.x*df.y)))>(max(0.,(Ye.x*Ye.y))+max(0.,(hf.x*hf.y))));let kf=select(ve.d,ue.d,jf);let lf=select(ve.e,ue.e,jf);let mf=vec4(jf);let nf=select(ve.f,ue.f,mf);let pf=select(ve.h,ue.h,jf);let qf=select(ue.d,ve.d,jf);let rf=select(ue.e,ve.e,jf);let sf=select(ue.f,ve.f,mf);let tf=select(ue.h,ve.h,jf);let uf=(xe+48u);switch bitcast<i32>(0u){default:{k.d[uf]=bitcast<vec4f>(vec4u(te.d,te.e,qf,rf));let vf=(te.h==0u);k.d[(xe+49u)]=select(te.f,vec4f(0.,0.,0.,0.),vec4(vf));let wf=(tf==0u);k.d[(xe+50u)]=select(sf,vec4f(0.,0.,0.,0.),vec4(wf));if wf{y_=te.d;z_=te.e;A_=te.f;B_=te.h;break;}else{if vf{y_=qf;z_=rf;A_=sf;B_=tf;break;}}let xf=min(Le,sf.xy);let yf=max(Oe,sf.zw);y_=0u;z_=uf;A_=vec4f(xf.x,xf.y,yf.x,yf.y);B_=(te.h+tf);break;}}let zf=y_;let Af=z_;let Bf=A_;let Cf=B_;let Df=(xe+51u);switch bitcast<i32>(0u){default:{k.d[Df]=bitcast<vec4f>(vec4u(kf,lf,we.d,we.e));let Ef=(pf==0u);k.d[(xe+52u)]=select(nf,vec4f(0.,0.,0.,0.),vec4(Ef));let Ff=(we.h==0u);k.d[(xe+53u)]=select(we.f,vec4f(0.,0.,0.,0.),vec4(Ff));if Ff{C_=kf;D_=lf;E_=nf;F_=pf;break;}else{if Ef{C_=we.d;D_=we.e;E_=we.f;F_=we.h;break;}}let Gf=min(nf.xy,Ze);let Hf=max(nf.zw,af);C_=0u;D_=Df;E_=vec4f(Gf.x,Gf.y,Hf.x,Hf.y);F_=(pf+we.h);break;}}let If=C_;let Jf=D_;let Kf=E_;let Lf=F_;G_=If;H_=Jf;I_=Kf;J_=Lf;K_=zf;L_=Af;M_=Bf;N_=Cf;}let Mf=G_;let Nf=H_;let Of=I_;let Pf=J_;let Qf=K_;let Rf=L_;let Sf=M_;let Tf=N_;switch bitcast<i32>(0u){default:{k.d[ye]=bitcast<vec4f>(vec4u(Qf,Rf,Mf,Nf));let Uf=(Tf==0u);k.d[(xe+46u)]=select(Sf,vec4f(0.,0.,0.,0.),vec4(Uf));let Vf=(Pf==0u);k.d[(xe+47u)]=select(Of,vec4f(0.,0.,0.,0.),vec4(Vf));if Vf{O_=Qf;P_=Rf;Q_=Sf;R_=Tf;break;}else{if Uf{O_=Mf;P_=Nf;Q_=Of;R_=Pf;break;}}let Wf=min(Sf.xy,Of.xy);let Xf=max(Sf.zw,Of.zw);O_=0u;P_=ye;Q_=vec4f(Wf.x,Wf.y,Xf.x,Xf.y);R_=(Tf+Pf);break;}}let Yf=O_;let Zf=P_;let _g=Q_;let cg=R_;l[((mb.y*4u)+mb.x)]=c(Yf,Zf,_g,cg);S_=Mf;T_=Nf;U_=Of;V_=Pf;W_=Qf;X_=Rf;Y_=Sf;Z_=Tf;}let dg=S_;let eg=T_;let fg=U_;let hg=V_;let ig=W_;let jg=X_;let kg=Y_;workgroupBarrier();let lg=Z_;Da=dg;Ea=eg;Fa=fg;Ga=hg;Ha=ig;Ia=jg;Ja=kg;Ka=lg;if all((nb<vec2u(2u,2u))){let mg=(nb*vec2u(2u,2u));let ng=(mg+vec2u(1u,0u));let og=(mg+vec2u(0u,1u));let pg=(mg+vec2u(1u,1u));let qg=l[((mg.y*4u)+mg.x)];let sg=l[((ng.y*4u)+ng.x)];let tg=l[((og.y*4u)+og.x)];let ug=l[((pg.y*4u)+pg.x)];let vg=(9u*tb);let Ag=(9u+vg);let Bg=(((qg.h+sg.h)+tg.h)+ug.h);let Cg=((Bg<=16u)&&all(((vec4u(qg.d,sg.d,tg.d,ug.d)&vec4u(1u,1u,1u,1u))==vec4u(1u,1u,1u,1u))));_a=ig;ca=kg;if Cg{let Dg=min(qg.f.xy,sg.f.xy);let Eg=max(qg.f.zw,sg.f.zw);let Fg=vec4f(Dg.x,Dg.y,Eg.x,Eg.y);let Gg=min(tg.f.xy,ug.f.xy);let Hg=max(tg.f.zw,ug.f.zw);let Ig=vec4f(Gg.x,Gg.y,Hg.x,Hg.y);let Jg=min(Fg.xy,Ig.xy);let Kg=max(Fg.zw,Ig.zw);_a=(1u|(Bg<<bitcast<u32>(1)));ca=vec4f(Jg.x,Jg.y,Kg.x,Kg.y);}let Lg=_a;let Mg=ca;ma=select(dg,1u,Cg);na=select(eg,0u,Cg);oa=select(fg,vec4f(1.,1.,-1.,-1.),vec4(Cg));pa=select(hg,0u,Cg);qa=Lg;sa=select(jg,qg.e,Cg);ta=Mg;ua=select(lg,Bg,Cg);if!(select(false,true,Cg)){let Ng=qg.f.xy;let Og=sg.f.xy;let Pg=min(Ng,Og);let Qg=qg.f.zw;let Rg=sg.f.zw;let Sg=max(Qg,Rg);let Tg=vec4f(Pg.x,Pg.y,Sg.x,Sg.y);let Ug=(Tg.zw-Tg.xy);let Vg=tg.f.xy;let Wg=min(Ng,Vg);let Xg=tg.f.zw;let Yg=max(Qg,Xg);let Zg=vec4f(Wg.x,Wg.y,Yg.x,Yg.y);let _h=(Zg.zw-Zg.xy);let ah=ug.f.xy;let bh=min(Vg,ah);let ch=ug.f.zw;let dh=max(Xg,ch);let eh=vec4f(bh.x,bh.y,dh.x,dh.y);let fh=(eh.zw-eh.xy);let gh=min(Og,ah);let hh=max(Rg,ch);let ih=vec4f(gh.x,gh.y,hh.x,hh.y);let jh=(ih.zw-ih.xy);let kh=((max(0.,(Ug.x*Ug.y))+max(0.,(fh.x*fh.y)))>(max(0.,(_h.x*_h.y))+max(0.,(jh.x*jh.y))));let lh=select(tg.d,sg.d,kh);let mh=select(tg.e,sg.e,kh);let nh=vec4(kh);let oh=select(tg.f,sg.f,nh);let ph=select(tg.h,sg.h,kh);let qh=select(sg.d,tg.d,kh);let rh=select(sg.e,tg.e,kh);let sh=select(sg.f,tg.f,nh);let th=select(sg.h,tg.h,kh);let uh=(vg+12u);switch bitcast<i32>(0u){default:{k.d[uh]=bitcast<vec4f>(vec4u(qg.d,qg.e,qh,rh));let vh=(qg.h==0u);k.d[(vg+13u)]=select(qg.f,vec4f(0.,0.,0.,0.),vec4(vh));let wh=(th==0u);k.d[(vg+14u)]=select(sh,vec4f(0.,0.,0.,0.),vec4(wh));if wh{da=qg.d;ea=qg.e;fa=qg.f;ha=qg.h;break;}else{if vh{da=qh;ea=rh;fa=sh;ha=th;break;}}let xh=min(Ng,sh.xy);let yh=max(Qg,sh.zw);da=0u;ea=uh;fa=vec4f(xh.x,xh.y,yh.x,yh.y);ha=(qg.h+th);break;}}let zh=da;let Ah=ea;let Bh=fa;let Ch=ha;let Dh=(vg+15u);switch bitcast<i32>(0u){default:{k.d[Dh]=bitcast<vec4f>(vec4u(lh,mh,ug.d,ug.e));let Eh=(ph==0u);k.d[(vg+16u)]=select(oh,vec4f(0.,0.,0.,0.),vec4(Eh));let Fh=(ug.h==0u);k.d[(vg+17u)]=select(ug.f,vec4f(0.,0.,0.,0.),vec4(Fh));if Fh{ia=lh;ja=mh;ka=oh;la=ph;break;}else{if Eh{ia=ug.d;ja=ug.e;ka=ug.f;la=ug.h;break;}}let Gh=min(oh.xy,ah);let Hh=max(oh.zw,ch);ia=0u;ja=Dh;ka=vec4f(Gh.x,Gh.y,Hh.x,Hh.y);la=(ph+ug.h);break;}}let Ih=ia;let Jh=ja;let Kh=ka;let Lh=la;ma=Ih;na=Jh;oa=Kh;pa=Lh;qa=zh;sa=Ah;ta=Bh;ua=Ch;}let Mh=ma;let Nh=na;let Oh=oa;let Ph=pa;let Qh=qa;let Rh=sa;let Sh=ta;let Th=ua;switch bitcast<i32>(0u){default:{k.d[Ag]=bitcast<vec4f>(vec4u(Qh,Rh,Mh,Nh));let Uh=(Th==0u);k.d[(vg+10u)]=select(Sh,vec4f(0.,0.,0.,0.),vec4(Uh));let Vh=(Ph==0u);k.d[(vg+11u)]=select(Oh,vec4f(0.,0.,0.,0.),vec4(Vh));if Vh{va=Qh;Aa=Rh;Ba=Sh;Ca=Th;break;}else{if Uh{va=Mh;Aa=Nh;Ba=Oh;Ca=Ph;break;}}let Wh=min(Sh.xy,Oh.xy);let Xh=max(Sh.zw,Oh.zw);va=0u;Aa=Ag;Ba=vec4f(Wh.x,Wh.y,Xh.x,Xh.y);Ca=(Th+Ph);break;}}let Yh=va;let Zh=Aa;let _i=Ba;let ai=Ca;m[((mb.y*2u)+mb.x)]=c(Yh,Zh,_i,ai);Da=Mh;Ea=Nh;Fa=Oh;Ga=Ph;Ha=Qh;Ia=Rh;Ja=Sh;Ka=Th;}let bi=Da;let ci=Ea;let di=Fa;let ei=Ga;let fi=Ha;let gi=Ia;let hi=Ja;workgroupBarrier();let ii=Ka;if all((nb<vec2u(1u,1u))){let ji=(nb*vec2u(2u,2u));let ki=(ji+vec2u(1u,0u));let li=(ji+vec2u(0u,1u));let mi=(ji+vec2u(1u,1u));let ni=m[((ji.y*2u)+ji.x)];let oi=m[((ki.y*2u)+ki.x)];let pi=m[((li.y*2u)+li.x)];let qi=m[((mi.y*2u)+mi.x)];let ri=(9u*tb);let si=(((ni.h+oi.h)+pi.h)+qi.h);let ti=((si<=16u)&&all(((vec4u(ni.d,oi.d,pi.d,qi.d)&vec4u(1u,1u,1u,1u))==vec4u(1u,1u,1u,1u))));La=fi;Ma=hi;if ti{let ui=min(ni.f.xy,oi.f.xy);let vi=max(ni.f.zw,oi.f.zw);let wi=vec4f(ui.x,ui.y,vi.x,vi.y);let xi=min(pi.f.xy,qi.f.xy);let yi=max(pi.f.zw,qi.f.zw);let zi=vec4f(xi.x,xi.y,yi.x,yi.y);let Ai=min(wi.xy,zi.xy);let Bi=max(wi.zw,zi.zw);La=(1u|(si<<bitcast<u32>(1)));Ma=vec4f(Ai.x,Ai.y,Bi.x,Bi.y);}let Ci=La;let Di=Ma;Va=select(bi,1u,ti);Wa=select(ci,0u,ti);Xa=select(di,vec4f(1.,1.,-1.,-1.),vec4(ti));Ya=select(ei,0u,ti);Za=Ci;_b=select(gi,ni.e,ti);cb=Di;db=select(ii,si,ti);if!(select(false,true,ti)){let Ei=ni.f.xy;let Fi=oi.f.xy;let Gi=min(Ei,Fi);let Hi=ni.f.zw;let Ii=oi.f.zw;let Ji=max(Hi,Ii);let Ki=vec4f(Gi.x,Gi.y,Ji.x,Ji.y);let Li=(Ki.zw-Ki.xy);let Mi=pi.f.xy;let Ni=min(Ei,Mi);let Oi=pi.f.zw;let Pi=max(Hi,Oi);let Qi=vec4f(Ni.x,Ni.y,Pi.x,Pi.y);let Ri=(Qi.zw-Qi.xy);let Si=qi.f.xy;let Ti=min(Mi,Si);let Ui=qi.f.zw;let Vi=max(Oi,Ui);let Wi=vec4f(Ti.x,Ti.y,Vi.x,Vi.y);let Xi=(Wi.zw-Wi.xy);let Yi=min(Fi,Si);let Zi=max(Ii,Ui);let _j=vec4f(Yi.x,Yi.y,Zi.x,Zi.y);let aj=(_j.zw-_j.xy);let bj=((max(0.,(Li.x*Li.y))+max(0.,(Xi.x*Xi.y)))>(max(0.,(Ri.x*Ri.y))+max(0.,(aj.x*aj.y))));let cj=select(pi.d,oi.d,bj);let dj=select(pi.e,oi.e,bj);let ej=vec4(bj);let fj=select(pi.f,oi.f,ej);let gj=select(pi.h,oi.h,bj);let hj=select(oi.d,pi.d,bj);let ij=select(oi.e,pi.e,bj);let jj=select(oi.f,pi.f,ej);let kj=select(oi.h,pi.h,bj);let lj=(ri+3u);switch bitcast<i32>(0u){default:{k.d[lj]=bitcast<vec4f>(vec4u(ni.d,ni.e,hj,ij));let mj=(ni.h==0u);k.d[(ri+4u)]=select(ni.f,vec4f(0.,0.,0.,0.),vec4(mj));let nj=(kj==0u);k.d[(ri+5u)]=select(jj,vec4f(0.,0.,0.,0.),vec4(nj));if nj{Na=ni.d;Oa=ni.e;Pa=ni.f;Qa=ni.h;break;}else{if mj{Na=hj;Oa=ij;Pa=jj;Qa=kj;break;}}let oj=min(Ei,jj.xy);let pj=max(Hi,jj.zw);Na=0u;Oa=lj;Pa=vec4f(oj.x,oj.y,pj.x,pj.y);Qa=(ni.h+kj);break;}}let qj=Na;let rj=Oa;let sj=Pa;let tj=Qa;let uj=(ri+6u);switch bitcast<i32>(0u){default:{k.d[uj]=bitcast<vec4f>(vec4u(cj,dj,qi.d,qi.e));let vj=(gj==0u);k.d[(ri+7u)]=select(fj,vec4f(0.,0.,0.,0.),vec4(vj));let wj=(qi.h==0u);k.d[(ri+8u)]=select(qi.f,vec4f(0.,0.,0.,0.),vec4(wj));if wj{Ra=cj;Sa=dj;Ta=fj;Ua=gj;break;}else{if vj{Ra=qi.d;Sa=qi.e;Ta=qi.f;Ua=qi.h;break;}}let xj=min(fj.xy,Si);let yj=max(fj.zw,Ui);Ra=0u;Sa=uj;Ta=vec4f(xj.x,xj.y,yj.x,yj.y);Ua=(gj+qi.h);break;}}let zj=Ra;let Aj=Sa;let Bj=Ta;let Cj=Ua;Va=zj;Wa=Aj;Xa=Bj;Ya=Cj;Za=qj;_b=rj;cb=sj;db=tj;}let Dj=Va;let Ej=Wa;let Fj=Xa;let Gj=Ya;let Hj=Za;let Ij=_b;let Jj=cb;let Kj=db;switch bitcast<i32>(0u){default:{k.d[ri]=bitcast<vec4f>(vec4u(Hj,Ij,Dj,Ej));let Lj=(Kj==0u);k.d[(ri+1u)]=select(Jj,vec4f(0.,0.,0.,0.),vec4(Lj));let Mj=(Gj==0u);k.d[(ri+2u)]=select(Fj,vec4f(0.,0.,0.,0.),vec4(Mj));if Mj{break;}else{if Lj{break;}}break;}}}return;}@compute @workgroup_size(16,16,1)fn main(@builtin(local_invocation_id)Nj:vec3u){n=Nj;function();}