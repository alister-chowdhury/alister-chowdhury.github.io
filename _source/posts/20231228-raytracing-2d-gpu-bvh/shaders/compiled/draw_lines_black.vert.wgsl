struct _7_8_ {
    _m0_: array<vec4<f32>>,
}

struct VertexOutput {
    @location(0) _4_: vec3<f32>,
    @builtin(position) member: vec4<f32>,
}

@group(0) @binding(0) 
var<storage> _8_: _7_8_;
var<private> _4_: vec3<f32>;
var<private> gl_VertexIndex: u32;
var<private> gl_Position: vec4<f32>;

fn main_1() {
    var _37_: u32;
    var _47_: vec2<f32>;

    let _e5 = gl_VertexIndex;
    _37_ = u32((i32(_e5) / 2));
    let _e12 = gl_VertexIndex;
    if ((i32(_e12) % 2) == 0) {
        {
            let _e18 = _37_;
            let _e21 = _8_._m0_[_e18];
            _47_ = _e21.xy;
        }
    } else {
        {
            let _e23 = _37_;
            let _e26 = _8_._m0_[_e23];
            _47_ = _e26.zw;
        }
    }
    _4_ = vec3(0.0);
    let _e31 = _47_;
    let _e36 = ((_e31 * 2.0) - vec2(1.0));
    gl_Position = vec4<f32>(_e36.x, _e36.y, 0.0, 1.0);
    return;
}

@vertex 
fn main(@builtin(vertex_index) param: u32) -> VertexOutput {
    gl_VertexIndex = param;
    main_1();
    let _e8 = _4_;
    let _e10 = gl_Position;
    return VertexOutput(_e8, _e10);
}
