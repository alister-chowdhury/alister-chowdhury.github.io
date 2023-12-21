struct _7_8_ {
    _m0_: array<vec4<f32>>,
}

struct _9_10_ {
    _m0_: vec3<f32>,
}

struct VertexOutput {
    @location(0) _4_: vec3<f32>,
    @builtin(position) member: vec4<f32>,
}

@group(0) @binding(0) 
var<storage> _8_: _7_8_;
@group(0) @binding(1) 
var<uniform> _10_: _9_10_;
var<private> _4_: vec3<f32>;
var<private> gl_VertexIndex: u32;
var<private> gl_Position: vec4<f32>;

fn main_1() {
    var _40_: u32;
    var _50_: vec2<f32>;

    let _e8 = gl_VertexIndex;
    _40_ = u32((i32(_e8) / 2));
    let _e15 = gl_VertexIndex;
    if ((i32(_e15) % 2) == 0) {
        {
            let _e21 = _40_;
            let _e24 = _8_._m0_[_e21];
            _50_ = _e24.xy;
        }
    } else {
        {
            let _e26 = _40_;
            let _e29 = _8_._m0_[_e26];
            _50_ = _e29.zw;
        }
    }
    let _e31 = _10_;
    _4_ = _e31._m0_;
    let _e34 = _50_;
    let _e39 = ((_e34 * 2.0) - vec2(1.0));
    gl_Position = vec4<f32>(_e39.x, _e39.y, 0.0, 1.0);
    return;
}

@vertex 
fn main(@builtin(vertex_index) param: u32) -> VertexOutput {
    gl_VertexIndex = param;
    main_1();
    let _e11 = _4_;
    let _e13 = gl_Position;
    return VertexOutput(_e11, _e13);
}
