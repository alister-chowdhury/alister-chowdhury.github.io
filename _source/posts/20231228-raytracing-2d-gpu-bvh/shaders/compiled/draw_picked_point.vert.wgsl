struct _6_7_ {
    _m0_: vec2<u32>,
}

struct _10_11_ {
    _m0_: array<vec4<f32>>,
}

struct VertexOutput {
    @location(0) _4_: vec2<f32>,
    @builtin(position) member: vec4<f32>,
}

@group(0) @binding(1) 
var<uniform> _7_: _6_7_;
@group(0) @binding(0) 
var<storage> _11_: _10_11_;
var<private> _4_: vec2<f32>;
var<private> gl_VertexIndex: u32;
var<private> gl_Position: vec4<f32>;

fn main_1() {
    var _53_: i32;
    var _71_: vec2<f32>;
    var local: i32;
    var local_1: i32;

    loop {
        {
            let _e9 = gl_VertexIndex;
            if (i32(_e9) < 3) {
                {
                    let _e13 = gl_VertexIndex;
                    _53_ = i32(_e13);
                    break;
                }
            }
            let _e15 = gl_VertexIndex;
            _53_ = (i32(_e15) - 2);
            break;
        }
    }
    let _e21 = _7_;
    if (_e21._m0_.x == 4294967295u) {
        {
            _4_ = vec2(0.0);
            gl_Position = vec4(0.0);
            return;
        }
    } else {
        {
            let _e32 = _7_;
            if (_e32._m0_.y == 0u) {
                {
                    let _e37 = _7_;
                    let _e42 = _11_._m0_[_e37._m0_.x];
                    _71_ = _e42.xy;
                }
            } else {
                {
                    let _e44 = _7_;
                    let _e49 = _11_._m0_[_e44._m0_.x];
                    _71_ = _e49.zw;
                }
            }
            let _e51 = _53_;
            if ((_e51 & 1) == 0) {
                local = -1;
            } else {
                local = 1;
            }
            let _e60 = local;
            let _e62 = _53_;
            if ((_e62 & 2) == 0) {
                local_1 = -1;
            } else {
                local_1 = 1;
            }
            let _e71 = local_1;
            _4_ = vec2<f32>(f32(_e60), f32(_e71));
            let _e74 = _71_;
            let _e80 = _4_;
            let _e85 = (((_e74 * 2.0) - vec2(1.0)) + ((_e80 * 0.0125) * 2.0));
            gl_Position = vec4<f32>(_e85.x, _e85.y, 0.0, 1.0);
            return;
        }
    }
}

@vertex 
fn main(@builtin(vertex_index) param: u32) -> VertexOutput {
    gl_VertexIndex = param;
    main_1();
    let _e11 = _4_;
    let _e13 = gl_Position;
    return VertexOutput(_e11, _e13);
}
