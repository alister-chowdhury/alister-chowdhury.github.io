struct c{@location(0)d:vec2f,@builtin(position)e:vec4f,}var<private>d:vec2f;var<private>f:u32;var<private>h:vec4f;fn i(){var j:f32;var k:f32;var l:f32;var m:f32;let n=f;if(i32(n)==0){j=-4.;}else{j=1.;}let o=j;k=o;let p=f;if(i32(p)==2){l=4.;}else{l=-1.;}let q=l;m=q;let s=k;let t=m;d=((vec2f(s,t)*.5)+vec2(.5));let u=k;let v=m;h=vec4f(u,v,0.,1.);return;}@vertex 
fn main(@builtin(vertex_index)A:u32)->c{f=A;i();let B=d;let C=h;return c(B,C);}