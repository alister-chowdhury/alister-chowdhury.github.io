var<private> global: vec4<f32>;
var<private> global_1: vec3<f32>;

fn function() {
    let _e3 = global_1;
    global = vec4<f32>(_e3.x, _e3.y, _e3.z, 1.0);
    return;
}

@fragment 
fn main(@location(0) param: vec3<f32>) -> @location(0) vec4<f32> {
    global_1 = param;
    function();
    let _e3 = global;
    return _e3;
}
