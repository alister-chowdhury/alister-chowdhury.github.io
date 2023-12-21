struct _8_9_ {
    _m0_: array<vec4<f32>>,
}

struct VertexOutput {
    @location(0) _4_: vec2<f32>,
    @location(1) @interpolate(flat) _5_: vec3<f32>,
    @builtin(position) member: vec4<f32>,
}

@group(0) @binding(0) 
var<storage> _9_: _8_9_;
var<private> _4_: vec2<f32>;
var<private> _5_: vec3<f32>;
var<private> gl_VertexIndex: u32;
var<private> gl_Position: vec4<f32>;

fn main_1() {
    var _49_: u32;
    var _52_: i32;
    var _59_: i32;
    var _68_: vec2<f32>;
    var local: i32;
    var local_1: i32;
    var _79_: vec2<f32>;

    let _e6 = gl_VertexIndex;
    _49_ = u32((i32(_e6) / 12));
    let _e12 = gl_VertexIndex;
    _52_ = (i32(_e12) % 6);
    loop {
        {
            let _e18 = _52_;
            if (_e18 < 3) {
                {
                    let _e21 = _52_;
                    _59_ = _e21;
                    break;
                }
            }
            let _e22 = _52_;
            _59_ = (_e22 - 2);
            break;
        }
    }
    let _e28 = gl_VertexIndex;
    if (((i32(_e28) / 6) % 2) == 0) {
        {
            let _e36 = _49_;
            let _e39 = _9_._m0_[_e36];
            _68_ = _e39.xy;
        }
    } else {
        {
            let _e41 = _49_;
            let _e44 = _9_._m0_[_e41];
            _68_ = _e44.zw;
        }
    }
    let _e46 = _59_;
    if ((_e46 & 1) == 0) {
        local = -1;
    } else {
        local = 1;
    }
    let _e55 = local;
    let _e57 = _59_;
    if ((_e57 & 2) == 0) {
        local_1 = -1;
    } else {
        local_1 = 1;
    }
    let _e66 = local_1;
    _4_ = vec2<f32>(f32(_e55), f32(_e66));
    let _e69 = _68_;
    _79_ = ((_e69 * 0.5) + vec2(0.5));
    let _e77 = _79_;
    _5_.x = _e77.x;
    let _e80 = _79_;
    _5_.y = _e80.y;
    let _e84 = _5_;
    let _e86 = _5_;
    let _e90 = _5_;
    let _e92 = _5_;
    _5_.z = min(1.0, length(_e92.xy));
    let _e97 = _68_;
    let _e103 = _4_;
    let _e108 = (((_e97 * 2.0) - vec2(1.0)) + ((_e103 * 0.0125) * 2.0));
    gl_Position = vec4<f32>(_e108.x, _e108.y, 0.0, 1.0);
    return;
}

@vertex 
fn main(@builtin(vertex_index) param: u32) -> VertexOutput {
    gl_VertexIndex = param;
    main_1();
    let _e10 = _4_;
    let _e12 = _5_;
    let _e14 = gl_Position;
    return VertexOutput(_e10, _e12, _e14);
}
