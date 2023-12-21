var<private>c:vec4f;var<private>d:vec3f;fn function(){let e=d;c=vec4f(e.x,e.y,e.z,1.);return;}@fragment 
fn main(@location(0)f:vec3f)->@location(0)vec4f{d=f;function();let e=c;return e;}