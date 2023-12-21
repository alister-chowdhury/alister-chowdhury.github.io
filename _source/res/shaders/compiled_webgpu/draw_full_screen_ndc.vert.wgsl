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
    if (i32(_e2) == 0) {
        local = -4.0;
    } else {
        local = 1.0;
    }
    let _e10 = local;
    let _e11 = gl_VertexIndex;
    if (i32(_e11) == 2) {
        local_1 = 4.0;
    } else {
        local_1 = -1.0;
    }
    let _e19 = local_1;
    _3_ = vec2<f32>(_e10, _e19);
    let _e22 = _3_;
    gl_Position = vec4<f32>(_e22.x, _e22.y, 0.0, 1.0);
    return;
}

@vertex 
fn main(@builtin(vertex_index) param: u32) -> VertexOutput {
    gl_VertexIndex = param;
    main_1();
    let _e5 = _3_;
    let _e7 = gl_Position;
    return VertexOutput(_e5, _e7);
}
