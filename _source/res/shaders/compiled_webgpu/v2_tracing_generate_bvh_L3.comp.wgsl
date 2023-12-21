struct type_3 {
    member: u32,
    member_1: u32,
    member_2: vec4<f32>,
    member_3: u32,
}

struct type_10 {
    member: array<vec4<f32>>,
}

struct type_22 {
    member: u32,
}

@group(0) @binding(1) 
var<storage, read_write> global: type_10;
var<workgroup> global_1: array<type_3, 64>;
var<workgroup> global_2: array<type_3, 16>;
var<private> global_3: vec3<u32>;
@group(0) @binding(2) 
var<uniform> global_4: type_22;
@group(0) @binding(0) 
var<storage> global_5: type_10;
var<workgroup> global_6: array<u32, 64>;

fn function() {
    var phi_131_: u32;
    var phi_134_: u32;
    var phi_136_: vec4<f32>;
    var phi_138_: u32;
    var phi_140_: u32;
    var phi_161_: bool;
    var phi_132_: u32;
    var phi_135_: u32;
    var phi_137_: vec4<f32>;
    var phi_139_: u32;
    var local: u32;
    var phi_188_: u32;
    var phi_191_: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: vec4<f32>;
    var local_4: u32;
    var phi_204_: u32;
    var phi_207_: u32;
    var local_5: u32;
    var phi_226_: bool;
    var phi_205_: u32;
    var phi_335_: u32;
    var phi_336_: vec4<f32>;
    var phi_454_: u32;
    var phi_455_: u32;
    var phi_456_: vec4<f32>;
    var phi_457_: u32;
    var phi_489_: u32;
    var phi_490_: u32;
    var phi_491_: vec4<f32>;
    var phi_492_: u32;
    var phi_493_: u32;
    var phi_494_: u32;
    var phi_495_: vec4<f32>;
    var phi_496_: u32;
    var phi_497_: u32;
    var phi_498_: u32;
    var phi_499_: vec4<f32>;
    var phi_500_: u32;
    var phi_533_: u32;
    var phi_534_: u32;
    var phi_535_: vec4<f32>;
    var phi_536_: u32;
    var phi_539_: u32;
    var phi_540_: u32;
    var phi_541_: vec4<f32>;
    var phi_542_: u32;
    var phi_543_: u32;
    var phi_544_: u32;
    var phi_545_: vec4<f32>;
    var phi_546_: u32;
    var phi_645_: u32;
    var phi_646_: vec4<f32>;
    var phi_765_: u32;
    var phi_766_: u32;
    var phi_767_: vec4<f32>;
    var phi_768_: u32;
    var phi_800_: u32;
    var phi_801_: u32;
    var phi_802_: vec4<f32>;
    var phi_803_: u32;
    var phi_804_: u32;
    var phi_805_: u32;
    var phi_806_: vec4<f32>;
    var phi_807_: u32;
    var phi_808_: u32;
    var phi_809_: u32;
    var phi_810_: vec4<f32>;
    var phi_811_: u32;
    var phi_844_: u32;
    var phi_845_: u32;
    var phi_846_: vec4<f32>;
    var phi_847_: u32;
    var phi_850_: u32;
    var phi_851_: u32;
    var phi_852_: vec4<f32>;
    var phi_853_: u32;
    var phi_854_: u32;
    var phi_855_: u32;
    var phi_856_: vec4<f32>;
    var phi_857_: u32;
    var phi_953_: u32;
    var phi_954_: vec4<f32>;
    var phi_1073_: u32;
    var phi_1074_: u32;
    var phi_1075_: vec4<f32>;
    var phi_1076_: u32;
    var phi_1108_: u32;
    var phi_1109_: u32;
    var phi_1110_: vec4<f32>;
    var phi_1111_: u32;
    var phi_1112_: u32;
    var phi_1113_: u32;
    var phi_1114_: vec4<f32>;
    var phi_1115_: u32;
    var phi_1116_: u32;
    var phi_1117_: u32;
    var phi_1118_: vec4<f32>;
    var phi_1119_: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: vec4<f32>;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;

    let _e66 = global_3;
    let _e67 = _e66.xy;
    let _e72 = (_e66.x | (_e66.y << bitcast<u32>(16)));
    let _e76 = ((_e72 | (_e72 << bitcast<u32>(4))) & 252645135u);
    let _e80 = ((_e76 | (_e76 << bitcast<u32>(2))) & 858993459u);
    let _e84 = ((_e80 | (_e80 << bitcast<u32>(1))) & 1431655765u);
    let _e88 = ((_e84 | (_e84 >> bitcast<u32>(15))) & 65535u);
    let _e89 = vec2<f32>(_e67);
    let _e91 = vec2<f32>((_e67 + vec2<u32>(1u, 1u)));
    let _e97 = (vec4<f32>(_e89.x, _e89.y, _e91.x, _e91.y) * vec4<f32>(0.125, 0.125, 0.125, 0.125));
    phi_131_ = 0u;
    phi_134_ = 0u;
    phi_136_ = vec4<f32>(1.0, 1.0, -1.0, -1.0);
    phi_138_ = 0u;
    phi_140_ = 0u;
    loop {
        let _e99 = phi_131_;
        let _e101 = phi_134_;
        let _e103 = phi_136_;
        let _e105 = phi_138_;
        let _e107 = phi_140_;
        let _e109 = global_4.member;
        local = _e105;
        local_1 = _e105;
        local_3 = _e103;
        local_4 = _e105;
        local_12 = _e101;
        local_5 = _e99;
        if (_e107 < _e109) {
            let _e113 = global_5.member[_e107];
            let _e114 = _e113.xy;
            let _e115 = _e113.zw;
            let _e117 = ((_e114 + _e115) * 0.5);
            let _e120 = all((_e117 >= _e97.xy));
            phi_161_ = _e120;
            if _e120 {
                phi_161_ = all((_e117 < _e97.zw));
            }
            let _e125 = phi_161_;
            phi_132_ = _e99;
            phi_135_ = _e101;
            phi_137_ = _e103;
            phi_139_ = _e105;
            if _e125 {
                let _e129 = min(_e114, _e115);
                let _e130 = max(_e114, _e115);
                let _e135 = vec4<f32>(_e129.x, _e129.y, _e130.x, _e130.y);
                let _e138 = min(_e103.xy, _e135.xy);
                let _e141 = max(_e103.zw, _e135.zw);
                phi_132_ = (_e107 + 1u);
                phi_135_ = select(_e101, _e107, (_e105 == 0u));
                phi_137_ = vec4<f32>(_e138.x, _e138.y, _e141.x, _e141.y);
                phi_139_ = (_e105 + bitcast<u32>(1));
            }
            let _e150 = phi_132_;
            let _e152 = phi_135_;
            let _e154 = phi_137_;
            let _e156 = phi_139_;
            local_6 = _e150;
            local_7 = _e152;
            local_8 = _e154;
            local_9 = _e156;
            continue;
        } else {
            break;
        }
        continuing {
            let _e1164 = local_6;
            phi_131_ = _e1164;
            let _e1167 = local_7;
            phi_134_ = _e1167;
            let _e1170 = local_8;
            phi_136_ = _e1170;
            let _e1173 = local_9;
            phi_138_ = _e1173;
            phi_140_ = (_e107 + bitcast<u32>(1));
        }
    }
    let _e161 = local;
    global_6[_e88] = _e161;
    workgroupBarrier();
    phi_188_ = 189u;
    phi_191_ = 0u;
    loop {
        let _e163 = phi_188_;
        let _e165 = phi_191_;
        local_2 = _e163;
        local_10 = _e163;
        if (_e165 < _e88) {
            continue;
        } else {
            break;
        }
        continuing {
            let _e168 = global_6[_e165];
            phi_188_ = (_e163 + _e168);
            phi_191_ = (_e165 + bitcast<u32>(1));
        }
    }
    let _e175 = local_1;
    let _e180 = local_2;
    let _e182 = local_3;
    let _e184 = local_4;
    global_1[((_e66.y * 8u) + _e66.x)] = type_3((1u | (_e175 << bitcast<u32>(1))), _e180, _e182, _e184);
    workgroupBarrier();
    let _e1189 = local_10;
    phi_204_ = _e1189;
    let _e1194 = local_12;
    phi_207_ = _e1194;
    loop {
        let _e188 = phi_204_;
        let _e190 = phi_207_;
        let _e192 = local_5;
        if (_e190 < _e192) {
            let _e196 = global_5.member[_e190];
            let _e197 = _e196.xy;
            let _e198 = _e196.zw;
            let _e200 = ((_e197 + _e198) * 0.5);
            let _e203 = all((_e200 >= _e97.xy));
            phi_226_ = _e203;
            if _e203 {
                phi_226_ = all((_e200 < _e97.zw));
            }
            let _e208 = phi_226_;
            phi_205_ = _e188;
            if _e208 {
                let _e211 = (_e197 - _e198);
                global.member[_e188] = vec4<f32>(_e196.x, _e196.y, _e211.x, _e211.y);
                phi_205_ = (_e188 + bitcast<u32>(1));
            }
            let _e220 = phi_205_;
            local_11 = _e220;
            continue;
        } else {
            break;
        }
        continuing {
            let _e1191 = local_11;
            phi_204_ = _e1191;
            phi_207_ = (_e190 + bitcast<u32>(1));
        }
    }
    phi_539_ = u32();
    phi_540_ = u32();
    phi_541_ = vec4<f32>();
    phi_542_ = u32();
    phi_543_ = u32();
    phi_544_ = u32();
    phi_545_ = vec4<f32>();
    phi_546_ = u32();
    if all((_e67 < vec2<u32>(4u, 4u))) {
        let _e227 = (_e67 * vec2<u32>(2u, 2u));
        let _e232 = (_e227 + vec2<u32>(1u, 0u));
        let _e237 = (_e227 + vec2<u32>(0u, 1u));
        let _e242 = (_e227 + vec2<u32>(1u, 1u));
        let _e248 = global_1[((_e227.y * 8u) + _e227.x)];
        let _e254 = global_1[((_e232.y * 8u) + _e232.x)];
        let _e260 = global_1[((_e237.y * 8u) + _e237.x)];
        let _e266 = global_1[((_e242.y * 8u) + _e242.x)];
        let _e271 = (9u * _e88);
        let _e272 = (45u + _e271);
        let _e275 = (((_e248.member_3 + _e254.member_3) + _e260.member_3) + _e266.member_3);
        let _e281 = ((_e275 <= 16u) && all(((vec4<u32>(_e248.member, _e254.member, _e260.member, _e266.member) & vec4<u32>(1u, 1u, 1u, 1u)) == vec4<u32>(1u, 1u, 1u, 1u))));
        phi_335_ = u32();
        phi_336_ = vec4<f32>();
        if _e281 {
            let _e284 = min(_e248.member_2.xy, _e254.member_2.xy);
            let _e287 = max(_e248.member_2.zw, _e254.member_2.zw);
            let _e292 = vec4<f32>(_e284.x, _e284.y, _e287.x, _e287.y);
            let _e295 = min(_e260.member_2.xy, _e266.member_2.xy);
            let _e298 = max(_e260.member_2.zw, _e266.member_2.zw);
            let _e303 = vec4<f32>(_e295.x, _e295.y, _e298.x, _e298.y);
            let _e306 = min(_e292.xy, _e303.xy);
            let _e309 = max(_e292.zw, _e303.zw);
            phi_335_ = (1u | (_e275 << bitcast<u32>(1)));
            phi_336_ = vec4<f32>(_e306.x, _e306.y, _e309.x, _e309.y);
        }
        let _e319 = phi_335_;
        let _e321 = phi_336_;
        let _e323 = select(u32(), 0u, _e281);
        phi_493_ = select(u32(), 1u, _e281);
        phi_494_ = _e323;
        phi_495_ = select(vec4<f32>(), vec4<f32>(1.0, 1.0, -1.0, -1.0), vec4(_e281));
        phi_496_ = _e323;
        phi_497_ = _e319;
        phi_498_ = select(u32(), _e248.member_1, _e281);
        phi_499_ = _e321;
        phi_500_ = select(u32(), _e275, _e281);
        if !(select(false, true, _e281)) {
            let _e330 = _e248.member_2.xy;
            let _e331 = _e254.member_2.xy;
            let _e332 = min(_e330, _e331);
            let _e333 = _e248.member_2.zw;
            let _e334 = _e254.member_2.zw;
            let _e335 = max(_e333, _e334);
            let _e340 = vec4<f32>(_e332.x, _e332.y, _e335.x, _e335.y);
            let _e343 = (_e340.zw - _e340.xy);
            let _e348 = _e260.member_2.xy;
            let _e349 = min(_e330, _e348);
            let _e350 = _e260.member_2.zw;
            let _e351 = max(_e333, _e350);
            let _e356 = vec4<f32>(_e349.x, _e349.y, _e351.x, _e351.y);
            let _e359 = (_e356.zw - _e356.xy);
            let _e364 = _e266.member_2.xy;
            let _e365 = min(_e348, _e364);
            let _e366 = _e266.member_2.zw;
            let _e367 = max(_e350, _e366);
            let _e372 = vec4<f32>(_e365.x, _e365.y, _e367.x, _e367.y);
            let _e375 = (_e372.zw - _e372.xy);
            let _e380 = min(_e331, _e364);
            let _e381 = max(_e334, _e366);
            let _e386 = vec4<f32>(_e380.x, _e380.y, _e381.x, _e381.y);
            let _e389 = (_e386.zw - _e386.xy);
            let _e396 = ((max(0.0, (_e343.x * _e343.y)) + max(0.0, (_e375.x * _e375.y))) > (max(0.0, (_e359.x * _e359.y)) + max(0.0, (_e389.x * _e389.y))));
            let _e397 = select(_e260.member, _e254.member, _e396);
            let _e398 = select(_e260.member_1, _e254.member_1, _e396);
            let _e399 = vec4(_e396);
            let _e400 = select(_e260.member_2, _e254.member_2, _e399);
            let _e401 = select(_e260.member_3, _e254.member_3, _e396);
            let _e402 = select(_e254.member, _e260.member, _e396);
            let _e403 = select(_e254.member_1, _e260.member_1, _e396);
            let _e404 = select(_e254.member_2, _e260.member_2, _e399);
            let _e405 = select(_e254.member_3, _e260.member_3, _e396);
            let _e406 = (_e271 + 48u);
            switch bitcast<i32>(0u) {
                default: {
                    global.member[_e406] = bitcast<vec4<f32>>(vec4<u32>(_e248.member, _e248.member_1, _e402, _e403));
                    let _e413 = (_e248.member_3 == 0u);
                    global.member[(_e271 + 49u)] = select(_e248.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e413));
                    let _e419 = (_e405 == 0u);
                    global.member[(_e271 + 50u)] = select(_e404, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e419));
                    if _e419 {
                        phi_454_ = _e248.member;
                        phi_455_ = _e248.member_1;
                        phi_456_ = _e248.member_2;
                        phi_457_ = _e248.member_3;
                        break;
                    } else {
                        if _e413 {
                            phi_454_ = _e402;
                            phi_455_ = _e403;
                            phi_456_ = _e404;
                            phi_457_ = _e405;
                            break;
                        }
                    }
                    let _e426 = min(_e330, _e404.xy);
                    let _e428 = max(_e333, _e404.zw);
                    phi_454_ = 0u;
                    phi_455_ = _e406;
                    phi_456_ = vec4<f32>(_e426.x, _e426.y, _e428.x, _e428.y);
                    phi_457_ = (_e248.member_3 + _e405);
                    break;
                }
            }
            let _e435 = phi_454_;
            let _e437 = phi_455_;
            let _e439 = phi_456_;
            let _e441 = phi_457_;
            let _e442 = (_e271 + 51u);
            switch bitcast<i32>(0u) {
                default: {
                    global.member[_e442] = bitcast<vec4<f32>>(vec4<u32>(_e397, _e398, _e266.member, _e266.member_1));
                    let _e449 = (_e401 == 0u);
                    global.member[(_e271 + 52u)] = select(_e400, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e449));
                    let _e455 = (_e266.member_3 == 0u);
                    global.member[(_e271 + 53u)] = select(_e266.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e455));
                    if _e455 {
                        phi_489_ = _e397;
                        phi_490_ = _e398;
                        phi_491_ = _e400;
                        phi_492_ = _e401;
                        break;
                    } else {
                        if _e449 {
                            phi_489_ = _e266.member;
                            phi_490_ = _e266.member_1;
                            phi_491_ = _e266.member_2;
                            phi_492_ = _e266.member_3;
                            break;
                        }
                    }
                    let _e462 = min(_e400.xy, _e364);
                    let _e464 = max(_e400.zw, _e366);
                    phi_489_ = 0u;
                    phi_490_ = _e442;
                    phi_491_ = vec4<f32>(_e462.x, _e462.y, _e464.x, _e464.y);
                    phi_492_ = (_e401 + _e266.member_3);
                    break;
                }
            }
            let _e471 = phi_489_;
            let _e473 = phi_490_;
            let _e475 = phi_491_;
            let _e477 = phi_492_;
            phi_493_ = _e471;
            phi_494_ = _e473;
            phi_495_ = _e475;
            phi_496_ = _e477;
            phi_497_ = _e435;
            phi_498_ = _e437;
            phi_499_ = _e439;
            phi_500_ = _e441;
        }
        let _e479 = phi_493_;
        let _e481 = phi_494_;
        let _e483 = phi_495_;
        let _e485 = phi_496_;
        let _e487 = phi_497_;
        let _e489 = phi_498_;
        let _e491 = phi_499_;
        let _e493 = phi_500_;
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e272] = bitcast<vec4<f32>>(vec4<u32>(_e487, _e489, _e479, _e481));
                let _e500 = (_e493 == 0u);
                global.member[(_e271 + 46u)] = select(_e491, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e500));
                let _e506 = (_e485 == 0u);
                global.member[(_e271 + 47u)] = select(_e483, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e506));
                if _e506 {
                    phi_533_ = _e487;
                    phi_534_ = _e489;
                    phi_535_ = _e491;
                    phi_536_ = _e493;
                    break;
                } else {
                    if _e500 {
                        phi_533_ = _e479;
                        phi_534_ = _e481;
                        phi_535_ = _e483;
                        phi_536_ = _e485;
                        break;
                    }
                }
                let _e514 = min(_e491.xy, _e483.xy);
                let _e517 = max(_e491.zw, _e483.zw);
                phi_533_ = 0u;
                phi_534_ = _e272;
                phi_535_ = vec4<f32>(_e514.x, _e514.y, _e517.x, _e517.y);
                phi_536_ = (_e493 + _e485);
                break;
            }
        }
        let _e524 = phi_533_;
        let _e526 = phi_534_;
        let _e528 = phi_535_;
        let _e530 = phi_536_;
        global_2[((_e66.y * 4u) + _e66.x)] = type_3(_e524, _e526, _e528, _e530);
        phi_539_ = _e479;
        phi_540_ = _e481;
        phi_541_ = _e483;
        phi_542_ = _e485;
        phi_543_ = _e487;
        phi_544_ = _e489;
        phi_545_ = _e491;
        phi_546_ = _e493;
    }
    let _e534 = phi_539_;
    let _e536 = phi_540_;
    let _e538 = phi_541_;
    let _e540 = phi_542_;
    let _e542 = phi_543_;
    let _e544 = phi_544_;
    let _e546 = phi_545_;
    workgroupBarrier();
    let _e548 = phi_546_;
    phi_850_ = _e534;
    phi_851_ = _e536;
    phi_852_ = _e538;
    phi_853_ = _e540;
    phi_854_ = _e542;
    phi_855_ = _e544;
    phi_856_ = _e546;
    phi_857_ = _e548;
    if all((_e67 < vec2<u32>(2u, 2u))) {
        let _e553 = (_e67 * vec2<u32>(2u, 2u));
        let _e558 = (_e553 + vec2<u32>(1u, 0u));
        let _e563 = (_e553 + vec2<u32>(0u, 1u));
        let _e568 = (_e553 + vec2<u32>(1u, 1u));
        let _e574 = global_2[((_e553.y * 4u) + _e553.x)];
        let _e580 = global_2[((_e558.y * 4u) + _e558.x)];
        let _e586 = global_2[((_e563.y * 4u) + _e563.x)];
        let _e592 = global_2[((_e568.y * 4u) + _e568.x)];
        let _e597 = (9u * _e88);
        let _e598 = (9u + _e597);
        let _e601 = (((_e574.member_3 + _e580.member_3) + _e586.member_3) + _e592.member_3);
        let _e607 = ((_e601 <= 16u) && all(((vec4<u32>(_e574.member, _e580.member, _e586.member, _e592.member) & vec4<u32>(1u, 1u, 1u, 1u)) == vec4<u32>(1u, 1u, 1u, 1u))));
        phi_645_ = _e542;
        phi_646_ = _e546;
        if _e607 {
            let _e610 = min(_e574.member_2.xy, _e580.member_2.xy);
            let _e613 = max(_e574.member_2.zw, _e580.member_2.zw);
            let _e618 = vec4<f32>(_e610.x, _e610.y, _e613.x, _e613.y);
            let _e621 = min(_e586.member_2.xy, _e592.member_2.xy);
            let _e624 = max(_e586.member_2.zw, _e592.member_2.zw);
            let _e629 = vec4<f32>(_e621.x, _e621.y, _e624.x, _e624.y);
            let _e632 = min(_e618.xy, _e629.xy);
            let _e635 = max(_e618.zw, _e629.zw);
            phi_645_ = (1u | (_e601 << bitcast<u32>(1)));
            phi_646_ = vec4<f32>(_e632.x, _e632.y, _e635.x, _e635.y);
        }
        let _e645 = phi_645_;
        let _e647 = phi_646_;
        phi_804_ = select(_e534, 1u, _e607);
        phi_805_ = select(_e536, 0u, _e607);
        phi_806_ = select(_e538, vec4<f32>(1.0, 1.0, -1.0, -1.0), vec4(_e607));
        phi_807_ = select(_e540, 0u, _e607);
        phi_808_ = _e645;
        phi_809_ = select(_e544, _e574.member_1, _e607);
        phi_810_ = _e647;
        phi_811_ = select(_e548, _e601, _e607);
        if !(select(false, true, _e607)) {
            let _e657 = _e574.member_2.xy;
            let _e658 = _e580.member_2.xy;
            let _e659 = min(_e657, _e658);
            let _e660 = _e574.member_2.zw;
            let _e661 = _e580.member_2.zw;
            let _e662 = max(_e660, _e661);
            let _e667 = vec4<f32>(_e659.x, _e659.y, _e662.x, _e662.y);
            let _e670 = (_e667.zw - _e667.xy);
            let _e675 = _e586.member_2.xy;
            let _e676 = min(_e657, _e675);
            let _e677 = _e586.member_2.zw;
            let _e678 = max(_e660, _e677);
            let _e683 = vec4<f32>(_e676.x, _e676.y, _e678.x, _e678.y);
            let _e686 = (_e683.zw - _e683.xy);
            let _e691 = _e592.member_2.xy;
            let _e692 = min(_e675, _e691);
            let _e693 = _e592.member_2.zw;
            let _e694 = max(_e677, _e693);
            let _e699 = vec4<f32>(_e692.x, _e692.y, _e694.x, _e694.y);
            let _e702 = (_e699.zw - _e699.xy);
            let _e707 = min(_e658, _e691);
            let _e708 = max(_e661, _e693);
            let _e713 = vec4<f32>(_e707.x, _e707.y, _e708.x, _e708.y);
            let _e716 = (_e713.zw - _e713.xy);
            let _e723 = ((max(0.0, (_e670.x * _e670.y)) + max(0.0, (_e702.x * _e702.y))) > (max(0.0, (_e686.x * _e686.y)) + max(0.0, (_e716.x * _e716.y))));
            let _e724 = select(_e586.member, _e580.member, _e723);
            let _e725 = select(_e586.member_1, _e580.member_1, _e723);
            let _e726 = vec4(_e723);
            let _e727 = select(_e586.member_2, _e580.member_2, _e726);
            let _e728 = select(_e586.member_3, _e580.member_3, _e723);
            let _e729 = select(_e580.member, _e586.member, _e723);
            let _e730 = select(_e580.member_1, _e586.member_1, _e723);
            let _e731 = select(_e580.member_2, _e586.member_2, _e726);
            let _e732 = select(_e580.member_3, _e586.member_3, _e723);
            let _e733 = (_e597 + 12u);
            switch bitcast<i32>(0u) {
                default: {
                    global.member[_e733] = bitcast<vec4<f32>>(vec4<u32>(_e574.member, _e574.member_1, _e729, _e730));
                    let _e740 = (_e574.member_3 == 0u);
                    global.member[(_e597 + 13u)] = select(_e574.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e740));
                    let _e746 = (_e732 == 0u);
                    global.member[(_e597 + 14u)] = select(_e731, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e746));
                    if _e746 {
                        phi_765_ = _e574.member;
                        phi_766_ = _e574.member_1;
                        phi_767_ = _e574.member_2;
                        phi_768_ = _e574.member_3;
                        break;
                    } else {
                        if _e740 {
                            phi_765_ = _e729;
                            phi_766_ = _e730;
                            phi_767_ = _e731;
                            phi_768_ = _e732;
                            break;
                        }
                    }
                    let _e753 = min(_e657, _e731.xy);
                    let _e755 = max(_e660, _e731.zw);
                    phi_765_ = 0u;
                    phi_766_ = _e733;
                    phi_767_ = vec4<f32>(_e753.x, _e753.y, _e755.x, _e755.y);
                    phi_768_ = (_e574.member_3 + _e732);
                    break;
                }
            }
            let _e762 = phi_765_;
            let _e764 = phi_766_;
            let _e766 = phi_767_;
            let _e768 = phi_768_;
            let _e769 = (_e597 + 15u);
            switch bitcast<i32>(0u) {
                default: {
                    global.member[_e769] = bitcast<vec4<f32>>(vec4<u32>(_e724, _e725, _e592.member, _e592.member_1));
                    let _e776 = (_e728 == 0u);
                    global.member[(_e597 + 16u)] = select(_e727, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e776));
                    let _e782 = (_e592.member_3 == 0u);
                    global.member[(_e597 + 17u)] = select(_e592.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e782));
                    if _e782 {
                        phi_800_ = _e724;
                        phi_801_ = _e725;
                        phi_802_ = _e727;
                        phi_803_ = _e728;
                        break;
                    } else {
                        if _e776 {
                            phi_800_ = _e592.member;
                            phi_801_ = _e592.member_1;
                            phi_802_ = _e592.member_2;
                            phi_803_ = _e592.member_3;
                            break;
                        }
                    }
                    let _e789 = min(_e727.xy, _e691);
                    let _e791 = max(_e727.zw, _e693);
                    phi_800_ = 0u;
                    phi_801_ = _e769;
                    phi_802_ = vec4<f32>(_e789.x, _e789.y, _e791.x, _e791.y);
                    phi_803_ = (_e728 + _e592.member_3);
                    break;
                }
            }
            let _e798 = phi_800_;
            let _e800 = phi_801_;
            let _e802 = phi_802_;
            let _e804 = phi_803_;
            phi_804_ = _e798;
            phi_805_ = _e800;
            phi_806_ = _e802;
            phi_807_ = _e804;
            phi_808_ = _e762;
            phi_809_ = _e764;
            phi_810_ = _e766;
            phi_811_ = _e768;
        }
        let _e806 = phi_804_;
        let _e808 = phi_805_;
        let _e810 = phi_806_;
        let _e812 = phi_807_;
        let _e814 = phi_808_;
        let _e816 = phi_809_;
        let _e818 = phi_810_;
        let _e820 = phi_811_;
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e598] = bitcast<vec4<f32>>(vec4<u32>(_e814, _e816, _e806, _e808));
                let _e827 = (_e820 == 0u);
                global.member[(_e597 + 10u)] = select(_e818, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e827));
                let _e833 = (_e812 == 0u);
                global.member[(_e597 + 11u)] = select(_e810, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e833));
                if _e833 {
                    phi_844_ = _e814;
                    phi_845_ = _e816;
                    phi_846_ = _e818;
                    phi_847_ = _e820;
                    break;
                } else {
                    if _e827 {
                        phi_844_ = _e806;
                        phi_845_ = _e808;
                        phi_846_ = _e810;
                        phi_847_ = _e812;
                        break;
                    }
                }
                let _e841 = min(_e818.xy, _e810.xy);
                let _e844 = max(_e818.zw, _e810.zw);
                phi_844_ = 0u;
                phi_845_ = _e598;
                phi_846_ = vec4<f32>(_e841.x, _e841.y, _e844.x, _e844.y);
                phi_847_ = (_e820 + _e812);
                break;
            }
        }
        let _e851 = phi_844_;
        let _e853 = phi_845_;
        let _e855 = phi_846_;
        let _e857 = phi_847_;
        global_1[((_e66.y * 2u) + _e66.x)] = type_3(_e851, _e853, _e855, _e857);
        phi_850_ = _e806;
        phi_851_ = _e808;
        phi_852_ = _e810;
        phi_853_ = _e812;
        phi_854_ = _e814;
        phi_855_ = _e816;
        phi_856_ = _e818;
        phi_857_ = _e820;
    }
    let _e861 = phi_850_;
    let _e863 = phi_851_;
    let _e865 = phi_852_;
    let _e867 = phi_853_;
    let _e869 = phi_854_;
    let _e871 = phi_855_;
    let _e873 = phi_856_;
    let _e875 = phi_857_;
    if all((_e67 < vec2<u32>(1u, 1u))) {
        let _e878 = (_e67 * vec2<u32>(2u, 2u));
        let _e883 = (_e878 + vec2<u32>(1u, 0u));
        let _e888 = (_e878 + vec2<u32>(0u, 1u));
        let _e893 = (_e878 + vec2<u32>(1u, 1u));
        let _e899 = global_1[((_e878.y * 2u) + _e878.x)];
        let _e905 = global_1[((_e883.y * 2u) + _e883.x)];
        let _e911 = global_1[((_e888.y * 2u) + _e888.x)];
        let _e917 = global_1[((_e893.y * 2u) + _e893.x)];
        let _e922 = (9u * _e88);
        let _e925 = (((_e899.member_3 + _e905.member_3) + _e911.member_3) + _e917.member_3);
        let _e931 = ((_e925 <= 16u) && all(((vec4<u32>(_e899.member, _e905.member, _e911.member, _e917.member) & vec4<u32>(1u, 1u, 1u, 1u)) == vec4<u32>(1u, 1u, 1u, 1u))));
        phi_953_ = _e869;
        phi_954_ = _e873;
        if _e931 {
            let _e934 = min(_e899.member_2.xy, _e905.member_2.xy);
            let _e937 = max(_e899.member_2.zw, _e905.member_2.zw);
            let _e942 = vec4<f32>(_e934.x, _e934.y, _e937.x, _e937.y);
            let _e945 = min(_e911.member_2.xy, _e917.member_2.xy);
            let _e948 = max(_e911.member_2.zw, _e917.member_2.zw);
            let _e953 = vec4<f32>(_e945.x, _e945.y, _e948.x, _e948.y);
            let _e956 = min(_e942.xy, _e953.xy);
            let _e959 = max(_e942.zw, _e953.zw);
            phi_953_ = (1u | (_e925 << bitcast<u32>(1)));
            phi_954_ = vec4<f32>(_e956.x, _e956.y, _e959.x, _e959.y);
        }
        let _e969 = phi_953_;
        let _e971 = phi_954_;
        phi_1112_ = select(_e861, 1u, _e931);
        phi_1113_ = select(_e863, 0u, _e931);
        phi_1114_ = select(_e865, vec4<f32>(1.0, 1.0, -1.0, -1.0), vec4(_e931));
        phi_1115_ = select(_e867, 0u, _e931);
        phi_1116_ = _e969;
        phi_1117_ = select(_e871, _e899.member_1, _e931);
        phi_1118_ = _e971;
        phi_1119_ = select(_e875, _e925, _e931);
        if !(select(false, true, _e931)) {
            let _e981 = _e899.member_2.xy;
            let _e982 = _e905.member_2.xy;
            let _e983 = min(_e981, _e982);
            let _e984 = _e899.member_2.zw;
            let _e985 = _e905.member_2.zw;
            let _e986 = max(_e984, _e985);
            let _e991 = vec4<f32>(_e983.x, _e983.y, _e986.x, _e986.y);
            let _e994 = (_e991.zw - _e991.xy);
            let _e999 = _e911.member_2.xy;
            let _e1000 = min(_e981, _e999);
            let _e1001 = _e911.member_2.zw;
            let _e1002 = max(_e984, _e1001);
            let _e1007 = vec4<f32>(_e1000.x, _e1000.y, _e1002.x, _e1002.y);
            let _e1010 = (_e1007.zw - _e1007.xy);
            let _e1015 = _e917.member_2.xy;
            let _e1016 = min(_e999, _e1015);
            let _e1017 = _e917.member_2.zw;
            let _e1018 = max(_e1001, _e1017);
            let _e1023 = vec4<f32>(_e1016.x, _e1016.y, _e1018.x, _e1018.y);
            let _e1026 = (_e1023.zw - _e1023.xy);
            let _e1031 = min(_e982, _e1015);
            let _e1032 = max(_e985, _e1017);
            let _e1037 = vec4<f32>(_e1031.x, _e1031.y, _e1032.x, _e1032.y);
            let _e1040 = (_e1037.zw - _e1037.xy);
            let _e1047 = ((max(0.0, (_e994.x * _e994.y)) + max(0.0, (_e1026.x * _e1026.y))) > (max(0.0, (_e1010.x * _e1010.y)) + max(0.0, (_e1040.x * _e1040.y))));
            let _e1048 = select(_e911.member, _e905.member, _e1047);
            let _e1049 = select(_e911.member_1, _e905.member_1, _e1047);
            let _e1050 = vec4(_e1047);
            let _e1051 = select(_e911.member_2, _e905.member_2, _e1050);
            let _e1052 = select(_e911.member_3, _e905.member_3, _e1047);
            let _e1053 = select(_e905.member, _e911.member, _e1047);
            let _e1054 = select(_e905.member_1, _e911.member_1, _e1047);
            let _e1055 = select(_e905.member_2, _e911.member_2, _e1050);
            let _e1056 = select(_e905.member_3, _e911.member_3, _e1047);
            let _e1057 = (_e922 + 3u);
            switch bitcast<i32>(0u) {
                default: {
                    global.member[_e1057] = bitcast<vec4<f32>>(vec4<u32>(_e899.member, _e899.member_1, _e1053, _e1054));
                    let _e1064 = (_e899.member_3 == 0u);
                    global.member[(_e922 + 4u)] = select(_e899.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e1064));
                    let _e1070 = (_e1056 == 0u);
                    global.member[(_e922 + 5u)] = select(_e1055, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e1070));
                    if _e1070 {
                        phi_1073_ = _e899.member;
                        phi_1074_ = _e899.member_1;
                        phi_1075_ = _e899.member_2;
                        phi_1076_ = _e899.member_3;
                        break;
                    } else {
                        if _e1064 {
                            phi_1073_ = _e1053;
                            phi_1074_ = _e1054;
                            phi_1075_ = _e1055;
                            phi_1076_ = _e1056;
                            break;
                        }
                    }
                    let _e1077 = min(_e981, _e1055.xy);
                    let _e1079 = max(_e984, _e1055.zw);
                    phi_1073_ = 0u;
                    phi_1074_ = _e1057;
                    phi_1075_ = vec4<f32>(_e1077.x, _e1077.y, _e1079.x, _e1079.y);
                    phi_1076_ = (_e899.member_3 + _e1056);
                    break;
                }
            }
            let _e1086 = phi_1073_;
            let _e1088 = phi_1074_;
            let _e1090 = phi_1075_;
            let _e1092 = phi_1076_;
            let _e1093 = (_e922 + 6u);
            switch bitcast<i32>(0u) {
                default: {
                    global.member[_e1093] = bitcast<vec4<f32>>(vec4<u32>(_e1048, _e1049, _e917.member, _e917.member_1));
                    let _e1100 = (_e1052 == 0u);
                    global.member[(_e922 + 7u)] = select(_e1051, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e1100));
                    let _e1106 = (_e917.member_3 == 0u);
                    global.member[(_e922 + 8u)] = select(_e917.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e1106));
                    if _e1106 {
                        phi_1108_ = _e1048;
                        phi_1109_ = _e1049;
                        phi_1110_ = _e1051;
                        phi_1111_ = _e1052;
                        break;
                    } else {
                        if _e1100 {
                            phi_1108_ = _e917.member;
                            phi_1109_ = _e917.member_1;
                            phi_1110_ = _e917.member_2;
                            phi_1111_ = _e917.member_3;
                            break;
                        }
                    }
                    let _e1113 = min(_e1051.xy, _e1015);
                    let _e1115 = max(_e1051.zw, _e1017);
                    phi_1108_ = 0u;
                    phi_1109_ = _e1093;
                    phi_1110_ = vec4<f32>(_e1113.x, _e1113.y, _e1115.x, _e1115.y);
                    phi_1111_ = (_e1052 + _e917.member_3);
                    break;
                }
            }
            let _e1122 = phi_1108_;
            let _e1124 = phi_1109_;
            let _e1126 = phi_1110_;
            let _e1128 = phi_1111_;
            phi_1112_ = _e1122;
            phi_1113_ = _e1124;
            phi_1114_ = _e1126;
            phi_1115_ = _e1128;
            phi_1116_ = _e1086;
            phi_1117_ = _e1088;
            phi_1118_ = _e1090;
            phi_1119_ = _e1092;
        }
        let _e1130 = phi_1112_;
        let _e1132 = phi_1113_;
        let _e1134 = phi_1114_;
        let _e1136 = phi_1115_;
        let _e1138 = phi_1116_;
        let _e1140 = phi_1117_;
        let _e1142 = phi_1118_;
        let _e1144 = phi_1119_;
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e922] = bitcast<vec4<f32>>(vec4<u32>(_e1138, _e1140, _e1130, _e1132));
                let _e1151 = (_e1144 == 0u);
                global.member[(_e922 + 1u)] = select(_e1142, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e1151));
                let _e1157 = (_e1136 == 0u);
                global.member[(_e922 + 2u)] = select(_e1134, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e1157));
                if _e1157 {
                    break;
                } else {
                    if _e1151 {
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

@compute @workgroup_size(8, 8, 1) 
fn main(@builtin(local_invocation_id) param: vec3<u32>) {
    global_3 = param;
    function();
}
