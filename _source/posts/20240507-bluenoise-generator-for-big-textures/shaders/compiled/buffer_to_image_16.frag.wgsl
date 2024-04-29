struct _5_6_ {
    _m0_: vec2<i32>,
}

struct _8_9_ {
    _m0_: array<f32>,
}

struct FragmentOutput {
    @location(0) _4_: f32,
}

@group(0) @binding(0) 
var<uniform> _6_: _5_6_;
@group(0) @binding(1) 
var<storage> _9_: _8_9_;
var<private> _4_: f32;
var<private> gl_FragCoord_1: vec4<f32>;

fn main_1() {
    var _30_: vec2<i32>;
    var _31_: vec2<i32>;
    var _32_: vec2<i32>;

    let _e8 = gl_FragCoord_1;
    _30_ = vec2<i32>(_e8.xy);
    let _e12 = _30_;
    _31_ = (_e12 / vec2(16i));
    let _e17 = _30_;
    _32_ = (_e17 % vec2(16i));
    let _e22 = _31_;
    let _e24 = _6_;
    let _e28 = _31_;
    let _e33 = _32_;
    let _e38 = _32_;
    let _e43 = _9_._m0_[(((((_e22.y * _e24._m0_.x) + _e28.x) * 256i) + (_e33.y * 16i)) + _e38.x)];
    _4_ = _e43;
    return;
}

@fragment 
fn main(@builtin(position) gl_FragCoord: vec4<f32>) -> FragmentOutput {
    gl_FragCoord_1 = gl_FragCoord;
    main_1();
    let _e11 = _4_;
    return FragmentOutput(_e11);
}
