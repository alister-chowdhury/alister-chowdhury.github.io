struct _5_ {
    _m0_: vec4<f32>,
    _m1_: vec4<f32>,
}

struct _6_7_ {
    _m0_: _5_,
}

struct _9_10_ {
    _m0_: array<vec4<f32>>,
}

struct _12_13_ {
    _m0_: array<f32>,
}

@group(0) @binding(0) 
var<uniform> _7_: _6_7_;
@group(0) @binding(2) 
var<storage> _10_: _9_10_;
@group(0) @binding(1) 
var<storage, read_write> _13_: _12_13_;
var<private> gl_WorkGroupID: vec3<u32>;
var<private> gl_LocalInvocationID: vec3<u32>;

fn main_1() {
    var _56_: vec2<i32>;
    var _60_: vec2<i32>;
    var _63_: vec2<i32>;
    var _69_: vec2<i32>;
    var _70_: vec2<f32>;
    var _72_: i32;
    var _81_: i32;
    var _83_: f32;
    var _84_: f32;
    var _86_: i32 = -1i;
    var _92_: f32;
    var _94_: i32;
    var _100_: vec2<i32>;
    var _101_: i32;
    var _107_: vec2<i32>;
    var _106_: vec2<i32>;
    var _115_: vec2<i32>;
    var _114_: vec2<i32>;
    var _122_: vec2<i32>;
    var _121_: vec2<i32>;
    var _124_: i32;
    var _130_: vec2<i32>;
    var _129_: vec2<i32>;
    var _134_: i32;
    var _143_: vec2<f32>;

    let _e9 = _7_;
    let _e13 = _7_;
    _56_ = bitcast<vec2<i32>>(_e13._m0_._m0_.zw);
    let _e20 = gl_WorkGroupID;
    _60_ = vec2<i32>(_e20.xy);
    let _e24 = _60_;
    let _e31 = _7_;
    let _e35 = _7_;
    _63_ = (((_e24 / vec2(4i)) * vec2(2i)) + bitcast<vec2<i32>>(_e35._m0_._m0_.xy));
    let _e43 = _60_;
    let _e50 = gl_LocalInvocationID;
    _69_ = (((_e43 % vec2(4i)) * vec2(8i)) + vec2<i32>(_e50.xy));
    let _e55 = _69_;
    _70_ = vec2<f32>(_e55);
    let _e58 = _56_;
    _72_ = _e58.x;
    let _e61 = _63_;
    let _e63 = _72_;
    let _e65 = _63_;
    let _e70 = _69_;
    let _e75 = _69_;
    _81_ = (((((_e61.y * _e63) + _e65.x) * 1024i) + (_e70.y * 32i)) + _e75.x);
    _83_ = 0f;
    loop {
        let _e85 = _86_;
        if !((_e85 <= 1i)) {
            break;
        }
        {
            let _e92 = _83_;
            _84_ = _e92;
            _94_ = -1i;
            loop {
                let _e97 = _94_;
                if !((_e97 <= 1i)) {
                    break;
                }
                {
                    let _e104 = _63_;
                    let _e105 = _94_;
                    let _e106 = _86_;
                    _100_ = (_e104 + vec2<i32>(_e105, _e106));
                    let _e110 = _100_;
                    _101_ = _e110.x;
                    let _e114 = _101_;
                    if (_e114 < 0i) {
                        {
                            let _e117 = _100_;
                            _106_ = _e117;
                            let _e120 = _101_;
                            let _e121 = _72_;
                            _106_.x = (_e120 + _e121);
                            let _e123 = _106_;
                            _107_ = _e123;
                        }
                    } else {
                        {
                            let _e124 = _100_;
                            _107_ = _e124;
                        }
                    }
                    let _e126 = _107_;
                    if (_e126.y < 0i) {
                        {
                            let _e130 = _107_;
                            _114_ = _e130;
                            let _e133 = _107_;
                            let _e135 = _56_;
                            _114_.y = (_e133.y + _e135.y);
                            let _e138 = _114_;
                            _115_ = _e138;
                        }
                    } else {
                        {
                            let _e139 = _107_;
                            _115_ = _e139;
                        }
                    }
                    let _e141 = _115_;
                    let _e143 = _72_;
                    if (_e141.x >= _e143) {
                        {
                            let _e145 = _115_;
                            _121_ = _e145;
                            let _e148 = _115_;
                            let _e150 = _72_;
                            _121_.x = (_e148.x - _e150);
                            let _e152 = _121_;
                            _122_ = _e152;
                        }
                    } else {
                        {
                            let _e153 = _115_;
                            _122_ = _e153;
                        }
                    }
                    let _e154 = _56_;
                    _124_ = _e154.y;
                    let _e158 = _122_;
                    let _e160 = _124_;
                    if (_e158.y >= _e160) {
                        {
                            let _e162 = _122_;
                            _129_ = _e162;
                            let _e165 = _122_;
                            let _e167 = _124_;
                            _129_.y = (_e165.y - _e167);
                            let _e169 = _129_;
                            _130_ = _e169;
                        }
                    } else {
                        {
                            let _e170 = _122_;
                            _130_ = _e170;
                        }
                    }
                    let _e171 = _130_;
                    let _e173 = _72_;
                    let _e175 = _130_;
                    _134_ = ((_e171.y * _e173) + _e175.x);
                    let _e179 = _94_;
                    let _e181 = _86_;
                    let _e186 = _134_;
                    let _e189 = _10_._m0_[_e186];
                    let _e192 = _70_;
                    _143_ = (((vec2<f32>(f32(_e179), f32(_e181)) * 32f) + _e189.xy) - _e192);
                    let _e197 = _143_;
                    let _e198 = _143_;
                    let _e201 = _7_;
                    let _e208 = _143_;
                    let _e209 = _143_;
                    let _e212 = _7_;
                    let _e218 = _134_;
                    let _e221 = _10_._m0_[_e218];
                    let _e226 = _143_;
                    let _e227 = _143_;
                    let _e230 = _7_;
                    let _e237 = _143_;
                    let _e238 = _143_;
                    let _e241 = _7_;
                    let _e247 = _134_;
                    let _e250 = _10_._m0_[_e247];
                    let _e252 = _84_;
                    _92_ = fma(exp2((-(dot(_e237, _e238)) * _e241._m0_._m1_.x)), _e250.z, _e252);
                }
                continuing {
                    let _e101 = _94_;
                    _94_ = (_e101 + 1i);
                }
            }
        }
        continuing {
            let _e89 = _86_;
            _86_ = (_e89 + 1i);
        }
    }
    let _e254 = _81_;
    let _e257 = _81_;
    let _e260 = _13_._m0_[_e257];
    let _e261 = _83_;
    _13_._m0_[_e254] = (_e260 + _e261);
    return;
}

@compute @workgroup_size(8, 8, 1) 
fn main(@builtin(workgroup_id) param: vec3<u32>, @builtin(local_invocation_id) param_1: vec3<u32>) {
    gl_WorkGroupID = param;
    gl_LocalInvocationID = param_1;
    main_1();
    return;
}
