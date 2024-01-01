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
    var phi_58_: i32;
    var phi_61_: vec2<i32>;
    var phi_63_: vec2<f32>;
    var phi_65_: u32;
    var phi_67_: f32;
    var phi_69_: vec2<f32>;
    var phi_71_: i32;
    var phi_73_: bool;
    var phi_113_: vec2<f32>;
    var phi_120_: vec2<f32>;
    var phi_133_: bool;
    var phi_136_: f32;
    var phi_137_: bool;
    var phi_152_: u32;
    var phi_193_: bool;
    var phi_200_: u32;
    var phi_201_: f32;
    var phi_202_: vec2<f32>;
    var phi_203_: u32;
    var phi_204_: f32;
    var phi_205_: vec2<f32>;
    var phi_206_: i32;
    var phi_207_: u32;
    var phi_208_: f32;
    var phi_209_: vec2<f32>;
    var phi_210_: bool;
    var local_1: vec2<f32>;
    var local_2: f32;
    var local_3: vec2<f32>;
    var local_4: f32;
    var phi_234_: vec2<f32>;
    var phi_241_: vec2<f32>;
    var phi_254_: bool;
    var phi_257_: f32;
    var phi_258_: bool;
    var phi_273_: u32;
    var phi_314_: bool;
    var phi_321_: u32;
    var phi_322_: f32;
    var phi_323_: vec2<f32>;
    var phi_324_: u32;
    var phi_325_: f32;
    var phi_326_: vec2<f32>;
    var phi_327_: i32;
    var phi_66_: u32;
    var phi_68_: f32;
    var phi_70_: vec2<f32>;
    var phi_328_: bool;
    var local_5: f32;
    var local_6: f32;
    var phi_351_: i32;
    var phi_352_: i32;
    var phi_354_: i32;
    var phi_355_: i32;
    var phi_356_: bool;
    var phi_357_: i32;
    var phi_358_: i32;
    var phi_359_: bool;
    var local_7: f32;
    var local_8: f32;
    var phi_365_: vec2<f32>;
    var phi_366_: vec2<i32>;
    var phi_59_: i32;
    var phi_62_: vec2<i32>;
    var phi_64_: vec2<f32>;
    var phi_72_: i32;
    var phi_74_: bool;
    var phi_371_: u32;
    var local_9: i32;
    var local_10: vec2<i32>;
    var local_11: vec2<f32>;
    var local_12: u32;
    var local_13: f32;
    var local_14: vec2<f32>;
    var local_15: i32;
    var local_16: bool;
    var local_17: u32;
    var local_18: f32;
    var local_19: vec2<f32>;
    var local_20: u32;
    var local_21: f32;
    var local_22: vec2<f32>;

    let _e20 = global_1;
    let _e22 = global_2.member;
    let _e23 = (_e20 - _e22);
    let _e24 = length(_e23);
    let _e26 = (_e23 / vec2(_e24));
    let _e29 = (vec2<f32>(1.0, 1.0) / _e26);
    phi_58_ = 0;
    phi_61_ = vec2<i32>();
    phi_63_ = vec2<f32>();
    phi_65_ = 4294967295u;
    phi_67_ = (_e24 * _e24);
    phi_69_ = (_e26 * _e24);
    phi_71_ = 0;
    phi_73_ = false;
    loop {
        let _e31 = phi_58_;
        let _e33 = phi_61_;
        let _e35 = phi_63_;
        let _e37 = phi_65_;
        let _e39 = phi_67_;
        let _e41 = phi_69_;
        let _e43 = phi_71_;
        let _e45 = phi_73_;
        phi_371_ = _e37;
        if !(_e45) {
            let _e49 = global.member[_e43];
            let _e53 = global.member[(_e43 + 1)];
            let _e57 = global.member[(_e43 + 2)];
            switch bitcast<i32>(0u) {
                default: {
                    switch bitcast<i32>(0u) {
                        default: {
                            let _e66 = _e22.xx;
                            let _e69 = ((vec2<f32>(_e53.x, _e53.z) - _e66) * _e29.x);
                            let _e73 = _e22.yy;
                            let _e76 = ((vec2<f32>(_e53.y, _e53.w) - _e73) * _e29.y);
                            phi_113_ = _e69;
                            local_1 = _e66;
                            local_2 = _e29.x;
                            local_3 = _e73;
                            local_4 = _e29.y;
                            if (_e69.x > _e69.y) {
                                phi_113_ = _e69.yx;
                            }
                            let _e82 = phi_113_;
                            phi_120_ = _e76;
                            if (_e76.x > _e76.y) {
                                phi_120_ = _e76.yx;
                            }
                            let _e88 = phi_120_;
                            let _e95 = max(0.0, max(_e82.x, _e88.x));
                            let _e96 = (_e95 <= min(_e82.y, _e88.y));
                            phi_133_ = _e96;
                            if _e96 {
                                phi_133_ = ((_e95 * _e95) < _e39);
                            }
                            let _e100 = phi_133_;
                            if _e100 {
                                phi_136_ = _e95;
                                phi_137_ = true;
                                break;
                            }
                            phi_136_ = _e35.x;
                            phi_137_ = false;
                            break;
                        }
                    }
                    let _e102 = phi_136_;
                    let _e104 = phi_137_;
                    phi_203_ = _e37;
                    phi_204_ = _e39;
                    phi_205_ = _e41;
                    local_5 = _e102;
                    local_7 = _e102;
                    if _e104 {
                        let _e105 = bitcast<vec2<u32>>(_e49.xy);
                        if (_e105.x != 0u) {
                            phi_152_ = _e105.y;
                            loop {
                                let _e115 = phi_152_;
                                phi_200_ = _e37;
                                phi_201_ = _e39;
                                phi_202_ = _e41;
                                if (_e115 < (_e105.y + (_e105.x >> bitcast<u32>(1)))) {
                                    let _e119 = global.member[_e115];
                                    let _e120 = -(_e41);
                                    let _e122 = (_e22 - _e119.xy);
                                    let _e129 = fma(_e120.x, _e119.w, -((_e120.y * _e119.z)));
                                    let _e139 = (bitcast<u32>(_e129) & 2147483648u);
                                    let _e142 = bitcast<f32>((bitcast<u32>(fma(_e122.x, _e120.y, -((_e122.y * _e120.x)))) ^ _e139));
                                    let _e145 = bitcast<f32>((bitcast<u32>(fma(_e122.x, _e119.w, -((_e122.y * _e119.z)))) ^ _e139));
                                    let _e147 = (min(_e142, _e145) >= 0.0);
                                    phi_193_ = _e147;
                                    if _e147 {
                                        phi_193_ = (max(_e142, _e145) <= abs(_e129));
                                    }
                                    let _e152 = phi_193_;
                                    if _e152 {
                                        let _e155 = (_e41 * (_e145 / abs(_e129)));
                                        phi_200_ = _e115;
                                        phi_201_ = dot(_e155, _e155);
                                        phi_202_ = _e155;
                                        break;
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    phi_152_ = (_e115 + bitcast<u32>(1));
                                }
                            }
                            let _e160 = phi_200_;
                            let _e162 = phi_201_;
                            let _e164 = phi_202_;
                            local_17 = _e160;
                            local_18 = _e162;
                            local_19 = _e164;
                        } else {
                            phi_206_ = bitcast<i32>(_e49.y);
                            phi_207_ = _e37;
                            phi_208_ = _e39;
                            phi_209_ = _e41;
                            phi_210_ = true;
                            break;
                        }
                        let _e415 = local_17;
                        phi_203_ = _e415;
                        let _e418 = local_18;
                        phi_204_ = _e418;
                        let _e421 = local_19;
                        phi_205_ = _e421;
                    }
                    let _e166 = phi_203_;
                    let _e168 = phi_204_;
                    let _e170 = phi_205_;
                    phi_206_ = _e33.x;
                    phi_207_ = _e166;
                    phi_208_ = _e168;
                    phi_209_ = _e170;
                    phi_210_ = false;
                    break;
                }
            }
            let _e172 = phi_206_;
            let _e174 = phi_207_;
            let _e176 = phi_208_;
            let _e178 = phi_209_;
            let _e180 = phi_210_;
            switch bitcast<i32>(0u) {
                default: {
                    switch bitcast<i32>(0u) {
                        default: {
                            let _e190 = local_1;
                            let _e193 = local_2;
                            let _e194 = ((vec2<f32>(_e57.x, _e57.z) - _e190) * _e193);
                            let _e199 = local_3;
                            let _e202 = local_4;
                            let _e203 = ((vec2<f32>(_e57.y, _e57.w) - _e199) * _e202);
                            phi_234_ = _e194;
                            if (_e194.x > _e194.y) {
                                phi_234_ = _e194.yx;
                            }
                            let _e209 = phi_234_;
                            phi_241_ = _e203;
                            if (_e203.x > _e203.y) {
                                phi_241_ = _e203.yx;
                            }
                            let _e215 = phi_241_;
                            let _e222 = max(0.0, max(_e209.x, _e215.x));
                            let _e223 = (_e222 <= min(_e209.y, _e215.y));
                            phi_254_ = _e223;
                            if _e223 {
                                phi_254_ = ((_e222 * _e222) < _e176);
                            }
                            let _e227 = phi_254_;
                            if _e227 {
                                phi_257_ = _e222;
                                phi_258_ = true;
                                break;
                            }
                            phi_257_ = _e35.y;
                            phi_258_ = false;
                            break;
                        }
                    }
                    let _e229 = phi_257_;
                    let _e231 = phi_258_;
                    phi_324_ = _e174;
                    phi_325_ = _e176;
                    phi_326_ = _e178;
                    local_6 = _e229;
                    local_8 = _e229;
                    if _e231 {
                        let _e232 = bitcast<vec2<u32>>(_e49.zw);
                        if (_e232.x != 0u) {
                            phi_273_ = _e232.y;
                            loop {
                                let _e242 = phi_273_;
                                phi_321_ = _e174;
                                phi_322_ = _e176;
                                phi_323_ = _e178;
                                if (_e242 < (_e232.y + (_e232.x >> bitcast<u32>(1)))) {
                                    let _e246 = global.member[_e242];
                                    let _e247 = -(_e178);
                                    let _e249 = (_e22 - _e246.xy);
                                    let _e256 = fma(_e247.x, _e246.w, -((_e247.y * _e246.z)));
                                    let _e266 = (bitcast<u32>(_e256) & 2147483648u);
                                    let _e269 = bitcast<f32>((bitcast<u32>(fma(_e249.x, _e247.y, -((_e249.y * _e247.x)))) ^ _e266));
                                    let _e272 = bitcast<f32>((bitcast<u32>(fma(_e249.x, _e246.w, -((_e249.y * _e246.z)))) ^ _e266));
                                    let _e274 = (min(_e269, _e272) >= 0.0);
                                    phi_314_ = _e274;
                                    if _e274 {
                                        phi_314_ = (max(_e269, _e272) <= abs(_e256));
                                    }
                                    let _e279 = phi_314_;
                                    if _e279 {
                                        let _e282 = (_e178 * (_e272 / abs(_e256)));
                                        phi_321_ = _e242;
                                        phi_322_ = dot(_e282, _e282);
                                        phi_323_ = _e282;
                                        break;
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    phi_273_ = (_e242 + bitcast<u32>(1));
                                }
                            }
                            let _e287 = phi_321_;
                            let _e289 = phi_322_;
                            let _e291 = phi_323_;
                            local_20 = _e287;
                            local_21 = _e289;
                            local_22 = _e291;
                        } else {
                            phi_327_ = bitcast<i32>(_e49.w);
                            phi_66_ = _e174;
                            phi_68_ = _e176;
                            phi_70_ = _e178;
                            phi_328_ = true;
                            break;
                        }
                        let _e443 = local_20;
                        phi_324_ = _e443;
                        let _e446 = local_21;
                        phi_325_ = _e446;
                        let _e449 = local_22;
                        phi_326_ = _e449;
                    }
                    let _e293 = phi_324_;
                    let _e295 = phi_325_;
                    let _e297 = phi_326_;
                    phi_327_ = _e33.y;
                    phi_66_ = _e293;
                    phi_68_ = _e295;
                    phi_70_ = _e297;
                    phi_328_ = false;
                    break;
                }
            }
            let _e299 = phi_327_;
            let _e301 = phi_66_;
            let _e303 = phi_68_;
            let _e305 = phi_70_;
            let _e307 = phi_328_;
            let _e309 = local_5;
            let _e311 = local_6;
            let _e312 = vec2<f32>(_e309, _e311);
            let _e313 = vec2<i32>(_e172, _e299);
            local_12 = _e301;
            local_13 = _e303;
            local_14 = _e305;
            if (_e301 != 4294967295u) {
                phi_371_ = _e301;
                break;
            }
            if (_e180 && _e307) {
                let _e338 = local_7;
                let _e340 = local_8;
                phi_365_ = _e312;
                phi_366_ = _e313;
                if (_e338 < _e340) {
                    phi_365_ = _e312.yx;
                    phi_366_ = _e313.yx;
                }
                let _e345 = phi_365_;
                let _e347 = phi_366_;
                let _e348 = (_e31 + 1);
                local[_e348] = _e347.x;
                phi_59_ = _e348;
                phi_62_ = _e347;
                phi_64_ = _e345;
                phi_72_ = _e347.y;
                phi_74_ = _e45;
            } else {
                if _e180 {
                    phi_357_ = _e31;
                    phi_358_ = _e172;
                    phi_359_ = _e45;
                } else {
                    if _e307 {
                        phi_354_ = _e31;
                        phi_355_ = _e299;
                        phi_356_ = _e45;
                    } else {
                        let _e316 = (_e31 > 0);
                        if _e316 {
                            let _e319 = local[_e31];
                            phi_351_ = (_e31 - 1);
                            phi_352_ = _e319;
                        } else {
                            phi_351_ = _e31;
                            phi_352_ = _e43;
                        }
                        let _e321 = phi_351_;
                        let _e323 = phi_352_;
                        phi_354_ = _e321;
                        phi_355_ = _e323;
                        phi_356_ = select(true, _e45, _e316);
                    }
                    let _e326 = phi_354_;
                    let _e328 = phi_355_;
                    let _e330 = phi_356_;
                    phi_357_ = _e326;
                    phi_358_ = _e328;
                    phi_359_ = _e330;
                }
                let _e332 = phi_357_;
                let _e334 = phi_358_;
                let _e336 = phi_359_;
                phi_59_ = _e332;
                phi_62_ = _e313;
                phi_64_ = _e312;
                phi_72_ = _e334;
                phi_74_ = _e336;
            }
            let _e353 = phi_59_;
            let _e355 = phi_62_;
            let _e357 = phi_64_;
            let _e359 = phi_72_;
            let _e361 = phi_74_;
            local_9 = _e353;
            local_10 = _e355;
            local_11 = _e357;
            local_15 = _e359;
            local_16 = _e361;
            continue;
        } else {
            break;
        }
        continuing {
            let _e381 = local_9;
            phi_58_ = _e381;
            let _e384 = local_10;
            phi_61_ = _e384;
            let _e387 = local_11;
            phi_63_ = _e387;
            let _e390 = local_12;
            phi_65_ = _e390;
            let _e393 = local_13;
            phi_67_ = _e393;
            let _e396 = local_14;
            phi_69_ = _e396;
            let _e399 = local_15;
            phi_71_ = _e399;
            let _e402 = local_16;
            phi_73_ = _e402;
        }
    }
    let _e363 = phi_371_;
    let _e374 = ((normalize(vec3<f32>(_e22.x, _e22.y, length(_e22))) * select(0.0, 1.0, (_e363 == 4294967295u))) * pow((_e24 + 1.0), -5.0));
    global_3 = vec4<f32>(_e374.x, _e374.y, _e374.z, 1.0);
    return;
}

@fragment 
fn main(@location(0) param: vec2<f32>) -> @location(0) vec4<f32> {
    global_1 = param;
    function();
    let _e3 = global_3;
    return _e3;
}
