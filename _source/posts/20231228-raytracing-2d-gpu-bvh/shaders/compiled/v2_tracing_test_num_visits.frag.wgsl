struct type_8 {
    member: array<vec4<f32>>,
}

struct type_15 {
    member: vec2<f32>,
}

@group(0) @binding(0) 
var<storage> global: type_8;
var<private> global_1: vec2<f32>;
@group(0) @binding(1) 
var<uniform> global_2: type_15;
var<private> global_3: vec4<f32>;

fn function() {
    var local: array<i32, 9>;
    var phi_56_: i32;
    var phi_59_: vec2<i32>;
    var phi_61_: vec2<f32>;
    var phi_63_: f32;
    var phi_65_: vec2<f32>;
    var phi_67_: i32;
    var phi_69_: i32;
    var phi_71_: bool;
    var phi_111_: vec2<f32>;
    var phi_118_: vec2<f32>;
    var phi_131_: bool;
    var phi_134_: f32;
    var phi_135_: bool;
    var phi_150_: vec2<f32>;
    var phi_153_: u32;
    var phi_155_: f32;
    var phi_195_: bool;
    var phi_151_: vec2<f32>;
    var phi_156_: f32;
    var phi_202_: f32;
    var phi_203_: vec2<f32>;
    var phi_204_: i32;
    var phi_205_: f32;
    var phi_206_: vec2<f32>;
    var phi_207_: bool;
    var local_1: vec2<f32>;
    var local_2: f32;
    var local_3: vec2<f32>;
    var local_4: f32;
    var phi_231_: vec2<f32>;
    var phi_238_: vec2<f32>;
    var phi_251_: bool;
    var phi_254_: f32;
    var phi_255_: bool;
    var phi_270_: vec2<f32>;
    var phi_273_: u32;
    var phi_275_: f32;
    var phi_315_: bool;
    var phi_271_: vec2<f32>;
    var phi_276_: f32;
    var phi_322_: f32;
    var phi_323_: vec2<f32>;
    var phi_324_: i32;
    var phi_64_: f32;
    var phi_66_: vec2<f32>;
    var phi_325_: bool;
    var local_5: f32;
    var local_6: f32;
    var phi_345_: i32;
    var phi_346_: i32;
    var phi_348_: i32;
    var phi_349_: i32;
    var phi_350_: bool;
    var phi_351_: i32;
    var phi_352_: i32;
    var phi_353_: bool;
    var local_7: f32;
    var local_8: f32;
    var phi_359_: vec2<f32>;
    var phi_360_: vec2<i32>;
    var phi_57_: i32;
    var phi_60_: vec2<i32>;
    var phi_62_: vec2<f32>;
    var phi_68_: i32;
    var phi_72_: bool;
    var local_9: i32;
    var local_10: i32;
    var local_11: vec2<i32>;
    var local_12: vec2<f32>;
    var local_13: f32;
    var local_14: vec2<f32>;
    var local_15: i32;
    var local_16: i32;
    var local_17: bool;
    var local_18: vec2<f32>;
    var local_19: f32;
    var local_20: f32;
    var local_21: vec2<f32>;
    var local_22: vec2<f32>;
    var local_23: f32;
    var local_24: f32;
    var local_25: vec2<f32>;

    let _e19 = global_1;
    let _e21 = global_2.member;
    let _e22 = (_e19 - _e21);
    let _e23 = length(_e22);
    let _e25 = (_e22 / vec2(_e23));
    let _e28 = (vec2<f32>(1.0, 1.0) / _e25);
    phi_56_ = 0;
    phi_59_ = vec2<i32>();
    phi_61_ = vec2<f32>();
    phi_63_ = (_e23 * _e23);
    phi_65_ = (_e25 * _e23);
    phi_67_ = 0;
    phi_69_ = 0;
    phi_71_ = false;
    loop {
        let _e30 = phi_56_;
        let _e32 = phi_59_;
        let _e34 = phi_61_;
        let _e36 = phi_63_;
        let _e38 = phi_65_;
        let _e40 = phi_67_;
        let _e42 = phi_69_;
        let _e44 = phi_71_;
        local_9 = _e42;
        if !(_e44) {
            let _e49 = global.member[_e40];
            let _e53 = global.member[(_e40 + 1)];
            let _e57 = global.member[(_e40 + 2)];
            local_16 = (_e42 + 1);
            switch bitcast<i32>(0u) {
                default: {
                    switch bitcast<i32>(0u) {
                        default: {
                            let _e66 = _e21.xx;
                            let _e69 = ((vec2<f32>(_e53.x, _e53.z) - _e66) * _e28.x);
                            let _e73 = _e21.yy;
                            let _e76 = ((vec2<f32>(_e53.y, _e53.w) - _e73) * _e28.y);
                            phi_111_ = _e69;
                            local_1 = _e66;
                            local_2 = _e28.x;
                            local_3 = _e73;
                            local_4 = _e28.y;
                            if (_e69.x > _e69.y) {
                                phi_111_ = _e69.yx;
                            }
                            let _e82 = phi_111_;
                            phi_118_ = _e76;
                            if (_e76.x > _e76.y) {
                                phi_118_ = _e76.yx;
                            }
                            let _e88 = phi_118_;
                            let _e95 = max(0.0, max(_e82.x, _e88.x));
                            let _e96 = (_e95 <= min(_e82.y, _e88.y));
                            phi_131_ = _e96;
                            if _e96 {
                                phi_131_ = ((_e95 * _e95) < _e36);
                            }
                            let _e100 = phi_131_;
                            if _e100 {
                                phi_134_ = _e95;
                                phi_135_ = true;
                                break;
                            }
                            phi_134_ = _e34.x;
                            phi_135_ = false;
                            break;
                        }
                    }
                    let _e102 = phi_134_;
                    let _e104 = phi_135_;
                    phi_202_ = _e36;
                    phi_203_ = _e38;
                    local_5 = _e102;
                    local_7 = _e102;
                    if _e104 {
                        let _e105 = bitcast<vec2<u32>>(_e49.xy);
                        if (_e105.x != 0u) {
                            phi_150_ = _e38;
                            phi_153_ = _e105.y;
                            phi_155_ = _e36;
                            loop {
                                let _e115 = phi_150_;
                                let _e117 = phi_153_;
                                let _e119 = phi_155_;
                                local_20 = _e119;
                                local_21 = _e115;
                                if (_e117 < (_e105.y + (_e105.x >> bitcast<u32>(1)))) {
                                    let _e123 = global.member[_e117];
                                    let _e124 = -(_e115);
                                    let _e126 = (_e21 - _e123.xy);
                                    let _e133 = fma(_e124.x, _e123.w, -((_e124.y * _e123.z)));
                                    let _e143 = (bitcast<u32>(_e133) & 2147483648u);
                                    let _e146 = bitcast<f32>((bitcast<u32>(fma(_e126.x, _e124.y, -((_e126.y * _e124.x)))) ^ _e143));
                                    let _e149 = bitcast<f32>((bitcast<u32>(fma(_e126.x, _e123.w, -((_e126.y * _e123.z)))) ^ _e143));
                                    let _e151 = (min(_e146, _e149) > 0.0);
                                    phi_195_ = _e151;
                                    if _e151 {
                                        phi_195_ = (max(_e146, _e149) < abs(_e133));
                                    }
                                    let _e156 = phi_195_;
                                    phi_151_ = _e115;
                                    phi_156_ = _e119;
                                    if _e156 {
                                        let _e159 = (_e115 * (_e149 / abs(_e133)));
                                        phi_151_ = _e159;
                                        phi_156_ = dot(_e159, _e159);
                                    }
                                    let _e162 = phi_151_;
                                    let _e164 = phi_156_;
                                    local_18 = _e162;
                                    local_19 = _e164;
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e393 = local_18;
                                    phi_150_ = _e393;
                                    phi_153_ = (_e117 + bitcast<u32>(1));
                                    let _e397 = local_19;
                                    phi_155_ = _e397;
                                }
                            }
                        } else {
                            phi_204_ = bitcast<i32>(_e49.y);
                            phi_205_ = _e36;
                            phi_206_ = _e38;
                            phi_207_ = true;
                            break;
                        }
                        let _e403 = local_20;
                        phi_202_ = _e403;
                        let _e406 = local_21;
                        phi_203_ = _e406;
                    }
                    let _e168 = phi_202_;
                    let _e170 = phi_203_;
                    phi_204_ = _e32.x;
                    phi_205_ = _e168;
                    phi_206_ = _e170;
                    phi_207_ = false;
                    break;
                }
            }
            let _e172 = phi_204_;
            let _e174 = phi_205_;
            let _e176 = phi_206_;
            let _e178 = phi_207_;
            switch bitcast<i32>(0u) {
                default: {
                    switch bitcast<i32>(0u) {
                        default: {
                            let _e188 = local_1;
                            let _e191 = local_2;
                            let _e192 = ((vec2<f32>(_e57.x, _e57.z) - _e188) * _e191);
                            let _e197 = local_3;
                            let _e200 = local_4;
                            let _e201 = ((vec2<f32>(_e57.y, _e57.w) - _e197) * _e200);
                            phi_231_ = _e192;
                            if (_e192.x > _e192.y) {
                                phi_231_ = _e192.yx;
                            }
                            let _e207 = phi_231_;
                            phi_238_ = _e201;
                            if (_e201.x > _e201.y) {
                                phi_238_ = _e201.yx;
                            }
                            let _e213 = phi_238_;
                            let _e220 = max(0.0, max(_e207.x, _e213.x));
                            let _e221 = (_e220 <= min(_e207.y, _e213.y));
                            phi_251_ = _e221;
                            if _e221 {
                                phi_251_ = ((_e220 * _e220) < _e174);
                            }
                            let _e225 = phi_251_;
                            if _e225 {
                                phi_254_ = _e220;
                                phi_255_ = true;
                                break;
                            }
                            phi_254_ = _e34.y;
                            phi_255_ = false;
                            break;
                        }
                    }
                    let _e227 = phi_254_;
                    let _e229 = phi_255_;
                    phi_322_ = _e174;
                    phi_323_ = _e176;
                    local_6 = _e227;
                    local_8 = _e227;
                    if _e229 {
                        let _e230 = bitcast<vec2<u32>>(_e49.zw);
                        if (_e230.x != 0u) {
                            phi_270_ = _e176;
                            phi_273_ = _e230.y;
                            phi_275_ = _e174;
                            loop {
                                let _e240 = phi_270_;
                                let _e242 = phi_273_;
                                let _e244 = phi_275_;
                                local_24 = _e244;
                                local_25 = _e240;
                                if (_e242 < (_e230.y + (_e230.x >> bitcast<u32>(1)))) {
                                    let _e248 = global.member[_e242];
                                    let _e249 = -(_e240);
                                    let _e251 = (_e21 - _e248.xy);
                                    let _e258 = fma(_e249.x, _e248.w, -((_e249.y * _e248.z)));
                                    let _e268 = (bitcast<u32>(_e258) & 2147483648u);
                                    let _e271 = bitcast<f32>((bitcast<u32>(fma(_e251.x, _e249.y, -((_e251.y * _e249.x)))) ^ _e268));
                                    let _e274 = bitcast<f32>((bitcast<u32>(fma(_e251.x, _e248.w, -((_e251.y * _e248.z)))) ^ _e268));
                                    let _e276 = (min(_e271, _e274) > 0.0);
                                    phi_315_ = _e276;
                                    if _e276 {
                                        phi_315_ = (max(_e271, _e274) < abs(_e258));
                                    }
                                    let _e281 = phi_315_;
                                    phi_271_ = _e240;
                                    phi_276_ = _e244;
                                    if _e281 {
                                        let _e284 = (_e240 * (_e274 / abs(_e258)));
                                        phi_271_ = _e284;
                                        phi_276_ = dot(_e284, _e284);
                                    }
                                    let _e287 = phi_271_;
                                    let _e289 = phi_276_;
                                    local_22 = _e287;
                                    local_23 = _e289;
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e422 = local_22;
                                    phi_270_ = _e422;
                                    phi_273_ = (_e242 + bitcast<u32>(1));
                                    let _e426 = local_23;
                                    phi_275_ = _e426;
                                }
                            }
                        } else {
                            phi_324_ = bitcast<i32>(_e49.w);
                            phi_64_ = _e174;
                            phi_66_ = _e176;
                            phi_325_ = true;
                            break;
                        }
                        let _e432 = local_24;
                        phi_322_ = _e432;
                        let _e435 = local_25;
                        phi_323_ = _e435;
                    }
                    let _e293 = phi_322_;
                    let _e295 = phi_323_;
                    phi_324_ = _e32.y;
                    phi_64_ = _e293;
                    phi_66_ = _e295;
                    phi_325_ = false;
                    break;
                }
            }
            let _e297 = phi_324_;
            let _e299 = phi_64_;
            let _e301 = phi_66_;
            let _e303 = phi_325_;
            let _e305 = local_5;
            let _e307 = local_6;
            let _e308 = vec2<f32>(_e305, _e307);
            let _e309 = vec2<i32>(_e172, _e297);
            local_13 = _e299;
            local_14 = _e301;
            if (_e178 && _e303) {
                let _e333 = local_7;
                let _e335 = local_8;
                phi_359_ = _e308;
                phi_360_ = _e309;
                if (_e333 < _e335) {
                    phi_359_ = _e308.yx;
                    phi_360_ = _e309.yx;
                }
                let _e340 = phi_359_;
                let _e342 = phi_360_;
                let _e343 = (_e30 + 1);
                local[_e343] = _e342.x;
                phi_57_ = _e343;
                phi_60_ = _e342;
                phi_62_ = _e340;
                phi_68_ = _e342.y;
                phi_72_ = _e44;
            } else {
                if _e178 {
                    phi_351_ = _e30;
                    phi_352_ = _e172;
                    phi_353_ = _e44;
                } else {
                    if _e303 {
                        phi_348_ = _e30;
                        phi_349_ = _e297;
                        phi_350_ = _e44;
                    } else {
                        let _e311 = (_e30 > 0);
                        if _e311 {
                            let _e314 = local[_e30];
                            phi_345_ = (_e30 - 1);
                            phi_346_ = _e314;
                        } else {
                            phi_345_ = _e30;
                            phi_346_ = _e40;
                        }
                        let _e316 = phi_345_;
                        let _e318 = phi_346_;
                        phi_348_ = _e316;
                        phi_349_ = _e318;
                        phi_350_ = select(true, _e44, _e311);
                    }
                    let _e321 = phi_348_;
                    let _e323 = phi_349_;
                    let _e325 = phi_350_;
                    phi_351_ = _e321;
                    phi_352_ = _e323;
                    phi_353_ = _e325;
                }
                let _e327 = phi_351_;
                let _e329 = phi_352_;
                let _e331 = phi_353_;
                phi_57_ = _e327;
                phi_60_ = _e309;
                phi_62_ = _e308;
                phi_68_ = _e329;
                phi_72_ = _e331;
            }
            let _e348 = phi_57_;
            let _e350 = phi_60_;
            let _e352 = phi_62_;
            let _e354 = phi_68_;
            let _e356 = phi_72_;
            local_10 = _e348;
            local_11 = _e350;
            local_12 = _e352;
            local_15 = _e354;
            local_17 = _e356;
            continue;
        } else {
            break;
        }
        continuing {
            let _e364 = local_10;
            phi_56_ = _e364;
            let _e367 = local_11;
            phi_59_ = _e367;
            let _e370 = local_12;
            phi_61_ = _e370;
            let _e373 = local_13;
            phi_63_ = _e373;
            let _e376 = local_14;
            phi_65_ = _e376;
            let _e379 = local_15;
            phi_67_ = _e379;
            let _e382 = local_16;
            phi_69_ = _e382;
            let _e385 = local_17;
            phi_71_ = _e385;
        }
    }
    let _e358 = local_9;
    let _e360 = (f32(_e358) * 0.03125);
    global_3 = vec4<f32>(_e360, _e360, _e360, 1.0);
    return;
}

@fragment 
fn main(@location(0) param: vec2<f32>) -> @location(0) vec4<f32> {
    global_1 = param;
    function();
    let _e3 = global_3;
    return _e3;
}
