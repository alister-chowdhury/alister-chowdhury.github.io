struct c{d:array<vec4f>,}struct e{@location(0)f:vec3f,@builtin(position)h:vec4f,}@group(0)@binding(0)var<storage>i:c;var<private>f:vec3f;var<private>j:u32;var<private>k:vec4f;fn l(){var m:u32;var n:vec2f;let o=j;m=u32((i32(o)/2));let p=j;if((i32(p)% 2)==0){{let q=m;let s=i.d[q];n=s.xy;}}else{{let t=m;let u=i.d[t];n=u.zw;}}f=vec3(0.);let v=n;let A=((v*2.)-vec2(1.));k=vec4f(A.x,A.y,0.,1.);return;}@vertex 
fn main(@builtin(vertex_index)B:u32)->e{j=B;l();let C=f;let D=k;return e(C,D);}