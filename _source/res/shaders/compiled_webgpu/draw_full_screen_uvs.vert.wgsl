struct VertexOutput {
    @location(0) _4_: vec2<f32>,
    @builtin(position) member: vec4<f32>,
}

var<private> _4_: vec2<f32>;
var<private> gl_VertexIndex: u32;
var<private> gl_Position: vec4<f32>;

fn main_1() {
    var local: f32;
    var _33_: f32;
    var local_1: f32;
    var _35_: f32;

    let _e2 = gl_VertexIndex;
    if (i32(_e2) == 0) {
        local = -4.0;
    } else {
        local = 1.0;
    }
    let _e10 = local;
    _33_ = _e10;
    let _e12 = gl_VertexIndex;
    if (i32(_e12) == 2) {
        local_1 = 4.0;
    } else {
        local_1 = -1.0;
    }
    let _e20 = local_1;
    _35_ = _e20;
    let _e22 = _33_;
    let _e23 = _35_;
    _4_ = ((vec2<f32>(_e22, _e23) * 0.5) + vec2(0.5));
    let _e31 = _33_;
    let _e32 = _35_;
    gl_Position = vec4<f32>(_e31, _e32, 0.0, 1.0);
    return;
}

@vertex 
fn main(@builtin(vertex_index) param: u32) -> VertexOutput {
    gl_VertexIndex = param;
    main_1();
    let _e5 = _4_;
    let _e7 = gl_Position;
    return VertexOutput(_e5, _e7);
}
