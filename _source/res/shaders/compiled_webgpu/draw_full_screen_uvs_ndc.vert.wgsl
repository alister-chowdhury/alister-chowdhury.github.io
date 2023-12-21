struct VertexOutput {
    @location(1) _3_: vec2<f32>,
    @location(0) _5_: vec2<f32>,
    @builtin(position) member: vec4<f32>,
}

var<private> _3_: vec2<f32>;
var<private> _5_: vec2<f32>;
var<private> gl_VertexIndex: u32;
var<private> gl_Position: vec4<f32>;

fn main_1() {
    var local: f32;
    var local_1: f32;

    let _e3 = gl_VertexIndex;
    if (i32(_e3) == 0) {
        local = -4.0;
    } else {
        local = 1.0;
    }
    let _e11 = local;
    let _e12 = gl_VertexIndex;
    if (i32(_e12) == 2) {
        local_1 = 4.0;
    } else {
        local_1 = -1.0;
    }
    let _e20 = local_1;
    _3_ = vec2<f32>(_e11, _e20);
    let _e22 = _3_;
    _5_ = ((_e22 * 0.5) + vec2(0.5));
    let _e29 = _3_;
    gl_Position = vec4<f32>(_e29.x, _e29.y, 0.0, 1.0);
    return;
}

@vertex 
fn main(@builtin(vertex_index) param: u32) -> VertexOutput {
    gl_VertexIndex = param;
    main_1();
    let _e7 = _3_;
    let _e9 = _5_;
    let _e11 = gl_Position;
    return VertexOutput(_e7, _e9, _e11);
}
