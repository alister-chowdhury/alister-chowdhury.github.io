struct type_3 {
    member: u32,
    member_1: u32,
    member_2: vec4<f32>,
    member_3: u32,
}

struct type_10 {
    member: array<vec4<f32>>,
}

struct type_20 {
    member: u32,
}

@group(0) @binding(1) 
var<storage, read_write> global: type_10;
var<workgroup> global_1: array<type_3, 4>;
var<private> global_2: vec3<u32>;
@group(0) @binding(2) 
var<uniform> global_3: type_20;
@group(0) @binding(0) 
var<storage> global_4: type_10;
var<workgroup> global_5: array<u32, 4>;

fn function() {
    var phi_108_: u32;
    var phi_111_: u32;
    var phi_113_: vec4<f32>;
    var phi_115_: u32;
    var phi_117_: u32;
    var phi_138_: bool;
    var phi_109_: u32;
    var phi_112_: u32;
    var phi_114_: vec4<f32>;
    var phi_116_: u32;
    var local: u32;
    var phi_165_: u32;
    var phi_168_: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: vec4<f32>;
    var local_4: u32;
    var phi_181_: u32;
    var phi_184_: u32;
    var local_5: u32;
    var phi_203_: bool;
    var phi_182_: u32;
    var phi_309_: u32;
    var phi_310_: vec4<f32>;
    var phi_428_: u32;
    var phi_429_: u32;
    var phi_430_: vec4<f32>;
    var phi_431_: u32;
    var phi_463_: u32;
    var phi_464_: u32;
    var phi_465_: vec4<f32>;
    var phi_466_: u32;
    var phi_467_: u32;
    var phi_468_: u32;
    var phi_469_: vec4<f32>;
    var phi_470_: u32;
    var phi_471_: u32;
    var phi_472_: u32;
    var phi_473_: vec4<f32>;
    var phi_474_: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: vec4<f32>;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;

    let _e45 = global_2;
    let _e46 = _e45.xy;
    let _e51 = (_e45.x | (_e45.y << bitcast<u32>(16)));
    let _e55 = ((_e51 | (_e51 << bitcast<u32>(4))) & 252645135u);
    let _e59 = ((_e55 | (_e55 << bitcast<u32>(2))) & 858993459u);
    let _e63 = ((_e59 | (_e59 << bitcast<u32>(1))) & 1431655765u);
    let _e67 = ((_e63 | (_e63 >> bitcast<u32>(15))) & 65535u);
    let _e68 = vec2<f32>(_e46);
    let _e70 = vec2<f32>((_e46 + vec2<u32>(1u, 1u)));
    let _e76 = (vec4<f32>(_e68.x, _e68.y, _e70.x, _e70.y) * vec4<f32>(0.5, 0.5, 0.5, 0.5));
    phi_108_ = 0u;
    phi_111_ = 0u;
    phi_113_ = vec4<f32>(1.0, 1.0, -1.0, -1.0);
    phi_115_ = 0u;
    phi_117_ = 0u;
    loop {
        let _e78 = phi_108_;
        let _e80 = phi_111_;
        let _e82 = phi_113_;
        let _e84 = phi_115_;
        let _e86 = phi_117_;
        let _e88 = global_3.member;
        local = _e84;
        local_1 = _e84;
        local_3 = _e82;
        local_4 = _e84;
        local_12 = _e80;
        local_5 = _e78;
        if (_e86 < _e88) {
            let _e92 = global_4.member[_e86];
            let _e93 = _e92.xy;
            let _e94 = _e92.zw;
            let _e96 = ((_e93 + _e94) * 0.5);
            let _e99 = all((_e96 >= _e76.xy));
            phi_138_ = _e99;
            if _e99 {
                phi_138_ = all((_e96 < _e76.zw));
            }
            let _e104 = phi_138_;
            phi_109_ = _e78;
            phi_112_ = _e80;
            phi_114_ = _e82;
            phi_116_ = _e84;
            if _e104 {
                let _e108 = min(_e93, _e94);
                let _e109 = max(_e93, _e94);
                let _e114 = vec4<f32>(_e108.x, _e108.y, _e109.x, _e109.y);
                let _e117 = min(_e82.xy, _e114.xy);
                let _e120 = max(_e82.zw, _e114.zw);
                phi_109_ = (_e86 + 1u);
                phi_112_ = select(_e80, _e86, (_e84 == 0u));
                phi_114_ = vec4<f32>(_e117.x, _e117.y, _e120.x, _e120.y);
                phi_116_ = (_e84 + bitcast<u32>(1));
            }
            let _e129 = phi_109_;
            let _e131 = phi_112_;
            let _e133 = phi_114_;
            let _e135 = phi_116_;
            local_6 = _e129;
            local_7 = _e131;
            local_8 = _e133;
            local_9 = _e135;
            continue;
        } else {
            break;
        }
        continuing {
            let _e489 = local_6;
            phi_108_ = _e489;
            let _e492 = local_7;
            phi_111_ = _e492;
            let _e495 = local_8;
            phi_113_ = _e495;
            let _e498 = local_9;
            phi_115_ = _e498;
            phi_117_ = (_e86 + bitcast<u32>(1));
        }
    }
    let _e140 = local;
    global_5[_e67] = _e140;
    workgroupBarrier();
    phi_165_ = 9u;
    phi_168_ = 0u;
    loop {
        let _e142 = phi_165_;
        let _e144 = phi_168_;
        local_2 = _e142;
        local_10 = _e142;
        if (_e144 < _e67) {
            continue;
        } else {
            break;
        }
        continuing {
            let _e147 = global_5[_e144];
            phi_165_ = (_e142 + _e147);
            phi_168_ = (_e144 + bitcast<u32>(1));
        }
    }
    let _e154 = local_1;
    let _e159 = local_2;
    let _e161 = local_3;
    let _e163 = local_4;
    global_1[((_e45.y * 2u) + _e45.x)] = type_3((1u | (_e154 << bitcast<u32>(1))), _e159, _e161, _e163);
    workgroupBarrier();
    let _e514 = local_10;
    phi_181_ = _e514;
    let _e519 = local_12;
    phi_184_ = _e519;
    loop {
        let _e167 = phi_181_;
        let _e169 = phi_184_;
        let _e171 = local_5;
        if (_e169 < _e171) {
            let _e175 = global_4.member[_e169];
            let _e176 = _e175.xy;
            let _e177 = _e175.zw;
            let _e179 = ((_e176 + _e177) * 0.5);
            let _e182 = all((_e179 >= _e76.xy));
            phi_203_ = _e182;
            if _e182 {
                phi_203_ = all((_e179 < _e76.zw));
            }
            let _e187 = phi_203_;
            phi_182_ = _e167;
            if _e187 {
                let _e190 = (_e176 - _e177);
                global.member[_e167] = vec4<f32>(_e175.x, _e175.y, _e190.x, _e190.y);
                phi_182_ = (_e167 + bitcast<u32>(1));
            }
            let _e199 = phi_182_;
            local_11 = _e199;
            continue;
        } else {
            break;
        }
        continuing {
            let _e516 = local_11;
            phi_181_ = _e516;
            phi_184_ = (_e169 + bitcast<u32>(1));
        }
    }
    if all((_e46 < vec2<u32>(1u, 1u))) {
        let _e204 = (_e46 * vec2<u32>(2u, 2u));
        let _e209 = (_e204 + vec2<u32>(1u, 0u));
        let _e214 = (_e204 + vec2<u32>(0u, 1u));
        let _e219 = (_e204 + vec2<u32>(1u, 1u));
        let _e225 = global_1[((_e204.y * 2u) + _e204.x)];
        let _e231 = global_1[((_e209.y * 2u) + _e209.x)];
        let _e237 = global_1[((_e214.y * 2u) + _e214.x)];
        let _e243 = global_1[((_e219.y * 2u) + _e219.x)];
        let _e248 = (9u * _e67);
        let _e251 = (((_e225.member_3 + _e231.member_3) + _e237.member_3) + _e243.member_3);
        let _e257 = ((_e251 <= 16u) && all(((vec4<u32>(_e225.member, _e231.member, _e237.member, _e243.member) & vec4<u32>(1u, 1u, 1u, 1u)) == vec4<u32>(1u, 1u, 1u, 1u))));
        phi_309_ = u32();
        phi_310_ = vec4<f32>();
        if _e257 {
            let _e260 = min(_e225.member_2.xy, _e231.member_2.xy);
            let _e263 = max(_e225.member_2.zw, _e231.member_2.zw);
            let _e268 = vec4<f32>(_e260.x, _e260.y, _e263.x, _e263.y);
            let _e271 = min(_e237.member_2.xy, _e243.member_2.xy);
            let _e274 = max(_e237.member_2.zw, _e243.member_2.zw);
            let _e279 = vec4<f32>(_e271.x, _e271.y, _e274.x, _e274.y);
            let _e282 = min(_e268.xy, _e279.xy);
            let _e285 = max(_e268.zw, _e279.zw);
            phi_309_ = (1u | (_e251 << bitcast<u32>(1)));
            phi_310_ = vec4<f32>(_e282.x, _e282.y, _e285.x, _e285.y);
        }
        let _e295 = phi_309_;
        let _e297 = phi_310_;
        let _e299 = select(u32(), 0u, _e257);
        phi_467_ = select(u32(), 1u, _e257);
        phi_468_ = _e299;
        phi_469_ = select(vec4<f32>(), vec4<f32>(1.0, 1.0, -1.0, -1.0), vec4(_e257));
        phi_470_ = _e299;
        phi_471_ = _e295;
        phi_472_ = select(u32(), _e225.member_1, _e257);
        phi_473_ = _e297;
        phi_474_ = select(u32(), _e251, _e257);
        if !(select(false, true, _e257)) {
            let _e306 = _e225.member_2.xy;
            let _e307 = _e231.member_2.xy;
            let _e308 = min(_e306, _e307);
            let _e309 = _e225.member_2.zw;
            let _e310 = _e231.member_2.zw;
            let _e311 = max(_e309, _e310);
            let _e316 = vec4<f32>(_e308.x, _e308.y, _e311.x, _e311.y);
            let _e319 = (_e316.zw - _e316.xy);
            let _e324 = _e237.member_2.xy;
            let _e325 = min(_e306, _e324);
            let _e326 = _e237.member_2.zw;
            let _e327 = max(_e309, _e326);
            let _e332 = vec4<f32>(_e325.x, _e325.y, _e327.x, _e327.y);
            let _e335 = (_e332.zw - _e332.xy);
            let _e340 = _e243.member_2.xy;
            let _e341 = min(_e324, _e340);
            let _e342 = _e243.member_2.zw;
            let _e343 = max(_e326, _e342);
            let _e348 = vec4<f32>(_e341.x, _e341.y, _e343.x, _e343.y);
            let _e351 = (_e348.zw - _e348.xy);
            let _e356 = min(_e307, _e340);
            let _e357 = max(_e310, _e342);
            let _e362 = vec4<f32>(_e356.x, _e356.y, _e357.x, _e357.y);
            let _e365 = (_e362.zw - _e362.xy);
            let _e372 = ((max(0.0, (_e319.x * _e319.y)) + max(0.0, (_e351.x * _e351.y))) > (max(0.0, (_e335.x * _e335.y)) + max(0.0, (_e365.x * _e365.y))));
            let _e373 = select(_e237.member, _e231.member, _e372);
            let _e374 = select(_e237.member_1, _e231.member_1, _e372);
            let _e375 = vec4(_e372);
            let _e376 = select(_e237.member_2, _e231.member_2, _e375);
            let _e377 = select(_e237.member_3, _e231.member_3, _e372);
            let _e378 = select(_e231.member, _e237.member, _e372);
            let _e379 = select(_e231.member_1, _e237.member_1, _e372);
            let _e380 = select(_e231.member_2, _e237.member_2, _e375);
            let _e381 = select(_e231.member_3, _e237.member_3, _e372);
            let _e382 = (_e248 + 3u);
            switch bitcast<i32>(0u) {
                default: {
                    global.member[_e382] = bitcast<vec4<f32>>(vec4<u32>(_e225.member, _e225.member_1, _e378, _e379));
                    let _e389 = (_e225.member_3 == 0u);
                    global.member[(_e248 + 4u)] = select(_e225.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e389));
                    let _e395 = (_e381 == 0u);
                    global.member[(_e248 + 5u)] = select(_e380, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e395));
                    if _e395 {
                        phi_428_ = _e225.member;
                        phi_429_ = _e225.member_1;
                        phi_430_ = _e225.member_2;
                        phi_431_ = _e225.member_3;
                        break;
                    } else {
                        if _e389 {
                            phi_428_ = _e378;
                            phi_429_ = _e379;
                            phi_430_ = _e380;
                            phi_431_ = _e381;
                            break;
                        }
                    }
                    let _e402 = min(_e306, _e380.xy);
                    let _e404 = max(_e309, _e380.zw);
                    phi_428_ = 0u;
                    phi_429_ = _e382;
                    phi_430_ = vec4<f32>(_e402.x, _e402.y, _e404.x, _e404.y);
                    phi_431_ = (_e225.member_3 + _e381);
                    break;
                }
            }
            let _e411 = phi_428_;
            let _e413 = phi_429_;
            let _e415 = phi_430_;
            let _e417 = phi_431_;
            let _e418 = (_e248 + 6u);
            switch bitcast<i32>(0u) {
                default: {
                    global.member[_e418] = bitcast<vec4<f32>>(vec4<u32>(_e373, _e374, _e243.member, _e243.member_1));
                    let _e425 = (_e377 == 0u);
                    global.member[(_e248 + 7u)] = select(_e376, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e425));
                    let _e431 = (_e243.member_3 == 0u);
                    global.member[(_e248 + 8u)] = select(_e243.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e431));
                    if _e431 {
                        phi_463_ = _e373;
                        phi_464_ = _e374;
                        phi_465_ = _e376;
                        phi_466_ = _e377;
                        break;
                    } else {
                        if _e425 {
                            phi_463_ = _e243.member;
                            phi_464_ = _e243.member_1;
                            phi_465_ = _e243.member_2;
                            phi_466_ = _e243.member_3;
                            break;
                        }
                    }
                    let _e438 = min(_e376.xy, _e340);
                    let _e440 = max(_e376.zw, _e342);
                    phi_463_ = 0u;
                    phi_464_ = _e418;
                    phi_465_ = vec4<f32>(_e438.x, _e438.y, _e440.x, _e440.y);
                    phi_466_ = (_e377 + _e243.member_3);
                    break;
                }
            }
            let _e447 = phi_463_;
            let _e449 = phi_464_;
            let _e451 = phi_465_;
            let _e453 = phi_466_;
            phi_467_ = _e447;
            phi_468_ = _e449;
            phi_469_ = _e451;
            phi_470_ = _e453;
            phi_471_ = _e411;
            phi_472_ = _e413;
            phi_473_ = _e415;
            phi_474_ = _e417;
        }
        let _e455 = phi_467_;
        let _e457 = phi_468_;
        let _e459 = phi_469_;
        let _e461 = phi_470_;
        let _e463 = phi_471_;
        let _e465 = phi_472_;
        let _e467 = phi_473_;
        let _e469 = phi_474_;
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e248] = bitcast<vec4<f32>>(vec4<u32>(_e463, _e465, _e455, _e457));
                let _e476 = (_e469 == 0u);
                global.member[(_e248 + 1u)] = select(_e467, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e476));
                let _e482 = (_e461 == 0u);
                global.member[(_e248 + 2u)] = select(_e459, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e482));
                if _e482 {
                    break;
                } else {
                    if _e476 {
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

@compute @workgroup_size(2, 2, 1) 
fn main(@builtin(local_invocation_id) param: vec3<u32>) {
    global_2 = param;
    function();
}
