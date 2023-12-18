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
    if (_e2 == 0u) {
        local = -4.0;
    } else {
        local = 1.0;
    }
    let _e8 = local;
    _33_ = _e8;
    let _e10 = gl_VertexIndex;
    if (_e10 == 2u) {
        local_1 = 4.0;
    } else {
        local_1 = -1.0;
    }
    let _e16 = local_1;
    _35_ = _e16;
    let _e18 = _33_;
    let _e19 = _35_;
    _4_ = ((vec2<f32>(_e18, _e19) * 0.5) + vec2(0.5));
    let _e27 = _33_;
    let _e28 = _35_;
    gl_Position = vec4<f32>(_e27, _e28, 0.0, 1.0);
    return;
}

@vertex 
fn main(@builtin(vertex_index) param: u32) -> VertexOutput {
    gl_VertexIndex = param;
    main_1();
    let _e3 = _4_;
    let _e5 = gl_Position;
    return VertexOutput(_e3, _e5);
}
