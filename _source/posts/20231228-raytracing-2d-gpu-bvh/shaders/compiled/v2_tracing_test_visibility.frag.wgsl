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
    var phi_63_: u32;
    var phi_65_: f32;
    var phi_67_: vec2<f32>;
    var phi_69_: i32;
    var phi_71_: bool;
    var phi_111_: vec2<f32>;
    var phi_118_: vec2<f32>;
    var phi_131_: bool;
    var phi_134_: f32;
    var phi_135_: bool;
    var phi_150_: u32;
    var phi_191_: bool;
    var phi_198_: u32;
    var phi_199_: f32;
    var phi_200_: vec2<f32>;
    var phi_201_: u32;
    var phi_202_: f32;
    var phi_203_: vec2<f32>;
    var phi_204_: i32;
    var phi_205_: u32;
    var phi_206_: f32;
    var phi_207_: vec2<f32>;
    var phi_208_: bool;
    var local_1: vec2<f32>;
    var local_2: f32;
    var local_3: vec2<f32>;
    var local_4: f32;
    var phi_232_: vec2<f32>;
    var phi_239_: vec2<f32>;
    var phi_252_: bool;
    var phi_255_: f32;
    var phi_256_: bool;
    var phi_271_: u32;
    var phi_312_: bool;
    var phi_319_: u32;
    var phi_320_: f32;
    var phi_321_: vec2<f32>;
    var phi_322_: u32;
    var phi_323_: f32;
    var phi_324_: vec2<f32>;
    var phi_325_: i32;
    var phi_64_: u32;
    var phi_66_: f32;
    var phi_68_: vec2<f32>;
    var phi_326_: bool;
    var local_5: f32;
    var local_6: f32;
    var phi_349_: i32;
    var phi_350_: i32;
    var phi_352_: i32;
    var phi_353_: i32;
    var phi_354_: bool;
    var phi_355_: i32;
    var phi_356_: i32;
    var phi_357_: bool;
    var local_7: f32;
    var local_8: f32;
    var phi_363_: vec2<f32>;
    var phi_364_: vec2<i32>;
    var phi_57_: i32;
    var phi_60_: vec2<i32>;
    var phi_62_: vec2<f32>;
    var phi_70_: i32;
    var phi_72_: bool;
    var phi_369_: u32;
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

    let _e19 = global_1;
    let _e21 = global_2.member;
    let _e22 = (_e19 - _e21);
    let _e23 = length(_e22);
    let _e25 = (_e22 / vec2(_e23));
    let _e28 = (vec2<f32>(1.0, 1.0) / _e25);
    phi_56_ = 0;
    phi_59_ = vec2<i32>();
    phi_61_ = vec2<f32>();
    phi_63_ = 4294967295u;
    phi_65_ = (_e23 * _e23);
    phi_67_ = (_e25 * _e23);
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
        phi_369_ = _e36;
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
                                phi_131_ = ((_e94 * _e94) < _e38);
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
                    phi_201_ = _e36;
                    phi_202_ = _e38;
                    phi_203_ = _e40;
                    local_5 = _e101;
                    local_7 = _e101;
                    if _e103 {
                        let _e104 = bitcast<vec2<u32>>(_e48.xy);
                        if (_e104.x != 0u) {
                            phi_150_ = _e104.y;
                            loop {
                                let _e114 = phi_150_;
                                phi_198_ = _e36;
                                phi_199_ = _e38;
                                phi_200_ = _e40;
                                if (_e114 < (_e104.y + (_e104.x >> bitcast<u32>(1)))) {
                                    let _e118 = global.member[_e114];
                                    let _e119 = -(_e40);
                                    let _e121 = (_e21 - _e118.xy);
                                    let _e128 = fma(_e119.x, _e118.w, -((_e119.y * _e118.z)));
                                    let _e138 = (bitcast<u32>(_e128) & 2147483648u);
                                    let _e141 = bitcast<f32>((bitcast<u32>(fma(_e121.x, _e119.y, -((_e121.y * _e119.x)))) ^ _e138));
                                    let _e144 = bitcast<f32>((bitcast<u32>(fma(_e121.x, _e118.w, -((_e121.y * _e118.z)))) ^ _e138));
                                    let _e146 = (min(_e141, _e144) > 0.0);
                                    phi_191_ = _e146;
                                    if _e146 {
                                        phi_191_ = (max(_e141, _e144) < abs(_e128));
                                    }
                                    let _e151 = phi_191_;
                                    if _e151 {
                                        let _e154 = (_e40 * (_e144 / abs(_e128)));
                                        phi_198_ = _e114;
                                        phi_199_ = dot(_e154, _e154);
                                        phi_200_ = _e154;
                                        break;
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    phi_150_ = (_e114 + bitcast<u32>(1));
                                }
                            }
                            let _e159 = phi_198_;
                            let _e161 = phi_199_;
                            let _e163 = phi_200_;
                            local_17 = _e159;
                            local_18 = _e161;
                            local_19 = _e163;
                        } else {
                            phi_204_ = bitcast<i32>(_e48.y);
                            phi_205_ = _e36;
                            phi_206_ = _e38;
                            phi_207_ = _e40;
                            phi_208_ = true;
                            break;
                        }
                        let _e402 = local_17;
                        phi_201_ = _e402;
                        let _e405 = local_18;
                        phi_202_ = _e405;
                        let _e408 = local_19;
                        phi_203_ = _e408;
                    }
                    let _e165 = phi_201_;
                    let _e167 = phi_202_;
                    let _e169 = phi_203_;
                    phi_204_ = _e32.x;
                    phi_205_ = _e165;
                    phi_206_ = _e167;
                    phi_207_ = _e169;
                    phi_208_ = false;
                    break;
                }
            }
            let _e171 = phi_204_;
            let _e173 = phi_205_;
            let _e175 = phi_206_;
            let _e177 = phi_207_;
            let _e179 = phi_208_;
            switch bitcast<i32>(0u) {
                default: {
                    switch bitcast<i32>(0u) {
                        default: {
                            let _e189 = local_1;
                            let _e192 = local_2;
                            let _e193 = ((vec2<f32>(_e56.x, _e56.z) - _e189) * _e192);
                            let _e198 = local_3;
                            let _e201 = local_4;
                            let _e202 = ((vec2<f32>(_e56.y, _e56.w) - _e198) * _e201);
                            phi_232_ = _e193;
                            if (_e193.x > _e193.y) {
                                phi_232_ = _e193.yx;
                            }
                            let _e208 = phi_232_;
                            phi_239_ = _e202;
                            if (_e202.x > _e202.y) {
                                phi_239_ = _e202.yx;
                            }
                            let _e214 = phi_239_;
                            let _e221 = max(0.0, max(_e208.x, _e214.x));
                            let _e222 = (_e221 <= min(_e208.y, _e214.y));
                            phi_252_ = _e222;
                            if _e222 {
                                phi_252_ = ((_e221 * _e221) < _e175);
                            }
                            let _e226 = phi_252_;
                            if _e226 {
                                phi_255_ = _e221;
                                phi_256_ = true;
                                break;
                            }
                            phi_255_ = _e34.y;
                            phi_256_ = false;
                            break;
                        }
                    }
                    let _e228 = phi_255_;
                    let _e230 = phi_256_;
                    phi_322_ = _e173;
                    phi_323_ = _e175;
                    phi_324_ = _e177;
                    local_6 = _e228;
                    local_8 = _e228;
                    if _e230 {
                        let _e231 = bitcast<vec2<u32>>(_e48.zw);
                        if (_e231.x != 0u) {
                            phi_271_ = _e231.y;
                            loop {
                                let _e241 = phi_271_;
                                phi_319_ = _e173;
                                phi_320_ = _e175;
                                phi_321_ = _e177;
                                if (_e241 < (_e231.y + (_e231.x >> bitcast<u32>(1)))) {
                                    let _e245 = global.member[_e241];
                                    let _e246 = -(_e177);
                                    let _e248 = (_e21 - _e245.xy);
                                    let _e255 = fma(_e246.x, _e245.w, -((_e246.y * _e245.z)));
                                    let _e265 = (bitcast<u32>(_e255) & 2147483648u);
                                    let _e268 = bitcast<f32>((bitcast<u32>(fma(_e248.x, _e246.y, -((_e248.y * _e246.x)))) ^ _e265));
                                    let _e271 = bitcast<f32>((bitcast<u32>(fma(_e248.x, _e245.w, -((_e248.y * _e245.z)))) ^ _e265));
                                    let _e273 = (min(_e268, _e271) > 0.0);
                                    phi_312_ = _e273;
                                    if _e273 {
                                        phi_312_ = (max(_e268, _e271) < abs(_e255));
                                    }
                                    let _e278 = phi_312_;
                                    if _e278 {
                                        let _e281 = (_e177 * (_e271 / abs(_e255)));
                                        phi_319_ = _e241;
                                        phi_320_ = dot(_e281, _e281);
                                        phi_321_ = _e281;
                                        break;
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    phi_271_ = (_e241 + bitcast<u32>(1));
                                }
                            }
                            let _e286 = phi_319_;
                            let _e288 = phi_320_;
                            let _e290 = phi_321_;
                            local_20 = _e286;
                            local_21 = _e288;
                            local_22 = _e290;
                        } else {
                            phi_325_ = bitcast<i32>(_e48.w);
                            phi_64_ = _e173;
                            phi_66_ = _e175;
                            phi_68_ = _e177;
                            phi_326_ = true;
                            break;
                        }
                        let _e430 = local_20;
                        phi_322_ = _e430;
                        let _e433 = local_21;
                        phi_323_ = _e433;
                        let _e436 = local_22;
                        phi_324_ = _e436;
                    }
                    let _e292 = phi_322_;
                    let _e294 = phi_323_;
                    let _e296 = phi_324_;
                    phi_325_ = _e32.y;
                    phi_64_ = _e292;
                    phi_66_ = _e294;
                    phi_68_ = _e296;
                    phi_326_ = false;
                    break;
                }
            }
            let _e298 = phi_325_;
            let _e300 = phi_64_;
            let _e302 = phi_66_;
            let _e304 = phi_68_;
            let _e306 = phi_326_;
            let _e308 = local_5;
            let _e310 = local_6;
            let _e311 = vec2<f32>(_e308, _e310);
            let _e312 = vec2<i32>(_e171, _e298);
            local_12 = _e300;
            local_13 = _e302;
            local_14 = _e304;
            if (_e300 != 4294967295u) {
                phi_369_ = _e300;
                break;
            }
            if (_e179 && _e306) {
                let _e337 = local_7;
                let _e339 = local_8;
                phi_363_ = _e311;
                phi_364_ = _e312;
                if (_e337 < _e339) {
                    phi_363_ = _e311.yx;
                    phi_364_ = _e312.yx;
                }
                let _e344 = phi_363_;
                let _e346 = phi_364_;
                let _e347 = (_e30 + 1);
                local[_e347] = _e346.x;
                phi_57_ = _e347;
                phi_60_ = _e346;
                phi_62_ = _e344;
                phi_70_ = _e346.y;
                phi_72_ = _e44;
            } else {
                if _e179 {
                    phi_355_ = _e30;
                    phi_356_ = _e171;
                    phi_357_ = _e44;
                } else {
                    if _e306 {
                        phi_352_ = _e30;
                        phi_353_ = _e298;
                        phi_354_ = _e44;
                    } else {
                        let _e315 = (_e30 > 0);
                        if _e315 {
                            let _e318 = local[_e30];
                            phi_349_ = (_e30 - 1);
                            phi_350_ = _e318;
                        } else {
                            phi_349_ = _e30;
                            phi_350_ = _e42;
                        }
                        let _e320 = phi_349_;
                        let _e322 = phi_350_;
                        phi_352_ = _e320;
                        phi_353_ = _e322;
                        phi_354_ = select(true, _e44, _e315);
                    }
                    let _e325 = phi_352_;
                    let _e327 = phi_353_;
                    let _e329 = phi_354_;
                    phi_355_ = _e325;
                    phi_356_ = _e327;
                    phi_357_ = _e329;
                }
                let _e331 = phi_355_;
                let _e333 = phi_356_;
                let _e335 = phi_357_;
                phi_57_ = _e331;
                phi_60_ = _e312;
                phi_62_ = _e311;
                phi_70_ = _e333;
                phi_72_ = _e335;
            }
            let _e352 = phi_57_;
            let _e354 = phi_60_;
            let _e356 = phi_62_;
            let _e358 = phi_70_;
            let _e360 = phi_72_;
            local_9 = _e352;
            local_10 = _e354;
            local_11 = _e356;
            local_15 = _e358;
            local_16 = _e360;
            continue;
        } else {
            break;
        }
        continuing {
            let _e368 = local_9;
            phi_56_ = _e368;
            let _e371 = local_10;
            phi_59_ = _e371;
            let _e374 = local_11;
            phi_61_ = _e374;
            let _e377 = local_12;
            phi_63_ = _e377;
            let _e380 = local_13;
            phi_65_ = _e380;
            let _e383 = local_14;
            phi_67_ = _e383;
            let _e386 = local_15;
            phi_69_ = _e386;
            let _e389 = local_16;
            phi_71_ = _e389;
        }
    }
    let _e362 = phi_369_;
    let _e364 = select(0.0, 1.0, (_e362 == 4294967295u));
    global_3 = vec4<f32>(_e364, _e364, _e364, 1.0);
    return;
}

@fragment 
fn main(@location(0) param: vec2<f32>) -> @location(0) vec4<f32> {
    global_1 = param;
    function();
    let _e3 = global_3;
    return _e3;
}
