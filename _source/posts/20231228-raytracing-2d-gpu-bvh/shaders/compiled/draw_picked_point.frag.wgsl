var<private> global: vec2<f32>;
var<private> global_1: vec4<f32>;

fn function() {
    let _e5 = global;
    let _e6 = length(_e5);
    let _e7 = step(_e6, 1.0);
    let _e9 = (_e7 * smoothstep(0.1, 0.75, _e6));
    global_1 = (vec4<f32>(_e9, _e9, _e9, 1.0) * _e7);
    return;
}

@fragment 
fn main(@location(0) param: vec2<f32>) -> @location(0) vec4<f32> {
    global = param;
    function();
    let _e3 = global_1;
    return _e3;
}
