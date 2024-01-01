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
    var phi_73_: i32;
    var phi_75_: i32;
    var phi_77_: bool;
    var phi_117_: vec2<f32>;
    var phi_124_: vec2<f32>;
    var phi_137_: bool;
    var phi_140_: f32;
    var phi_141_: bool;
    var phi_158_: vec2<f32>;
    var phi_161_: u32;
    var phi_163_: u32;
    var phi_165_: f32;
    var phi_205_: bool;
    var phi_159_: vec2<f32>;
    var phi_166_: f32;
    var phi_212_: u32;
    var phi_213_: f32;
    var phi_214_: vec2<f32>;
    var phi_215_: i32;
    var phi_216_: i32;
    var phi_217_: u32;
    var phi_218_: f32;
    var phi_219_: vec2<f32>;
    var phi_220_: i32;
    var phi_221_: bool;
    var local_1: vec2<f32>;
    var local_2: f32;
    var local_3: vec2<f32>;
    var local_4: f32;
    var phi_245_: vec2<f32>;
    var phi_252_: vec2<f32>;
    var phi_265_: bool;
    var phi_268_: f32;
    var phi_269_: bool;
    var phi_286_: vec2<f32>;
    var phi_289_: u32;
    var phi_291_: u32;
    var phi_293_: f32;
    var phi_333_: bool;
    var phi_287_: vec2<f32>;
    var phi_294_: f32;
    var phi_340_: u32;
    var phi_341_: f32;
    var phi_342_: vec2<f32>;
    var phi_343_: i32;
    var phi_344_: i32;
    var phi_66_: u32;
    var phi_68_: f32;
    var phi_70_: vec2<f32>;
    var phi_72_: i32;
    var phi_345_: bool;
    var local_5: f32;
    var local_6: f32;
    var phi_365_: i32;
    var phi_366_: i32;
    var phi_368_: i32;
    var phi_369_: i32;
    var phi_370_: bool;
    var phi_371_: i32;
    var phi_372_: i32;
    var phi_373_: bool;
    var local_7: f32;
    var local_8: f32;
    var phi_379_: vec2<f32>;
    var phi_380_: vec2<i32>;
    var phi_59_: i32;
    var phi_62_: vec2<i32>;
    var phi_64_: vec2<f32>;
    var phi_74_: i32;
    var phi_78_: bool;
    var local_9: u32;
    var local_10: i32;
    var local_11: i32;
    var local_12: i32;
    var local_13: vec2<i32>;
    var local_14: vec2<f32>;
    var local_15: u32;
    var local_16: f32;
    var local_17: vec2<f32>;
    var local_18: i32;
    var local_19: i32;
    var local_20: i32;
    var local_21: bool;
    var local_22: vec2<f32>;
    var local_23: u32;
    var local_24: f32;
    var local_25: u32;
    var local_26: f32;
    var local_27: vec2<f32>;
    var local_28: i32;
    var local_29: vec2<f32>;
    var local_30: u32;
    var local_31: f32;
    var local_32: u32;
    var local_33: f32;
    var local_34: vec2<f32>;
    var local_35: i32;

    let _e21 = global_1;
    let _e23 = global_2.member;
    let _e24 = (_e21 - _e23);
    let _e25 = length(_e24);
    let _e27 = (_e24 / vec2(_e25));
    let _e30 = (vec2<f32>(1.0, 1.0) / _e27);
    phi_58_ = 0;
    phi_61_ = vec2<i32>();
    phi_63_ = vec2<f32>();
    phi_65_ = 4294967295u;
    phi_67_ = (_e25 * _e25);
    phi_69_ = (_e27 * _e25);
    phi_71_ = 0;
    phi_73_ = 0;
    phi_75_ = 0;
    phi_77_ = false;
    loop {
        let _e32 = phi_58_;
        let _e34 = phi_61_;
        let _e36 = phi_63_;
        let _e38 = phi_65_;
        let _e40 = phi_67_;
        let _e42 = phi_69_;
        let _e44 = phi_71_;
        let _e46 = phi_73_;
        let _e48 = phi_75_;
        let _e50 = phi_77_;
        local_9 = _e38;
        local_10 = _e48;
        local_11 = _e44;
        if !(_e50) {
            let _e55 = global.member[_e46];
            let _e59 = global.member[(_e46 + 1)];
            let _e63 = global.member[(_e46 + 2)];
            local_20 = (_e48 + 1);
            switch bitcast<i32>(0u) {
                default: {
                    switch bitcast<i32>(0u) {
                        default: {
                            let _e72 = _e23.xx;
                            let _e75 = ((vec2<f32>(_e59.x, _e59.z) - _e72) * _e30.x);
                            let _e79 = _e23.yy;
                            let _e82 = ((vec2<f32>(_e59.y, _e59.w) - _e79) * _e30.y);
                            phi_117_ = _e75;
                            local_1 = _e72;
                            local_2 = _e30.x;
                            local_3 = _e79;
                            local_4 = _e30.y;
                            if (_e75.x > _e75.y) {
                                phi_117_ = _e75.yx;
                            }
                            let _e88 = phi_117_;
                            phi_124_ = _e82;
                            if (_e82.x > _e82.y) {
                                phi_124_ = _e82.yx;
                            }
                            let _e94 = phi_124_;
                            let _e101 = max(0.0, max(_e88.x, _e94.x));
                            let _e102 = (_e101 <= min(_e88.y, _e94.y));
                            phi_137_ = _e102;
                            if _e102 {
                                phi_137_ = ((_e101 * _e101) < _e40);
                            }
                            let _e106 = phi_137_;
                            if _e106 {
                                phi_140_ = _e101;
                                phi_141_ = true;
                                break;
                            }
                            phi_140_ = _e36.x;
                            phi_141_ = false;
                            break;
                        }
                    }
                    let _e108 = phi_140_;
                    let _e110 = phi_141_;
                    phi_212_ = _e38;
                    phi_213_ = _e40;
                    phi_214_ = _e42;
                    phi_215_ = _e44;
                    local_5 = _e108;
                    local_7 = _e108;
                    if _e110 {
                        let _e111 = bitcast<vec2<u32>>(_e55.xy);
                        if (_e111.x != 0u) {
                            let _e117 = (_e111.x >> bitcast<u32>(1));
                            phi_158_ = _e42;
                            phi_161_ = _e111.y;
                            phi_163_ = _e38;
                            phi_165_ = _e40;
                            local_28 = (_e44 + bitcast<i32>(_e117));
                            loop {
                                let _e123 = phi_158_;
                                let _e125 = phi_161_;
                                let _e127 = phi_163_;
                                let _e129 = phi_165_;
                                local_25 = _e127;
                                local_26 = _e129;
                                local_27 = _e123;
                                if (_e125 < (_e111.y + _e117)) {
                                    let _e133 = global.member[_e125];
                                    let _e134 = -(_e123);
                                    let _e136 = (_e23 - _e133.xy);
                                    let _e143 = fma(_e134.x, _e133.w, -((_e134.y * _e133.z)));
                                    let _e153 = (bitcast<u32>(_e143) & 2147483648u);
                                    let _e156 = bitcast<f32>((bitcast<u32>(fma(_e136.x, _e134.y, -((_e136.y * _e134.x)))) ^ _e153));
                                    let _e159 = bitcast<f32>((bitcast<u32>(fma(_e136.x, _e133.w, -((_e136.y * _e133.z)))) ^ _e153));
                                    let _e161 = (min(_e156, _e159) >= 0.0);
                                    phi_205_ = _e161;
                                    if _e161 {
                                        phi_205_ = (max(_e156, _e159) <= abs(_e143));
                                    }
                                    let _e166 = phi_205_;
                                    phi_159_ = _e123;
                                    phi_166_ = _e129;
                                    if _e166 {
                                        let _e169 = (_e123 * (_e159 / abs(_e143)));
                                        phi_159_ = _e169;
                                        phi_166_ = dot(_e169, _e169);
                                    }
                                    let _e172 = phi_159_;
                                    let _e174 = phi_166_;
                                    local_22 = _e172;
                                    local_23 = select(_e127, _e125, _e166);
                                    local_24 = _e174;
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e439 = local_22;
                                    phi_158_ = _e439;
                                    phi_161_ = (_e125 + bitcast<u32>(1));
                                    let _e443 = local_23;
                                    phi_163_ = _e443;
                                    let _e446 = local_24;
                                    phi_165_ = _e446;
                                }
                            }
                        } else {
                            phi_216_ = bitcast<i32>(_e55.y);
                            phi_217_ = _e38;
                            phi_218_ = _e40;
                            phi_219_ = _e42;
                            phi_220_ = _e44;
                            phi_221_ = true;
                            break;
                        }
                        let _e452 = local_25;
                        phi_212_ = _e452;
                        let _e455 = local_26;
                        phi_213_ = _e455;
                        let _e458 = local_27;
                        phi_214_ = _e458;
                        let _e461 = local_28;
                        phi_215_ = _e461;
                    }
                    let _e179 = phi_212_;
                    let _e181 = phi_213_;
                    let _e183 = phi_214_;
                    let _e185 = phi_215_;
                    phi_216_ = _e34.x;
                    phi_217_ = _e179;
                    phi_218_ = _e181;
                    phi_219_ = _e183;
                    phi_220_ = _e185;
                    phi_221_ = false;
                    break;
                }
            }
            let _e187 = phi_216_;
            let _e189 = phi_217_;
            let _e191 = phi_218_;
            let _e193 = phi_219_;
            let _e195 = phi_220_;
            let _e197 = phi_221_;
            switch bitcast<i32>(0u) {
                default: {
                    switch bitcast<i32>(0u) {
                        default: {
                            let _e207 = local_1;
                            let _e210 = local_2;
                            let _e211 = ((vec2<f32>(_e63.x, _e63.z) - _e207) * _e210);
                            let _e216 = local_3;
                            let _e219 = local_4;
                            let _e220 = ((vec2<f32>(_e63.y, _e63.w) - _e216) * _e219);
                            phi_245_ = _e211;
                            if (_e211.x > _e211.y) {
                                phi_245_ = _e211.yx;
                            }
                            let _e226 = phi_245_;
                            phi_252_ = _e220;
                            if (_e220.x > _e220.y) {
                                phi_252_ = _e220.yx;
                            }
                            let _e232 = phi_252_;
                            let _e239 = max(0.0, max(_e226.x, _e232.x));
                            let _e240 = (_e239 <= min(_e226.y, _e232.y));
                            phi_265_ = _e240;
                            if _e240 {
                                phi_265_ = ((_e239 * _e239) < _e191);
                            }
                            let _e244 = phi_265_;
                            if _e244 {
                                phi_268_ = _e239;
                                phi_269_ = true;
                                break;
                            }
                            phi_268_ = _e36.y;
                            phi_269_ = false;
                            break;
                        }
                    }
                    let _e246 = phi_268_;
                    let _e248 = phi_269_;
                    phi_340_ = _e189;
                    phi_341_ = _e191;
                    phi_342_ = _e193;
                    phi_343_ = _e195;
                    local_6 = _e246;
                    local_8 = _e246;
                    if _e248 {
                        let _e249 = bitcast<vec2<u32>>(_e55.zw);
                        if (_e249.x != 0u) {
                            let _e255 = (_e249.x >> bitcast<u32>(1));
                            phi_286_ = _e193;
                            phi_289_ = _e249.y;
                            phi_291_ = _e189;
                            phi_293_ = _e191;
                            local_35 = (_e195 + bitcast<i32>(_e255));
                            loop {
                                let _e261 = phi_286_;
                                let _e263 = phi_289_;
                                let _e265 = phi_291_;
                                let _e267 = phi_293_;
                                local_32 = _e265;
                                local_33 = _e267;
                                local_34 = _e261;
                                if (_e263 < (_e249.y + _e255)) {
                                    let _e271 = global.member[_e263];
                                    let _e272 = -(_e261);
                                    let _e274 = (_e23 - _e271.xy);
                                    let _e281 = fma(_e272.x, _e271.w, -((_e272.y * _e271.z)));
                                    let _e291 = (bitcast<u32>(_e281) & 2147483648u);
                                    let _e294 = bitcast<f32>((bitcast<u32>(fma(_e274.x, _e272.y, -((_e274.y * _e272.x)))) ^ _e291));
                                    let _e297 = bitcast<f32>((bitcast<u32>(fma(_e274.x, _e271.w, -((_e274.y * _e271.z)))) ^ _e291));
                                    let _e299 = (min(_e294, _e297) >= 0.0);
                                    phi_333_ = _e299;
                                    if _e299 {
                                        phi_333_ = (max(_e294, _e297) <= abs(_e281));
                                    }
                                    let _e304 = phi_333_;
                                    phi_287_ = _e261;
                                    phi_294_ = _e267;
                                    if _e304 {
                                        let _e307 = (_e261 * (_e297 / abs(_e281)));
                                        phi_287_ = _e307;
                                        phi_294_ = dot(_e307, _e307);
                                    }
                                    let _e310 = phi_287_;
                                    let _e312 = phi_294_;
                                    local_29 = _e310;
                                    local_30 = select(_e265, _e263, _e304);
                                    local_31 = _e312;
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e479 = local_29;
                                    phi_286_ = _e479;
                                    phi_289_ = (_e263 + bitcast<u32>(1));
                                    let _e483 = local_30;
                                    phi_291_ = _e483;
                                    let _e486 = local_31;
                                    phi_293_ = _e486;
                                }
                            }
                        } else {
                            phi_344_ = bitcast<i32>(_e55.w);
                            phi_66_ = _e189;
                            phi_68_ = _e191;
                            phi_70_ = _e193;
                            phi_72_ = _e195;
                            phi_345_ = true;
                            break;
                        }
                        let _e492 = local_32;
                        phi_340_ = _e492;
                        let _e495 = local_33;
                        phi_341_ = _e495;
                        let _e498 = local_34;
                        phi_342_ = _e498;
                        let _e501 = local_35;
                        phi_343_ = _e501;
                    }
                    let _e317 = phi_340_;
                    let _e319 = phi_341_;
                    let _e321 = phi_342_;
                    let _e323 = phi_343_;
                    phi_344_ = _e34.y;
                    phi_66_ = _e317;
                    phi_68_ = _e319;
                    phi_70_ = _e321;
                    phi_72_ = _e323;
                    phi_345_ = false;
                    break;
                }
            }
            let _e325 = phi_344_;
            let _e327 = phi_66_;
            let _e329 = phi_68_;
            let _e331 = phi_70_;
            let _e333 = phi_72_;
            let _e335 = phi_345_;
            let _e337 = local_5;
            let _e339 = local_6;
            let _e340 = vec2<f32>(_e337, _e339);
            let _e341 = vec2<i32>(_e187, _e325);
            local_15 = _e327;
            local_16 = _e329;
            local_17 = _e331;
            local_18 = _e333;
            if (_e197 && _e335) {
                let _e365 = local_7;
                let _e367 = local_8;
                phi_379_ = _e340;
                phi_380_ = _e341;
                if (_e365 < _e367) {
                    phi_379_ = _e340.yx;
                    phi_380_ = _e341.yx;
                }
                let _e372 = phi_379_;
                let _e374 = phi_380_;
                let _e375 = (_e32 + 1);
                local[_e375] = _e374.x;
                phi_59_ = _e375;
                phi_62_ = _e374;
                phi_64_ = _e372;
                phi_74_ = _e374.y;
                phi_78_ = _e50;
            } else {
                if _e197 {
                    phi_371_ = _e32;
                    phi_372_ = _e187;
                    phi_373_ = _e50;
                } else {
                    if _e335 {
                        phi_368_ = _e32;
                        phi_369_ = _e325;
                        phi_370_ = _e50;
                    } else {
                        let _e343 = (_e32 > 0);
                        if _e343 {
                            let _e346 = local[_e32];
                            phi_365_ = (_e32 - 1);
                            phi_366_ = _e346;
                        } else {
                            phi_365_ = _e32;
                            phi_366_ = _e46;
                        }
                        let _e348 = phi_365_;
                        let _e350 = phi_366_;
                        phi_368_ = _e348;
                        phi_369_ = _e350;
                        phi_370_ = select(true, _e50, _e343);
                    }
                    let _e353 = phi_368_;
                    let _e355 = phi_369_;
                    let _e357 = phi_370_;
                    phi_371_ = _e353;
                    phi_372_ = _e355;
                    phi_373_ = _e357;
                }
                let _e359 = phi_371_;
                let _e361 = phi_372_;
                let _e363 = phi_373_;
                phi_59_ = _e359;
                phi_62_ = _e341;
                phi_64_ = _e340;
                phi_74_ = _e361;
                phi_78_ = _e363;
            }
            let _e380 = phi_59_;
            let _e382 = phi_62_;
            let _e384 = phi_64_;
            let _e386 = phi_74_;
            let _e388 = phi_78_;
            local_12 = _e380;
            local_13 = _e382;
            local_14 = _e384;
            local_19 = _e386;
            local_21 = _e388;
            continue;
        } else {
            break;
        }
        continuing {
            let _e404 = local_12;
            phi_58_ = _e404;
            let _e407 = local_13;
            phi_61_ = _e407;
            let _e410 = local_14;
            phi_63_ = _e410;
            let _e413 = local_15;
            phi_65_ = _e413;
            let _e416 = local_16;
            phi_67_ = _e416;
            let _e419 = local_17;
            phi_69_ = _e419;
            let _e422 = local_18;
            phi_71_ = _e422;
            let _e425 = local_19;
            phi_73_ = _e425;
            let _e428 = local_20;
            phi_75_ = _e428;
            let _e431 = local_21;
            phi_77_ = _e431;
        }
    }
    let _e390 = local_9;
    let _e394 = local_10;
    let _e398 = local_11;
    global_3 = vec4<f32>((f32(_e394) * 0.03125), (f32(_e398) * 0.015625), select(0.0, 1.0, (_e390 == 4294967295u)), 1.0);
    return;
}

@fragment 
fn main(@location(0) param: vec2<f32>) -> @location(0) vec4<f32> {
    global_1 = param;
    function();
    let _e3 = global_3;
    return _e3;
}
