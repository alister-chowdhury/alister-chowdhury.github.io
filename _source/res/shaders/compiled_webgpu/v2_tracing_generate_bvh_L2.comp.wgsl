struct type_3 {
    member: u32,
    member_1: u32,
    member_2: vec4<f32>,
    member_3: u32,
}

struct type_9 {
    member: array<vec4<f32>>,
}

struct type_13 {
    member: u32,
}

@group(0) @binding(1) 
var<storage, read_write> global: type_9;
var<workgroup> global_1: array<type_3, 16>;
var<workgroup> global_2: array<type_3, 4>;
var<private> global_3: vec3<u32>;
@group(0) @binding(2) 
var<uniform> global_4: type_13;
@group(0) @binding(0) 
var<storage, read_write> global_5: type_9;
var<workgroup> global_6: array<u32, 16>;

fn function() {
    var phi_116_: u32;
    var phi_119_: u32;
    var phi_121_: vec4<f32>;
    var phi_123_: u32;
    var phi_125_: u32;
    var phi_146_: bool;
    var phi_117_: u32;
    var phi_120_: u32;
    var phi_122_: vec4<f32>;
    var phi_124_: u32;
    var local: u32;
    var phi_173_: u32;
    var phi_176_: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: vec4<f32>;
    var local_4: u32;
    var phi_187_: u32;
    var phi_190_: u32;
    var local_5: u32;
    var phi_209_: bool;
    var phi_188_: u32;
    var phi_379_: u32;
    var phi_380_: u32;
    var phi_381_: vec4<f32>;
    var phi_382_: u32;
    var phi_414_: u32;
    var phi_415_: u32;
    var phi_416_: vec4<f32>;
    var phi_417_: u32;
    var phi_450_: u32;
    var phi_451_: u32;
    var phi_452_: vec4<f32>;
    var phi_453_: u32;
    var phi_612_: u32;
    var phi_613_: u32;
    var phi_614_: vec4<f32>;
    var phi_615_: u32;
    var phi_647_: u32;
    var phi_648_: u32;
    var phi_649_: vec4<f32>;
    var phi_650_: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: vec4<f32>;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;

    let _e45 = global_3;
    let _e46 = _e45.xy;
    let _e51 = (_e45.x | (_e45.y << bitcast<u32>(16)));
    let _e55 = ((_e51 | (_e51 << bitcast<u32>(4))) & 252645135u);
    let _e59 = ((_e55 | (_e55 << bitcast<u32>(2))) & 858993459u);
    let _e63 = ((_e59 | (_e59 << bitcast<u32>(1))) & 1431655765u);
    let _e67 = ((_e63 | (_e63 >> bitcast<u32>(15))) & 65535u);
    let _e68 = vec2<f32>(_e46);
    let _e70 = vec2<f32>((_e46 + vec2<u32>(1u, 1u)));
    let _e76 = (vec4<f32>(_e68.x, _e68.y, _e70.x, _e70.y) * vec4<f32>(0.33333334, 0.33333334, 0.33333334, 0.33333334));
    phi_116_ = 0u;
    phi_119_ = 0u;
    phi_121_ = vec4<f32>(1.0, 1.0, -1.0, -1.0);
    phi_123_ = 0u;
    phi_125_ = 0u;
    loop {
        let _e78 = phi_116_;
        let _e80 = phi_119_;
        let _e82 = phi_121_;
        let _e84 = phi_123_;
        let _e86 = phi_125_;
        let _e88 = global_4.member;
        local = _e84;
        local_1 = _e84;
        local_3 = _e82;
        local_4 = _e84;
        local_12 = _e80;
        local_5 = _e78;
        if (_e86 < _e88) {
            let _e92 = global_5.member[_e86];
            let _e93 = _e92.xy;
            let _e94 = _e92.zw;
            let _e96 = ((_e93 + _e94) * 0.5);
            let _e99 = all((_e96 >= _e76.xy));
            phi_146_ = _e99;
            if _e99 {
                phi_146_ = all((_e96 < _e76.zw));
            }
            let _e104 = phi_146_;
            phi_117_ = _e78;
            phi_120_ = _e80;
            phi_122_ = _e82;
            phi_124_ = _e84;
            if _e104 {
                let _e108 = min(_e93, _e94);
                let _e109 = max(_e93, _e94);
                let _e114 = vec4<f32>(_e108.x, _e108.y, _e109.x, _e109.y);
                let _e117 = min(_e82.xy, _e114.xy);
                let _e120 = max(_e82.zw, _e114.zw);
                phi_117_ = (_e86 + 1u);
                phi_120_ = select(_e80, _e86, (_e84 == 0u));
                phi_122_ = vec4<f32>(_e117.x, _e117.y, _e120.x, _e120.y);
                phi_124_ = (_e84 + bitcast<u32>(1));
            }
            let _e129 = phi_117_;
            let _e131 = phi_120_;
            let _e133 = phi_122_;
            let _e135 = phi_124_;
            local_6 = _e129;
            local_7 = _e131;
            local_8 = _e133;
            local_9 = _e135;
            continue;
        } else {
            break;
        }
        continuing {
            let _e651 = local_6;
            phi_116_ = _e651;
            let _e654 = local_7;
            phi_119_ = _e654;
            let _e657 = local_8;
            phi_121_ = _e657;
            let _e660 = local_9;
            phi_123_ = _e660;
            phi_125_ = (_e86 + bitcast<u32>(1));
        }
    }
    let _e140 = local;
    global_6[_e67] = _e140;
    workgroupBarrier();
    phi_173_ = 45u;
    phi_176_ = 0u;
    loop {
        let _e142 = phi_173_;
        let _e144 = phi_176_;
        local_2 = _e142;
        local_10 = _e142;
        if (_e144 < _e67) {
            continue;
        } else {
            break;
        }
        continuing {
            let _e147 = global_6[_e144];
            phi_173_ = (_e142 + _e147);
            phi_176_ = (_e144 + bitcast<u32>(1));
        }
    }
    let _e152 = local_1;
    let _e156 = local_2;
    let _e159 = local_3;
    let _e161 = local_4;
    global_1[_e67] = type_3(1u, (_e156 | (_e152 << bitcast<u32>(24))), _e159, _e161);
    workgroupBarrier();
    let _e676 = local_10;
    phi_187_ = _e676;
    let _e681 = local_12;
    phi_190_ = _e681;
    loop {
        let _e165 = phi_187_;
        let _e167 = phi_190_;
        let _e169 = local_5;
        if (_e167 < _e169) {
            let _e173 = global_5.member[_e167];
            let _e174 = _e173.xy;
            let _e175 = _e173.zw;
            let _e177 = ((_e174 + _e175) * 0.5);
            let _e180 = all((_e177 >= _e76.xy));
            phi_209_ = _e180;
            if _e180 {
                phi_209_ = all((_e177 < _e76.zw));
            }
            let _e185 = phi_209_;
            phi_188_ = _e165;
            if _e185 {
                let _e188 = (_e174 - _e175);
                global.member[_e165] = vec4<f32>(_e173.x, _e173.y, _e188.x, _e188.y);
                phi_188_ = (_e165 + bitcast<u32>(1));
            }
            let _e197 = phi_188_;
            local_11 = _e197;
            continue;
        } else {
            break;
        }
        continuing {
            let _e678 = local_11;
            phi_187_ = _e678;
            phi_190_ = (_e167 + bitcast<u32>(1));
        }
    }
    if all((_e46 < vec2<u32>(2u, 2u))) {
        let _e204 = (_e46 * vec2<u32>(2u, 2u));
        let _e209 = (_e204 + vec2<u32>(1u, 0u));
        let _e214 = (_e204 + vec2<u32>(0u, 1u));
        let _e219 = (_e204 + vec2<u32>(1u, 1u));
        let _e225 = global_1[((_e204.y * 4u) + _e204.x)];
        let _e231 = global_1[((_e209.y * 4u) + _e209.x)];
        let _e237 = global_1[((_e214.y * 4u) + _e214.x)];
        let _e243 = global_1[((_e219.y * 4u) + _e219.x)];
        let _e248 = (9u * _e67);
        let _e249 = (9u + _e248);
        let _e250 = _e225.member_2.xy;
        let _e251 = _e231.member_2.xy;
        let _e252 = min(_e250, _e251);
        let _e253 = _e225.member_2.zw;
        let _e254 = _e231.member_2.zw;
        let _e255 = max(_e253, _e254);
        let _e260 = vec4<f32>(_e252.x, _e252.y, _e255.x, _e255.y);
        let _e263 = (_e260.zw - _e260.xy);
        let _e268 = _e237.member_2.xy;
        let _e269 = min(_e250, _e268);
        let _e270 = _e237.member_2.zw;
        let _e271 = max(_e253, _e270);
        let _e276 = vec4<f32>(_e269.x, _e269.y, _e271.x, _e271.y);
        let _e279 = (_e276.zw - _e276.xy);
        let _e284 = _e243.member_2.xy;
        let _e285 = min(_e268, _e284);
        let _e286 = _e243.member_2.zw;
        let _e287 = max(_e270, _e286);
        let _e292 = vec4<f32>(_e285.x, _e285.y, _e287.x, _e287.y);
        let _e295 = (_e292.zw - _e292.xy);
        let _e300 = min(_e251, _e284);
        let _e301 = max(_e254, _e286);
        let _e306 = vec4<f32>(_e300.x, _e300.y, _e301.x, _e301.y);
        let _e309 = (_e306.zw - _e306.xy);
        let _e316 = ((max(0.0, (_e263.x * _e263.y)) + max(0.0, (_e295.x * _e295.y))) > (max(0.0, (_e279.x * _e279.y)) + max(0.0, (_e309.x * _e309.y))));
        let _e317 = select(_e237.member, _e231.member, _e316);
        let _e318 = select(_e237.member_1, _e231.member_1, _e316);
        let _e319 = vec4(_e316);
        let _e320 = select(_e237.member_2, _e231.member_2, _e319);
        let _e321 = select(_e237.member_3, _e231.member_3, _e316);
        let _e322 = select(_e231.member, _e237.member, _e316);
        let _e323 = select(_e231.member_1, _e237.member_1, _e316);
        let _e324 = select(_e231.member_2, _e237.member_2, _e319);
        let _e325 = select(_e231.member_3, _e237.member_3, _e316);
        let _e326 = (_e248 + 12u);
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e326] = bitcast<vec4<f32>>(vec4<u32>(_e225.member, _e225.member_1, _e322, _e323));
                let _e333 = (_e225.member_3 == 0u);
                global.member[(_e248 + 13u)] = select(_e225.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e333));
                let _e339 = (_e325 == 0u);
                global.member[(_e248 + 14u)] = select(_e324, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e339));
                if _e339 {
                    phi_379_ = _e225.member;
                    phi_380_ = _e225.member_1;
                    phi_381_ = _e225.member_2;
                    phi_382_ = _e225.member_3;
                    break;
                } else {
                    if _e333 {
                        phi_379_ = _e322;
                        phi_380_ = _e323;
                        phi_381_ = _e324;
                        phi_382_ = _e325;
                        break;
                    }
                }
                let _e346 = min(_e250, _e324.xy);
                let _e348 = max(_e253, _e324.zw);
                phi_379_ = 0u;
                phi_380_ = _e326;
                phi_381_ = vec4<f32>(_e346.x, _e346.y, _e348.x, _e348.y);
                phi_382_ = (_e225.member_3 + _e325);
                break;
            }
        }
        let _e355 = phi_379_;
        let _e357 = phi_380_;
        let _e359 = phi_381_;
        let _e361 = phi_382_;
        let _e362 = (_e248 + 15u);
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e362] = bitcast<vec4<f32>>(vec4<u32>(_e317, _e318, _e243.member, _e243.member_1));
                let _e369 = (_e321 == 0u);
                global.member[(_e248 + 16u)] = select(_e320, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e369));
                let _e375 = (_e243.member_3 == 0u);
                global.member[(_e248 + 17u)] = select(_e243.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e375));
                if _e375 {
                    phi_414_ = _e317;
                    phi_415_ = _e318;
                    phi_416_ = _e320;
                    phi_417_ = _e321;
                    break;
                } else {
                    if _e369 {
                        phi_414_ = _e243.member;
                        phi_415_ = _e243.member_1;
                        phi_416_ = _e243.member_2;
                        phi_417_ = _e243.member_3;
                        break;
                    }
                }
                let _e382 = min(_e320.xy, _e284);
                let _e384 = max(_e320.zw, _e286);
                phi_414_ = 0u;
                phi_415_ = _e362;
                phi_416_ = vec4<f32>(_e382.x, _e382.y, _e384.x, _e384.y);
                phi_417_ = (_e321 + _e243.member_3);
                break;
            }
        }
        let _e391 = phi_414_;
        let _e393 = phi_415_;
        let _e395 = phi_416_;
        let _e397 = phi_417_;
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e249] = bitcast<vec4<f32>>(vec4<u32>(_e355, _e357, _e391, _e393));
                let _e404 = (_e361 == 0u);
                global.member[(_e248 + 10u)] = select(_e359, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e404));
                let _e410 = (_e397 == 0u);
                global.member[(_e248 + 11u)] = select(_e395, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e410));
                if _e410 {
                    phi_450_ = _e355;
                    phi_451_ = _e357;
                    phi_452_ = _e359;
                    phi_453_ = _e361;
                    break;
                } else {
                    if _e404 {
                        phi_450_ = _e391;
                        phi_451_ = _e393;
                        phi_452_ = _e395;
                        phi_453_ = _e397;
                        break;
                    }
                }
                let _e418 = min(_e359.xy, _e395.xy);
                let _e421 = max(_e359.zw, _e395.zw);
                phi_450_ = 0u;
                phi_451_ = _e249;
                phi_452_ = vec4<f32>(_e418.x, _e418.y, _e421.x, _e421.y);
                phi_453_ = (_e361 + _e397);
                break;
            }
        }
        let _e428 = phi_450_;
        let _e430 = phi_451_;
        let _e432 = phi_452_;
        let _e434 = phi_453_;
        global_2[((_e45.y * 2u) + _e45.x)] = type_3(_e428, _e430, _e432, _e434);
    }
    if all((_e46 < vec2<u32>(1u, 1u))) {
        let _e439 = (_e46 * vec2<u32>(2u, 2u));
        let _e444 = (_e439 + vec2<u32>(1u, 0u));
        let _e449 = (_e439 + vec2<u32>(0u, 1u));
        let _e454 = (_e439 + vec2<u32>(1u, 1u));
        let _e460 = global_2[((_e439.y * 2u) + _e439.x)];
        let _e466 = global_2[((_e444.y * 2u) + _e444.x)];
        let _e472 = global_2[((_e449.y * 2u) + _e449.x)];
        let _e478 = global_2[((_e454.y * 2u) + _e454.x)];
        let _e483 = (9u * _e67);
        let _e484 = _e460.member_2.xy;
        let _e485 = _e466.member_2.xy;
        let _e486 = min(_e484, _e485);
        let _e487 = _e460.member_2.zw;
        let _e488 = _e466.member_2.zw;
        let _e489 = max(_e487, _e488);
        let _e494 = vec4<f32>(_e486.x, _e486.y, _e489.x, _e489.y);
        let _e497 = (_e494.zw - _e494.xy);
        let _e502 = _e472.member_2.xy;
        let _e503 = min(_e484, _e502);
        let _e504 = _e472.member_2.zw;
        let _e505 = max(_e487, _e504);
        let _e510 = vec4<f32>(_e503.x, _e503.y, _e505.x, _e505.y);
        let _e513 = (_e510.zw - _e510.xy);
        let _e518 = _e478.member_2.xy;
        let _e519 = min(_e502, _e518);
        let _e520 = _e478.member_2.zw;
        let _e521 = max(_e504, _e520);
        let _e526 = vec4<f32>(_e519.x, _e519.y, _e521.x, _e521.y);
        let _e529 = (_e526.zw - _e526.xy);
        let _e534 = min(_e485, _e518);
        let _e535 = max(_e488, _e520);
        let _e540 = vec4<f32>(_e534.x, _e534.y, _e535.x, _e535.y);
        let _e543 = (_e540.zw - _e540.xy);
        let _e550 = ((max(0.0, (_e497.x * _e497.y)) + max(0.0, (_e529.x * _e529.y))) > (max(0.0, (_e513.x * _e513.y)) + max(0.0, (_e543.x * _e543.y))));
        let _e551 = select(_e472.member, _e466.member, _e550);
        let _e552 = select(_e472.member_1, _e466.member_1, _e550);
        let _e553 = vec4(_e550);
        let _e554 = select(_e472.member_2, _e466.member_2, _e553);
        let _e555 = select(_e472.member_3, _e466.member_3, _e550);
        let _e556 = select(_e466.member, _e472.member, _e550);
        let _e557 = select(_e466.member_1, _e472.member_1, _e550);
        let _e558 = select(_e466.member_2, _e472.member_2, _e553);
        let _e559 = select(_e466.member_3, _e472.member_3, _e550);
        let _e560 = (_e483 + 3u);
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e560] = bitcast<vec4<f32>>(vec4<u32>(_e460.member, _e460.member_1, _e556, _e557));
                let _e567 = (_e460.member_3 == 0u);
                global.member[(_e483 + 4u)] = select(_e460.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e567));
                let _e573 = (_e559 == 0u);
                global.member[(_e483 + 5u)] = select(_e558, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e573));
                if _e573 {
                    phi_612_ = _e460.member;
                    phi_613_ = _e460.member_1;
                    phi_614_ = _e460.member_2;
                    phi_615_ = _e460.member_3;
                    break;
                } else {
                    if _e567 {
                        phi_612_ = _e556;
                        phi_613_ = _e557;
                        phi_614_ = _e558;
                        phi_615_ = _e559;
                        break;
                    }
                }
                let _e580 = min(_e484, _e558.xy);
                let _e582 = max(_e487, _e558.zw);
                phi_612_ = 0u;
                phi_613_ = _e560;
                phi_614_ = vec4<f32>(_e580.x, _e580.y, _e582.x, _e582.y);
                phi_615_ = (_e460.member_3 + _e559);
                break;
            }
        }
        let _e589 = phi_612_;
        let _e591 = phi_613_;
        let _e593 = phi_614_;
        let _e595 = phi_615_;
        let _e596 = (_e483 + 6u);
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e596] = bitcast<vec4<f32>>(vec4<u32>(_e551, _e552, _e478.member, _e478.member_1));
                let _e603 = (_e555 == 0u);
                global.member[(_e483 + 7u)] = select(_e554, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e603));
                let _e609 = (_e478.member_3 == 0u);
                global.member[(_e483 + 8u)] = select(_e478.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e609));
                if _e609 {
                    phi_647_ = _e551;
                    phi_648_ = _e552;
                    phi_649_ = _e554;
                    phi_650_ = _e555;
                    break;
                } else {
                    if _e603 {
                        phi_647_ = _e478.member;
                        phi_648_ = _e478.member_1;
                        phi_649_ = _e478.member_2;
                        phi_650_ = _e478.member_3;
                        break;
                    }
                }
                let _e616 = min(_e554.xy, _e518);
                let _e618 = max(_e554.zw, _e520);
                phi_647_ = 0u;
                phi_648_ = _e596;
                phi_649_ = vec4<f32>(_e616.x, _e616.y, _e618.x, _e618.y);
                phi_650_ = (_e555 + _e478.member_3);
                break;
            }
        }
        let _e625 = phi_647_;
        let _e627 = phi_648_;
        let _e629 = phi_649_;
        let _e631 = phi_650_;
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e483] = bitcast<vec4<f32>>(vec4<u32>(_e589, _e591, _e625, _e627));
                let _e638 = (_e595 == 0u);
                global.member[(_e483 + 1u)] = select(_e593, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e638));
                let _e644 = (_e631 == 0u);
                global.member[(_e483 + 2u)] = select(_e629, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e644));
                if _e644 {
                    break;
                } else {
                    if _e638 {
                        break;
                    }
                }
                break;
            }
        }
    }
    workgroupBarrier();
    return;
}

@compute @workgroup_size(4, 4, 1) 
fn main(@builtin(local_invocation_id) param: vec3<u32>) {
    global_3 = param;
    function();
}
