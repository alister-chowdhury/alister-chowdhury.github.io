var<private> global: vec2<f32>;
var<private> global_1: f32;
var<private> global_2: vec4<f32>;
var<private> global_3: vec3<f32>;
var<private> global_4: vec3<f32>;

fn function() {
    let _e8 = global;
    let _e9 = global_1;
    let _e11 = ((_e8 * _e9) * _e9);
    let _e20 = global_3;
    let _e21 = global_4;
    let _e23 = select(_e21, _e20, vec3((((i32(_e11.x) & 1) ^ (i32(_e11.y) & 1)) == 0)));
    global_2 = vec4<f32>(_e23.x, _e23.y, _e23.z, 0.9);
    return;
}

@fragment 
fn main(@location(3) param: vec2<f32>, @location(2) @interpolate(flat) param_1: f32, @location(0) @interpolate(flat) param_2: vec3<f32>, @location(1) @interpolate(flat) param_3: vec3<f32>) -> @location(0) vec4<f32> {
    global = param;
    global_1 = param_1;
    global_3 = param_2;
    global_4 = param_3;
    function();
    let _e9 = global_2;
    return _e9;
}
