struct type_6 {
    member: vec4<f32>,
}

var<private> global: vec2<f32>;
@group(0) @binding(0) 
var<uniform> global_1: type_6;
@group(0) @binding(1) 
var global_2: texture_2d<f32>;
var<private> global_3: vec4<f32>;

fn function() {
    let _e6 = global;
    let _e8 = global_1.member;
    let _e12 = textureLoad(global_2, vec2<i32>((_e6 * _e8.xy)), 0i);
    global_3 = vec4<f32>(_e12.x, _e12.x, _e12.x, 1f);
    return;
}

@fragment 
fn main(@location(0) param: vec2<f32>) -> @location(0) vec4<f32> {
    global = param;
    function();
    let _e3 = global_3;
    return _e3;
}
