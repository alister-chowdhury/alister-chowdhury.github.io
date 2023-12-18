struct VertexOutput {
    @location(0) _3_: vec2<f32>,
    @builtin(position) member: vec4<f32>,
}

var<private> _3_: vec2<f32>;
var<private> gl_VertexIndex: u32;
var<private> gl_Position: vec4<f32>;

fn main_1() {
    var local: f32;
    var local_1: f32;

    let _e2 = gl_VertexIndex;
    if (_e2 == 0u) {
        local = -4.0;
    } else {
        local = 1.0;
    }
    let _e8 = local;
    let _e9 = gl_VertexIndex;
    if (_e9 == 2u) {
        local_1 = 4.0;
    } else {
        local_1 = -1.0;
    }
    let _e15 = local_1;
    _3_ = vec2<f32>(_e8, _e15);
    let _e18 = _3_;
    gl_Position = vec4<f32>(_e18.x, _e18.y, 0.0, 1.0);
    return;
}

@vertex 
fn main(@builtin(vertex_index) param: u32) -> VertexOutput {
    gl_VertexIndex = param;
    main_1();
    let _e3 = _3_;
    let _e5 = gl_Position;
    return VertexOutput(_e3, _e5);
}
