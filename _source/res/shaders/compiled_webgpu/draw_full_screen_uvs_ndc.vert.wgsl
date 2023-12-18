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
    if (_e3 == 0u) {
        local = -4.0;
    } else {
        local = 1.0;
    }
    let _e9 = local;
    let _e10 = gl_VertexIndex;
    if (_e10 == 2u) {
        local_1 = 4.0;
    } else {
        local_1 = -1.0;
    }
    let _e16 = local_1;
    _3_ = vec2<f32>(_e9, _e16);
    let _e18 = _3_;
    _5_ = ((_e18 * 0.5) + vec2(0.5));
    let _e25 = _3_;
    gl_Position = vec4<f32>(_e25.x, _e25.y, 0.0, 1.0);
    return;
}

@vertex 
fn main(@builtin(vertex_index) param: u32) -> VertexOutput {
    gl_VertexIndex = param;
    main_1();
    let _e3 = _3_;
    let _e5 = _5_;
    let _e7 = gl_Position;
    return VertexOutput(_e3, _e5, _e7);
}
