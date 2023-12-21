struct _10_11_ {
    _m0_: array<vec4<f32>>,
}

struct _12_13_ {
    _m0_: i32,
}

struct VertexOutput {
    @location(3) _4_: vec2<f32>,
    @location(2) @interpolate(flat) _5_: f32,
    @location(0) @interpolate(flat) _6_: vec3<f32>,
    @location(1) @interpolate(flat) _7_: vec3<f32>,
    @builtin(position) member: vec4<f32>,
}

var<private> _60_: bool;
var<private> _61_: vec4<f32>;
@group(0) @binding(0) 
var<storage> _11_: _10_11_;
@group(0) @binding(1) 
var<uniform> _13_: _12_13_;
var<private> _4_: vec2<f32>;
var<private> _5_: f32;
var<private> _6_: vec3<f32>;
var<private> _7_: vec3<f32>;
var<private> gl_VertexIndex: u32;
var<private> gl_Position: vec4<f32>;

fn main_1() {
    var _74_: i32;
    var _81_: i32;
    var _87_: i32;
    var _82_: u32;
    var _132_: vec4<f32>;
    var _136_: bool;
    var _96_: vec4<f32>;
    var _90_: u32;
    var _93_: u32;
    var _97_: vec4<f32>;
    var _133_: bool;
    var _134_: bool;
    var _89_: u32;
    var _92_: u32;
    var _94_: i32;
    var _105_: u32;
    var _111_: bool;
    var _118_: bool;
    var _129_: vec2<f32>;
    var _139_: vec4<f32>;
    var _141_: bool;
    var _149_: f32;
    var _151_: bool;
    var _159_: f32;
    var _166_: f32;
    var _172_: f32;
    var _184_: f32;
    var _191_: f32;
    var _192_: f32;
    var _202_: f32;

    let _e13 = gl_VertexIndex;
    _74_ = (i32(_e13) % 6);
    loop {
        {
            let _e19 = _74_;
            if (_e19 < 3) {
                {
                    let _e22 = _74_;
                    _81_ = _e22;
                    break;
                }
            }
            let _e23 = _74_;
            _81_ = (_e23 - 2);
            break;
        }
    }
    let _e29 = gl_VertexIndex;
    let _e33 = _13_;
    _82_ = u32(((i32(_e29) / 6) + _e33._m0_));
    loop {
        {
            let _e40 = _82_;
            let _e43 = _82_;
            _87_ = (i32(firstLeadingBit((_e43 + 2u))) - 1);
            let _e51 = _61_;
            _96_ = _e51;
            _89_ = 0u;
            _92_ = 0u;
            _94_ = 0;
            loop {
                {
                    let _e63 = _94_;
                    let _e64 = _87_;
                    if (_e63 <= _e64) {
                        {
                            let _e66 = _92_;
                            if (_e66 != 0u) {
                                {
                                    let _e69 = _96_;
                                    _132_ = _e69;
                                    _133_ = false;
                                    _134_ = true;
                                    break;
                                }
                            }
                            let _e72 = _82_;
                            let _e73 = _94_;
                            _105_ = ((_e72 >> u32(_e73)) & 1u);
                            let _e79 = _89_;
                            let _e82 = _105_;
                            let _e86 = _11_._m0_[((_e79 + 1u) + _e82)];
                            _97_ = _e86;
                            let _e87 = _97_;
                            let _e89 = _97_;
                            _111_ = (_e87.x >= _e89.z);
                            let _e94 = _111_;
                            if !(_e94) {
                                {
                                    let _e96 = _97_;
                                    let _e98 = _97_;
                                    _118_ = (_e96.y >= _e98.w);
                                }
                            } else {
                                {
                                    let _e101 = _111_;
                                    _118_ = _e101;
                                }
                            }
                            let _e102 = _118_;
                            if _e102 {
                                {
                                    let _e103 = _97_;
                                    _132_ = _e103;
                                    _133_ = false;
                                    _134_ = true;
                                    break;
                                }
                            }
                            let _e107 = _105_;
                            if (_e107 == 0u) {
                                {
                                    let _e110 = _89_;
                                    let _e113 = _11_._m0_[_e110];
                                    _129_ = _e113.xy;
                                }
                            } else {
                                {
                                    let _e115 = _89_;
                                    let _e118 = _11_._m0_[_e115];
                                    _129_ = _e118.zw;
                                }
                            }
                            let _e120 = _129_;
                            let _e122 = _129_;
                            _93_ = bitcast<u32>(_e122.x);
                            let _e125 = _129_;
                            let _e127 = _129_;
                            _90_ = bitcast<u32>(_e127.y);
                            let _e130 = _90_;
                            _89_ = _e130;
                            let _e131 = _93_;
                            _92_ = _e131;
                            let _e132 = _94_;
                            _94_ = (_e132 + 1);
                            let _e135 = _97_;
                            _96_ = _e135;
                            continue;
                        }
                    } else {
                        {
                            let _e136 = _96_;
                            _132_ = _e136;
                            let _e137 = _60_;
                            _133_ = _e137;
                            _134_ = false;
                            break;
                        }
                    }
                }
            }
            let _e139 = _134_;
            if _e139 {
                {
                    let _e140 = _133_;
                    _136_ = _e140;
                    break;
                }
            }
            _136_ = true;
            break;
        }
    }
    let _e147 = _136_;
    let _e150 = _132_;
    let _e153 = _136_;
    _139_ = select(_e150, vec4(0.0), vec4(!(_e153)));
    let _e158 = _81_;
    _141_ = ((_e158 & 1) == 0);
    let _e165 = _141_;
    if _e165 {
        {
            _149_ = 0.0;
        }
    } else {
        {
            let _e168 = _139_;
            let _e170 = _139_;
            _149_ = (8.0 * (_e168.z - _e170.x));
        }
    }
    let _e174 = _81_;
    _151_ = ((_e174 & 2) == 0);
    let _e181 = _151_;
    if _e181 {
        {
            _159_ = 0.0;
        }
    } else {
        {
            let _e184 = _139_;
            let _e186 = _139_;
            _159_ = (8.0 * (_e184.w - _e186.y));
        }
    }
    let _e190 = _149_;
    let _e191 = _159_;
    _4_ = vec2<f32>(_e190, _e191);
    let _e194 = _141_;
    if _e194 {
        {
            let _e195 = _139_;
            _166_ = _e195.x;
        }
    } else {
        {
            let _e197 = _139_;
            _166_ = _e197.z;
        }
    }
    let _e200 = _151_;
    if _e200 {
        {
            let _e201 = _139_;
            _172_ = _e201.y;
        }
    } else {
        {
            let _e203 = _139_;
            _172_ = _e203.w;
        }
    }
    let _e205 = _87_;
    _5_ = f32(_e205);
    let _e208 = _82_;
    let _e221 = _82_;
    _184_ = (bitcast<f32>((1065353216u + (((((_e221 ^ 212636738u) * 1382995910u) ^ 3299551938u) * 1383044323u) & 8388607u))) - 1.0);
    let _e239 = _82_;
    let _e252 = _82_;
    _191_ = bitcast<f32>((1065353216u + ((((212636738u * (_e252 ^ 1382995910u)) ^ 3299551938u) * 1383044323u) & 8388607u)));
    let _e265 = _191_;
    _192_ = (_e265 - 1.0);
    let _e270 = _184_;
    let _e271 = _192_;
    let _e273 = _184_;
    let _e274 = _192_;
    let _e279 = _184_;
    let _e280 = _192_;
    let _e282 = _184_;
    let _e283 = _192_;
    if (fract((abs((_e282 - _e283)) + 1.0)) < 0.2) {
        {
            let _e291 = _191_;
            let _e295 = _191_;
            _202_ = fract((_e295 + -0.5));
        }
    } else {
        {
            let _e300 = _192_;
            _202_ = _e300;
        }
    }
    let _e305 = _184_;
    let _e314 = _184_;
    let _e327 = _184_;
    let _e336 = _184_;
    let _e348 = _184_;
    let _e357 = _184_;
    let _e373 = _184_;
    let _e382 = _184_;
    let _e395 = _184_;
    let _e404 = _184_;
    let _e416 = _184_;
    let _e425 = _184_;
    _6_ = clamp(vec3<f32>((abs(fma(_e382, 6.0, -3.0)) - 1.0), (2.0 - abs(fma(_e404, 6.0, -2.0))), (2.0 - abs(fma(_e425, 6.0, -4.0)))), vec3(0.0), vec3(1.0));
    let _e442 = _202_;
    let _e451 = _202_;
    let _e464 = _202_;
    let _e473 = _202_;
    let _e485 = _202_;
    let _e494 = _202_;
    let _e510 = _202_;
    let _e519 = _202_;
    let _e532 = _202_;
    let _e541 = _202_;
    let _e553 = _202_;
    let _e562 = _202_;
    _7_ = clamp(vec3<f32>((abs(fma(_e519, 6.0, -3.0)) - 1.0), (2.0 - abs(fma(_e541, 6.0, -2.0))), (2.0 - abs(fma(_e562, 6.0, -4.0)))), vec3(0.0), vec3(1.0));
    let _e576 = _166_;
    let _e577 = _172_;
    let _e583 = ((vec2<f32>(_e576, _e577) * 2.0) - vec2(1.0));
    gl_Position = vec4<f32>(_e583.x, _e583.y, 0.0, 1.0);
    return;
}

@vertex 
fn main(@builtin(vertex_index) param: u32) -> VertexOutput {
    gl_VertexIndex = param;
    main_1();
    let _e21 = _4_;
    let _e23 = _5_;
    let _e25 = _6_;
    let _e27 = _7_;
    let _e29 = gl_Position;
    return VertexOutput(_e21, _e23, _e25, _e27, _e29);
}
