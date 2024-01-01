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
    var phi_152_: vec2<f32>;
    var phi_155_: u32;
    var phi_157_: f32;
    var phi_197_: bool;
    var phi_153_: vec2<f32>;
    var phi_158_: f32;
    var phi_204_: f32;
    var phi_205_: vec2<f32>;
    var phi_206_: i32;
    var phi_207_: i32;
    var phi_208_: f32;
    var phi_209_: vec2<f32>;
    var phi_210_: i32;
    var phi_211_: bool;
    var local_1: vec2<f32>;
    var local_2: f32;
    var local_3: vec2<f32>;
    var local_4: f32;
    var phi_235_: vec2<f32>;
    var phi_242_: vec2<f32>;
    var phi_255_: bool;
    var phi_258_: f32;
    var phi_259_: bool;
    var phi_276_: vec2<f32>;
    var phi_279_: u32;
    var phi_281_: f32;
    var phi_321_: bool;
    var phi_277_: vec2<f32>;
    var phi_282_: f32;
    var phi_328_: f32;
    var phi_329_: vec2<f32>;
    var phi_330_: i32;
    var phi_331_: i32;
    var phi_64_: f32;
    var phi_66_: vec2<f32>;
    var phi_68_: i32;
    var phi_332_: bool;
    var local_5: f32;
    var local_6: f32;
    var phi_352_: i32;
    var phi_353_: i32;
    var phi_355_: i32;
    var phi_356_: i32;
    var phi_357_: bool;
    var phi_358_: i32;
    var phi_359_: i32;
    var phi_360_: bool;
    var local_7: f32;
    var local_8: f32;
    var phi_366_: vec2<f32>;
    var phi_367_: vec2<i32>;
    var phi_57_: i32;
    var phi_60_: vec2<i32>;
    var phi_62_: vec2<f32>;
    var phi_70_: i32;
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
    var local_22: i32;
    var local_23: vec2<f32>;
    var local_24: f32;
    var local_25: f32;
    var local_26: vec2<f32>;
    var local_27: i32;

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
        local_9 = _e40;
        if !(_e44) {
            let _e48 = global.member[_e42];
            let _e52 = global.member[(_e42 + 1)];
            let _e56 = global.member[(_e42 + 2)];
            switch bitcast<i32>(0u) {
                default: {
                    switch bitcast<i32>(0u) {
                        default: {
                            let _e65 = _e21.xx;
                            let _e68 = ((vec2<f32>(_e52.x, _e52.z) - _e65) * _e28.x);
                            let _e72 = _e21.yy;
                            let _e75 = ((vec2<f32>(_e52.y, _e52.w) - _e72) * _e28.y);
                            phi_111_ = _e68;
                            local_1 = _e65;
                            local_2 = _e28.x;
                            local_3 = _e72;
                            local_4 = _e28.y;
                            if (_e68.x > _e68.y) {
                                phi_111_ = _e68.yx;
                            }
                            let _e81 = phi_111_;
                            phi_118_ = _e75;
                            if (_e75.x > _e75.y) {
                                phi_118_ = _e75.yx;
                            }
                            let _e87 = phi_118_;
                            let _e94 = max(0.0, max(_e81.x, _e87.x));
                            let _e95 = (_e94 <= min(_e81.y, _e87.y));
                            phi_131_ = _e95;
                            if _e95 {
                                phi_131_ = ((_e94 * _e94) < _e36);
                            }
                            let _e99 = phi_131_;
                            if _e99 {
                                phi_134_ = _e94;
                                phi_135_ = true;
                                break;
                            }
                            phi_134_ = _e34.x;
                            phi_135_ = false;
                            break;
                        }
                    }
                    let _e101 = phi_134_;
                    let _e103 = phi_135_;
                    phi_204_ = _e36;
                    phi_205_ = _e38;
                    phi_206_ = _e40;
                    local_5 = _e101;
                    local_7 = _e101;
                    if _e103 {
                        let _e104 = bitcast<vec2<u32>>(_e48.xy);
                        if (_e104.x != 0u) {
                            let _e110 = (_e104.x >> bitcast<u32>(1));
                            phi_152_ = _e38;
                            phi_155_ = _e104.y;
                            phi_157_ = _e36;
                            local_22 = (_e40 + bitcast<i32>(_e110));
                            loop {
                                let _e116 = phi_152_;
                                let _e118 = phi_155_;
                                let _e120 = phi_157_;
                                local_20 = _e120;
                                local_21 = _e116;
                                if (_e118 < (_e104.y + _e110)) {
                                    let _e124 = global.member[_e118];
                                    let _e125 = -(_e116);
                                    let _e127 = (_e21 - _e124.xy);
                                    let _e134 = fma(_e125.x, _e124.w, -((_e125.y * _e124.z)));
                                    let _e144 = (bitcast<u32>(_e134) & 2147483648u);
                                    let _e147 = bitcast<f32>((bitcast<u32>(fma(_e127.x, _e125.y, -((_e127.y * _e125.x)))) ^ _e144));
                                    let _e150 = bitcast<f32>((bitcast<u32>(fma(_e127.x, _e124.w, -((_e127.y * _e124.z)))) ^ _e144));
                                    let _e152 = (min(_e147, _e150) >= 0.0);
                                    phi_197_ = _e152;
                                    if _e152 {
                                        phi_197_ = (max(_e147, _e150) <= abs(_e134));
                                    }
                                    let _e157 = phi_197_;
                                    phi_153_ = _e116;
                                    phi_158_ = _e120;
                                    if _e157 {
                                        let _e160 = (_e116 * (_e150 / abs(_e134)));
                                        phi_153_ = _e160;
                                        phi_158_ = dot(_e160, _e160);
                                    }
                                    let _e163 = phi_153_;
                                    let _e165 = phi_158_;
                                    local_18 = _e163;
                                    local_19 = _e165;
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e404 = local_18;
                                    phi_152_ = _e404;
                                    phi_155_ = (_e118 + bitcast<u32>(1));
                                    let _e408 = local_19;
                                    phi_157_ = _e408;
                                }
                            }
                        } else {
                            phi_207_ = bitcast<i32>(_e48.y);
                            phi_208_ = _e36;
                            phi_209_ = _e38;
                            phi_210_ = _e40;
                            phi_211_ = true;
                            break;
                        }
                        let _e414 = local_20;
                        phi_204_ = _e414;
                        let _e417 = local_21;
                        phi_205_ = _e417;
                        let _e420 = local_22;
                        phi_206_ = _e420;
                    }
                    let _e169 = phi_204_;
                    let _e171 = phi_205_;
                    let _e173 = phi_206_;
                    phi_207_ = _e32.x;
                    phi_208_ = _e169;
                    phi_209_ = _e171;
                    phi_210_ = _e173;
                    phi_211_ = false;
                    break;
                }
            }
            let _e175 = phi_207_;
            let _e177 = phi_208_;
            let _e179 = phi_209_;
            let _e181 = phi_210_;
            let _e183 = phi_211_;
            switch bitcast<i32>(0u) {
                default: {
                    switch bitcast<i32>(0u) {
                        default: {
                            let _e193 = local_1;
                            let _e196 = local_2;
                            let _e197 = ((vec2<f32>(_e56.x, _e56.z) - _e193) * _e196);
                            let _e202 = local_3;
                            let _e205 = local_4;
                            let _e206 = ((vec2<f32>(_e56.y, _e56.w) - _e202) * _e205);
                            phi_235_ = _e197;
                            if (_e197.x > _e197.y) {
                                phi_235_ = _e197.yx;
                            }
                            let _e212 = phi_235_;
                            phi_242_ = _e206;
                            if (_e206.x > _e206.y) {
                                phi_242_ = _e206.yx;
                            }
                            let _e218 = phi_242_;
                            let _e225 = max(0.0, max(_e212.x, _e218.x));
                            let _e226 = (_e225 <= min(_e212.y, _e218.y));
                            phi_255_ = _e226;
                            if _e226 {
                                phi_255_ = ((_e225 * _e225) < _e177);
                            }
                            let _e230 = phi_255_;
                            if _e230 {
                                phi_258_ = _e225;
                                phi_259_ = true;
                                break;
                            }
                            phi_258_ = _e34.y;
                            phi_259_ = false;
                            break;
                        }
                    }
                    let _e232 = phi_258_;
                    let _e234 = phi_259_;
                    phi_328_ = _e177;
                    phi_329_ = _e179;
                    phi_330_ = _e181;
                    local_6 = _e232;
                    local_8 = _e232;
                    if _e234 {
                        let _e235 = bitcast<vec2<u32>>(_e48.zw);
                        if (_e235.x != 0u) {
                            let _e241 = (_e235.x >> bitcast<u32>(1));
                            phi_276_ = _e179;
                            phi_279_ = _e235.y;
                            phi_281_ = _e177;
                            local_27 = (_e181 + bitcast<i32>(_e241));
                            loop {
                                let _e247 = phi_276_;
                                let _e249 = phi_279_;
                                let _e251 = phi_281_;
                                local_25 = _e251;
                                local_26 = _e247;
                                if (_e249 < (_e235.y + _e241)) {
                                    let _e255 = global.member[_e249];
                                    let _e256 = -(_e247);
                                    let _e258 = (_e21 - _e255.xy);
                                    let _e265 = fma(_e256.x, _e255.w, -((_e256.y * _e255.z)));
                                    let _e275 = (bitcast<u32>(_e265) & 2147483648u);
                                    let _e278 = bitcast<f32>((bitcast<u32>(fma(_e258.x, _e256.y, -((_e258.y * _e256.x)))) ^ _e275));
                                    let _e281 = bitcast<f32>((bitcast<u32>(fma(_e258.x, _e255.w, -((_e258.y * _e255.z)))) ^ _e275));
                                    let _e283 = (min(_e278, _e281) >= 0.0);
                                    phi_321_ = _e283;
                                    if _e283 {
                                        phi_321_ = (max(_e278, _e281) <= abs(_e265));
                                    }
                                    let _e288 = phi_321_;
                                    phi_277_ = _e247;
                                    phi_282_ = _e251;
                                    if _e288 {
                                        let _e291 = (_e247 * (_e281 / abs(_e265)));
                                        phi_277_ = _e291;
                                        phi_282_ = dot(_e291, _e291);
                                    }
                                    let _e294 = phi_277_;
                                    let _e296 = phi_282_;
                                    local_23 = _e294;
                                    local_24 = _e296;
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e437 = local_23;
                                    phi_276_ = _e437;
                                    phi_279_ = (_e249 + bitcast<u32>(1));
                                    let _e441 = local_24;
                                    phi_281_ = _e441;
                                }
                            }
                        } else {
                            phi_331_ = bitcast<i32>(_e48.w);
                            phi_64_ = _e177;
                            phi_66_ = _e179;
                            phi_68_ = _e181;
                            phi_332_ = true;
                            break;
                        }
                        let _e447 = local_25;
                        phi_328_ = _e447;
                        let _e450 = local_26;
                        phi_329_ = _e450;
                        let _e453 = local_27;
                        phi_330_ = _e453;
                    }
                    let _e300 = phi_328_;
                    let _e302 = phi_329_;
                    let _e304 = phi_330_;
                    phi_331_ = _e32.y;
                    phi_64_ = _e300;
                    phi_66_ = _e302;
                    phi_68_ = _e304;
                    phi_332_ = false;
                    break;
                }
            }
            let _e306 = phi_331_;
            let _e308 = phi_64_;
            let _e310 = phi_66_;
            let _e312 = phi_68_;
            let _e314 = phi_332_;
            let _e316 = local_5;
            let _e318 = local_6;
            let _e319 = vec2<f32>(_e316, _e318);
            let _e320 = vec2<i32>(_e175, _e306);
            local_13 = _e308;
            local_14 = _e310;
            local_15 = _e312;
            if (_e183 && _e314) {
                let _e344 = local_7;
                let _e346 = local_8;
                phi_366_ = _e319;
                phi_367_ = _e320;
                if (_e344 < _e346) {
                    phi_366_ = _e319.yx;
                    phi_367_ = _e320.yx;
                }
                let _e351 = phi_366_;
                let _e353 = phi_367_;
                let _e354 = (_e30 + 1);
                local[_e354] = _e353.x;
                phi_57_ = _e354;
                phi_60_ = _e353;
                phi_62_ = _e351;
                phi_70_ = _e353.y;
                phi_72_ = _e44;
            } else {
                if _e183 {
                    phi_358_ = _e30;
                    phi_359_ = _e175;
                    phi_360_ = _e44;
                } else {
                    if _e314 {
                        phi_355_ = _e30;
                        phi_356_ = _e306;
                        phi_357_ = _e44;
                    } else {
                        let _e322 = (_e30 > 0);
                        if _e322 {
                            let _e325 = local[_e30];
                            phi_352_ = (_e30 - 1);
                            phi_353_ = _e325;
                        } else {
                            phi_352_ = _e30;
                            phi_353_ = _e42;
                        }
                        let _e327 = phi_352_;
                        let _e329 = phi_353_;
                        phi_355_ = _e327;
                        phi_356_ = _e329;
                        phi_357_ = select(true, _e44, _e322);
                    }
                    let _e332 = phi_355_;
                    let _e334 = phi_356_;
                    let _e336 = phi_357_;
                    phi_358_ = _e332;
                    phi_359_ = _e334;
                    phi_360_ = _e336;
                }
                let _e338 = phi_358_;
                let _e340 = phi_359_;
                let _e342 = phi_360_;
                phi_57_ = _e338;
                phi_60_ = _e320;
                phi_62_ = _e319;
                phi_70_ = _e340;
                phi_72_ = _e342;
            }
            let _e359 = phi_57_;
            let _e361 = phi_60_;
            let _e363 = phi_62_;
            let _e365 = phi_70_;
            let _e367 = phi_72_;
            local_10 = _e359;
            local_11 = _e361;
            local_12 = _e363;
            local_16 = _e365;
            local_17 = _e367;
            continue;
        } else {
            break;
        }
        continuing {
            let _e375 = local_10;
            phi_56_ = _e375;
            let _e378 = local_11;
            phi_59_ = _e378;
            let _e381 = local_12;
            phi_61_ = _e381;
            let _e384 = local_13;
            phi_63_ = _e384;
            let _e387 = local_14;
            phi_65_ = _e387;
            let _e390 = local_15;
            phi_67_ = _e390;
            let _e393 = local_16;
            phi_69_ = _e393;
            let _e396 = local_17;
            phi_71_ = _e396;
        }
    }
    let _e369 = local_9;
    let _e371 = (f32(_e369) * 0.015625);
    global_3 = vec4<f32>(_e371, _e371, _e371, 1.0);
    return;
}

@fragment 
fn main(@location(0) param: vec2<f32>) -> @location(0) vec4<f32> {
    global_1 = param;
    function();
    let _e3 = global_3;
    return _e3;
}
