var<private> global: vec4<f32>;
var<private> global_1: vec3<f32>;
var<private> global_2: vec2<f32>;

fn function() {
    let _e4 = global_1;
    let _e9 = global_2;
    global = (vec4<f32>(_e4.x, _e4.y, _e4.z, 1.0) * step(length(_e9), 1.0));
    return;
}

@fragment 
fn main(@location(1) @interpolate(flat) param: vec3<f32>, @location(0) param_1: vec2<f32>) -> @location(0) vec4<f32> {
    global_1 = param;
    global_2 = param_1;
    function();
    let _e5 = global;
    return _e5;
}
