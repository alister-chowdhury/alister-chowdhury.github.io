struct c{d:u32,}struct e{d:array<vec4f>,}struct f{d:vec2f,}struct h{d:vec2u,}var<private>i:vec3u;@group(0)@binding(2)var<uniform>j:c;@group(0)@binding(0)var<storage>k:e;@group(0)@binding(3)var<uniform>l:f;var<workgroup>m:array<vec3u,64>;@group(0)@binding(1)var<storage,read_write>n:h;fn function(){var o:f32;var p:u32;var q:u32;var s:u32;var t:f32;var u:u32;var v:u32;var A:f32;var B:i32;var C:f32;var D:f32;var E:f32;let F=i[0u];o=.00015625;p=0u;q=4294967295u;s=F;loop{let G=o;let H=p;let I=q;let J=s;let K=j.d;t=G;u=I;v=H;D=G;if(J<K){continue;}else{break;}continuing{let L=k.d[J];let M=l.d;let N=(L-M.xyxy);let O=N.xy;let P=dot(O,O);let Q=N.zw;let R=dot(Q,Q);let S=(P<G);let T=select(G,P,S);let U=(R<T);o=select(T,R,U);p=select(select(H,0u,S),1u,U);q=select(select(I,J,S),J,U);s=(J+64u);}}let V=t;let W=u;let X=v;m[F]=vec3u(W,X,bitcast<u32>(V));workgroupBarrier();let Y=D;A=Y;B=32;loop{let Z=A;let a_=B;if(a_>0){let b_=bitcast<u32>(a_);C=Z;if(F<b_){let c_=m[(F+b_)];let d_=bitcast<f32>(c_.z);let e_=(d_<Z);if e_{m[F]=c_;}C=select(Z,d_,e_);}workgroupBarrier();let f_=C;E=f_;continue;}else{break;}continuing{let g_=E;A=g_;B=(a_/2);}}if(F==0u){let h_=m[0];n.d=h_.xy;}return;}@compute @workgroup_size(64,1,1)fn main(@builtin(local_invocation_id)i_:vec3u){i=i_;function();}