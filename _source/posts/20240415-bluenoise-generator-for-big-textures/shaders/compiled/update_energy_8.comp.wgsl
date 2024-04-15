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
    var _54_: vec2<i32>;
    var _58_: vec2<i32>;
    var _61_: vec2<i32>;
    var _67_: vec2<i32>;
    var _68_: vec2<f32>;
    var _70_: i32;
    var _79_: i32;
    var _81_: f32;
    var _82_: f32;
    var _84_: i32 = -1i;
    var _90_: f32;
    var _92_: i32;
    var _98_: vec2<i32>;
    var _99_: i32;
    var _105_: vec2<i32>;
    var _104_: vec2<i32>;
    var _113_: vec2<i32>;
    var _112_: vec2<i32>;
    var _120_: vec2<i32>;
    var _119_: vec2<i32>;
    var _122_: i32;
    var _128_: vec2<i32>;
    var _127_: vec2<i32>;
    var _132_: i32;
    var _141_: vec2<f32>;

    let _e9 = _7_;
    let _e13 = _7_;
    _54_ = bitcast<vec2<i32>>(_e13._m0_._m0_.zw);
    let _e20 = gl_WorkGroupID;
    _58_ = vec2<i32>(_e20.xy);
    let _e24 = _58_;
    let _e31 = _7_;
    let _e35 = _7_;
    _61_ = (((_e24 / vec2(1i)) * vec2(2i)) + bitcast<vec2<i32>>(_e35._m0_._m0_.xy));
    let _e43 = _58_;
    let _e50 = gl_LocalInvocationID;
    _67_ = (((_e43 % vec2(1i)) * vec2(8i)) + vec2<i32>(_e50.xy));
    let _e55 = _67_;
    _68_ = vec2<f32>(_e55);
    let _e58 = _54_;
    _70_ = _e58.x;
    let _e61 = _61_;
    let _e63 = _70_;
    let _e65 = _61_;
    let _e70 = _67_;
    let _e75 = _67_;
    _79_ = (((((_e61.y * _e63) + _e65.x) * 64i) + (_e70.y * 8i)) + _e75.x);
    _81_ = 0f;
    loop {
        let _e85 = _84_;
        if !((_e85 <= 1i)) {
            break;
        }
        {
            let _e92 = _81_;
            _82_ = _e92;
            _92_ = -1i;
            loop {
                let _e97 = _92_;
                if !((_e97 <= 1i)) {
                    break;
                }
                {
                    let _e104 = _61_;
                    let _e105 = _92_;
                    let _e106 = _84_;
                    _98_ = (_e104 + vec2<i32>(_e105, _e106));
                    let _e110 = _98_;
                    _99_ = _e110.x;
                    let _e114 = _99_;
                    if (_e114 < 0i) {
                        {
                            let _e117 = _98_;
                            _104_ = _e117;
                            let _e120 = _99_;
                            let _e121 = _70_;
                            _104_.x = (_e120 + _e121);
                            let _e123 = _104_;
                            _105_ = _e123;
                        }
                    } else {
                        {
                            let _e124 = _98_;
                            _105_ = _e124;
                        }
                    }
                    let _e126 = _105_;
                    if (_e126.y < 0i) {
                        {
                            let _e130 = _105_;
                            _112_ = _e130;
                            let _e133 = _105_;
                            let _e135 = _54_;
                            _112_.y = (_e133.y + _e135.y);
                            let _e138 = _112_;
                            _113_ = _e138;
                        }
                    } else {
                        {
                            let _e139 = _105_;
                            _113_ = _e139;
                        }
                    }
                    let _e141 = _113_;
                    let _e143 = _70_;
                    if (_e141.x >= _e143) {
                        {
                            let _e145 = _113_;
                            _119_ = _e145;
                            let _e148 = _113_;
                            let _e150 = _70_;
                            _119_.x = (_e148.x - _e150);
                            let _e152 = _119_;
                            _120_ = _e152;
                        }
                    } else {
                        {
                            let _e153 = _113_;
                            _120_ = _e153;
                        }
                    }
                    let _e154 = _54_;
                    _122_ = _e154.y;
                    let _e158 = _120_;
                    let _e160 = _122_;
                    if (_e158.y >= _e160) {
                        {
                            let _e162 = _120_;
                            _127_ = _e162;
                            let _e165 = _120_;
                            let _e167 = _122_;
                            _127_.y = (_e165.y - _e167);
                            let _e169 = _127_;
                            _128_ = _e169;
                        }
                    } else {
                        {
                            let _e170 = _120_;
                            _128_ = _e170;
                        }
                    }
                    let _e171 = _128_;
                    let _e173 = _70_;
                    let _e175 = _128_;
                    _132_ = ((_e171.y * _e173) + _e175.x);
                    let _e179 = _92_;
                    let _e181 = _84_;
                    let _e186 = _132_;
                    let _e189 = _10_._m0_[_e186];
                    let _e192 = _68_;
                    _141_ = (((vec2<f32>(f32(_e179), f32(_e181)) * 8f) + _e189.xy) - _e192);
                    let _e197 = _141_;
                    let _e198 = _141_;
                    let _e201 = _7_;
                    let _e208 = _141_;
                    let _e209 = _141_;
                    let _e212 = _7_;
                    let _e218 = _132_;
                    let _e221 = _10_._m0_[_e218];
                    let _e226 = _141_;
                    let _e227 = _141_;
                    let _e230 = _7_;
                    let _e237 = _141_;
                    let _e238 = _141_;
                    let _e241 = _7_;
                    let _e247 = _132_;
                    let _e250 = _10_._m0_[_e247];
                    let _e252 = _82_;
                    _90_ = fma(exp2((-(dot(_e237, _e238)) * _e241._m0_._m1_.x)), _e250.z, _e252);
                }
                continuing {
                    let _e101 = _92_;
                    _92_ = (_e101 + 1i);
                }
            }
        }
        continuing {
            let _e89 = _84_;
            _84_ = (_e89 + 1i);
        }
    }
    let _e254 = _79_;
    let _e257 = _79_;
    let _e260 = _13_._m0_[_e257];
    let _e261 = _81_;
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
