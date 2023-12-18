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
var<workgroup> global_1: array<type_3, 64>;
var<workgroup> global_2: array<type_3, 16>;
var<private> global_3: vec3<u32>;
@group(0) @binding(2) 
var<uniform> global_4: type_13;
@group(0) @binding(0) 
var<storage, read_write> global_5: type_9;
var<workgroup> global_6: array<u32, 64>;

fn function() {
    var phi_127_: u32;
    var phi_130_: u32;
    var phi_132_: vec4<f32>;
    var phi_134_: u32;
    var phi_136_: u32;
    var phi_157_: bool;
    var phi_128_: u32;
    var phi_131_: u32;
    var phi_133_: vec4<f32>;
    var phi_135_: u32;
    var local: u32;
    var phi_184_: u32;
    var phi_187_: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: vec4<f32>;
    var local_4: u32;
    var phi_198_: u32;
    var phi_201_: u32;
    var local_5: u32;
    var phi_220_: bool;
    var phi_199_: u32;
    var phi_390_: u32;
    var phi_391_: u32;
    var phi_392_: vec4<f32>;
    var phi_393_: u32;
    var phi_425_: u32;
    var phi_426_: u32;
    var phi_427_: vec4<f32>;
    var phi_428_: u32;
    var phi_461_: u32;
    var phi_462_: u32;
    var phi_463_: vec4<f32>;
    var phi_464_: u32;
    var phi_626_: u32;
    var phi_627_: u32;
    var phi_628_: vec4<f32>;
    var phi_629_: u32;
    var phi_661_: u32;
    var phi_662_: u32;
    var phi_663_: vec4<f32>;
    var phi_664_: u32;
    var phi_697_: u32;
    var phi_698_: u32;
    var phi_699_: vec4<f32>;
    var phi_700_: u32;
    var phi_859_: u32;
    var phi_860_: u32;
    var phi_861_: vec4<f32>;
    var phi_862_: u32;
    var phi_894_: u32;
    var phi_895_: u32;
    var phi_896_: vec4<f32>;
    var phi_897_: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: vec4<f32>;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;

    let _e55 = global_3;
    let _e56 = _e55.xy;
    let _e61 = (_e55.x | (_e55.y << bitcast<u32>(16)));
    let _e65 = ((_e61 | (_e61 << bitcast<u32>(4))) & 252645135u);
    let _e69 = ((_e65 | (_e65 << bitcast<u32>(2))) & 858993459u);
    let _e73 = ((_e69 | (_e69 << bitcast<u32>(1))) & 1431655765u);
    let _e77 = ((_e73 | (_e73 >> bitcast<u32>(15))) & 65535u);
    let _e78 = vec2<f32>(_e56);
    let _e80 = vec2<f32>((_e56 + vec2<u32>(1u, 1u)));
    let _e86 = (vec4<f32>(_e78.x, _e78.y, _e80.x, _e80.y) * vec4<f32>(0.14285715, 0.14285715, 0.14285715, 0.14285715));
    phi_127_ = 0u;
    phi_130_ = 0u;
    phi_132_ = vec4<f32>(1.0, 1.0, -1.0, -1.0);
    phi_134_ = 0u;
    phi_136_ = 0u;
    loop {
        let _e88 = phi_127_;
        let _e90 = phi_130_;
        let _e92 = phi_132_;
        let _e94 = phi_134_;
        let _e96 = phi_136_;
        let _e98 = global_4.member;
        local = _e94;
        local_1 = _e94;
        local_3 = _e92;
        local_4 = _e94;
        local_12 = _e90;
        local_5 = _e88;
        if (_e96 < _e98) {
            let _e102 = global_5.member[_e96];
            let _e103 = _e102.xy;
            let _e104 = _e102.zw;
            let _e106 = ((_e103 + _e104) * 0.5);
            let _e109 = all((_e106 >= _e86.xy));
            phi_157_ = _e109;
            if _e109 {
                phi_157_ = all((_e106 < _e86.zw));
            }
            let _e114 = phi_157_;
            phi_128_ = _e88;
            phi_131_ = _e90;
            phi_133_ = _e92;
            phi_135_ = _e94;
            if _e114 {
                let _e118 = min(_e103, _e104);
                let _e119 = max(_e103, _e104);
                let _e124 = vec4<f32>(_e118.x, _e118.y, _e119.x, _e119.y);
                let _e127 = min(_e92.xy, _e124.xy);
                let _e130 = max(_e92.zw, _e124.zw);
                phi_128_ = (_e96 + 1u);
                phi_131_ = select(_e90, _e96, (_e94 == 0u));
                phi_133_ = vec4<f32>(_e127.x, _e127.y, _e130.x, _e130.y);
                phi_135_ = (_e94 + bitcast<u32>(1));
            }
            let _e139 = phi_128_;
            let _e141 = phi_131_;
            let _e143 = phi_133_;
            let _e145 = phi_135_;
            local_6 = _e139;
            local_7 = _e141;
            local_8 = _e143;
            local_9 = _e145;
            continue;
        } else {
            break;
        }
        continuing {
            let _e898 = local_6;
            phi_127_ = _e898;
            let _e901 = local_7;
            phi_130_ = _e901;
            let _e904 = local_8;
            phi_132_ = _e904;
            let _e907 = local_9;
            phi_134_ = _e907;
            phi_136_ = (_e96 + bitcast<u32>(1));
        }
    }
    let _e150 = local;
    global_6[_e77] = _e150;
    workgroupBarrier();
    phi_184_ = 189u;
    phi_187_ = 0u;
    loop {
        let _e152 = phi_184_;
        let _e154 = phi_187_;
        local_2 = _e152;
        local_10 = _e152;
        if (_e154 < _e77) {
            continue;
        } else {
            break;
        }
        continuing {
            let _e157 = global_6[_e154];
            phi_184_ = (_e152 + _e157);
            phi_187_ = (_e154 + bitcast<u32>(1));
        }
    }
    let _e162 = local_1;
    let _e166 = local_2;
    let _e169 = local_3;
    let _e171 = local_4;
    global_1[_e77] = type_3(1u, (_e166 | (_e162 << bitcast<u32>(24))), _e169, _e171);
    workgroupBarrier();
    let _e923 = local_10;
    phi_198_ = _e923;
    let _e928 = local_12;
    phi_201_ = _e928;
    loop {
        let _e175 = phi_198_;
        let _e177 = phi_201_;
        let _e179 = local_5;
        if (_e177 < _e179) {
            let _e183 = global_5.member[_e177];
            let _e184 = _e183.xy;
            let _e185 = _e183.zw;
            let _e187 = ((_e184 + _e185) * 0.5);
            let _e190 = all((_e187 >= _e86.xy));
            phi_220_ = _e190;
            if _e190 {
                phi_220_ = all((_e187 < _e86.zw));
            }
            let _e195 = phi_220_;
            phi_199_ = _e175;
            if _e195 {
                let _e198 = (_e184 - _e185);
                global.member[_e175] = vec4<f32>(_e183.x, _e183.y, _e198.x, _e198.y);
                phi_199_ = (_e175 + bitcast<u32>(1));
            }
            let _e207 = phi_199_;
            local_11 = _e207;
            continue;
        } else {
            break;
        }
        continuing {
            let _e925 = local_11;
            phi_198_ = _e925;
            phi_201_ = (_e177 + bitcast<u32>(1));
        }
    }
    if all((_e56 < vec2<u32>(4u, 4u))) {
        let _e214 = (_e56 * vec2<u32>(2u, 2u));
        let _e219 = (_e214 + vec2<u32>(1u, 0u));
        let _e224 = (_e214 + vec2<u32>(0u, 1u));
        let _e229 = (_e214 + vec2<u32>(1u, 1u));
        let _e235 = global_1[((_e214.y * 8u) + _e214.x)];
        let _e241 = global_1[((_e219.y * 8u) + _e219.x)];
        let _e247 = global_1[((_e224.y * 8u) + _e224.x)];
        let _e253 = global_1[((_e229.y * 8u) + _e229.x)];
        let _e258 = (9u * _e77);
        let _e259 = (45u + _e258);
        let _e260 = _e235.member_2.xy;
        let _e261 = _e241.member_2.xy;
        let _e262 = min(_e260, _e261);
        let _e263 = _e235.member_2.zw;
        let _e264 = _e241.member_2.zw;
        let _e265 = max(_e263, _e264);
        let _e270 = vec4<f32>(_e262.x, _e262.y, _e265.x, _e265.y);
        let _e273 = (_e270.zw - _e270.xy);
        let _e278 = _e247.member_2.xy;
        let _e279 = min(_e260, _e278);
        let _e280 = _e247.member_2.zw;
        let _e281 = max(_e263, _e280);
        let _e286 = vec4<f32>(_e279.x, _e279.y, _e281.x, _e281.y);
        let _e289 = (_e286.zw - _e286.xy);
        let _e294 = _e253.member_2.xy;
        let _e295 = min(_e278, _e294);
        let _e296 = _e253.member_2.zw;
        let _e297 = max(_e280, _e296);
        let _e302 = vec4<f32>(_e295.x, _e295.y, _e297.x, _e297.y);
        let _e305 = (_e302.zw - _e302.xy);
        let _e310 = min(_e261, _e294);
        let _e311 = max(_e264, _e296);
        let _e316 = vec4<f32>(_e310.x, _e310.y, _e311.x, _e311.y);
        let _e319 = (_e316.zw - _e316.xy);
        let _e326 = ((max(0.0, (_e273.x * _e273.y)) + max(0.0, (_e305.x * _e305.y))) > (max(0.0, (_e289.x * _e289.y)) + max(0.0, (_e319.x * _e319.y))));
        let _e327 = select(_e247.member, _e241.member, _e326);
        let _e328 = select(_e247.member_1, _e241.member_1, _e326);
        let _e329 = vec4(_e326);
        let _e330 = select(_e247.member_2, _e241.member_2, _e329);
        let _e331 = select(_e247.member_3, _e241.member_3, _e326);
        let _e332 = select(_e241.member, _e247.member, _e326);
        let _e333 = select(_e241.member_1, _e247.member_1, _e326);
        let _e334 = select(_e241.member_2, _e247.member_2, _e329);
        let _e335 = select(_e241.member_3, _e247.member_3, _e326);
        let _e336 = (_e258 + 48u);
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e336] = bitcast<vec4<f32>>(vec4<u32>(_e235.member, _e235.member_1, _e332, _e333));
                let _e343 = (_e235.member_3 == 0u);
                global.member[(_e258 + 49u)] = select(_e235.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e343));
                let _e349 = (_e335 == 0u);
                global.member[(_e258 + 50u)] = select(_e334, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e349));
                if _e349 {
                    phi_390_ = _e235.member;
                    phi_391_ = _e235.member_1;
                    phi_392_ = _e235.member_2;
                    phi_393_ = _e235.member_3;
                    break;
                } else {
                    if _e343 {
                        phi_390_ = _e332;
                        phi_391_ = _e333;
                        phi_392_ = _e334;
                        phi_393_ = _e335;
                        break;
                    }
                }
                let _e356 = min(_e260, _e334.xy);
                let _e358 = max(_e263, _e334.zw);
                phi_390_ = 0u;
                phi_391_ = _e336;
                phi_392_ = vec4<f32>(_e356.x, _e356.y, _e358.x, _e358.y);
                phi_393_ = (_e235.member_3 + _e335);
                break;
            }
        }
        let _e365 = phi_390_;
        let _e367 = phi_391_;
        let _e369 = phi_392_;
        let _e371 = phi_393_;
        let _e372 = (_e258 + 51u);
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e372] = bitcast<vec4<f32>>(vec4<u32>(_e327, _e328, _e253.member, _e253.member_1));
                let _e379 = (_e331 == 0u);
                global.member[(_e258 + 52u)] = select(_e330, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e379));
                let _e385 = (_e253.member_3 == 0u);
                global.member[(_e258 + 53u)] = select(_e253.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e385));
                if _e385 {
                    phi_425_ = _e327;
                    phi_426_ = _e328;
                    phi_427_ = _e330;
                    phi_428_ = _e331;
                    break;
                } else {
                    if _e379 {
                        phi_425_ = _e253.member;
                        phi_426_ = _e253.member_1;
                        phi_427_ = _e253.member_2;
                        phi_428_ = _e253.member_3;
                        break;
                    }
                }
                let _e392 = min(_e330.xy, _e294);
                let _e394 = max(_e330.zw, _e296);
                phi_425_ = 0u;
                phi_426_ = _e372;
                phi_427_ = vec4<f32>(_e392.x, _e392.y, _e394.x, _e394.y);
                phi_428_ = (_e331 + _e253.member_3);
                break;
            }
        }
        let _e401 = phi_425_;
        let _e403 = phi_426_;
        let _e405 = phi_427_;
        let _e407 = phi_428_;
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e259] = bitcast<vec4<f32>>(vec4<u32>(_e365, _e367, _e401, _e403));
                let _e414 = (_e371 == 0u);
                global.member[(_e258 + 46u)] = select(_e369, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e414));
                let _e420 = (_e407 == 0u);
                global.member[(_e258 + 47u)] = select(_e405, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e420));
                if _e420 {
                    phi_461_ = _e365;
                    phi_462_ = _e367;
                    phi_463_ = _e369;
                    phi_464_ = _e371;
                    break;
                } else {
                    if _e414 {
                        phi_461_ = _e401;
                        phi_462_ = _e403;
                        phi_463_ = _e405;
                        phi_464_ = _e407;
                        break;
                    }
                }
                let _e428 = min(_e369.xy, _e405.xy);
                let _e431 = max(_e369.zw, _e405.zw);
                phi_461_ = 0u;
                phi_462_ = _e259;
                phi_463_ = vec4<f32>(_e428.x, _e428.y, _e431.x, _e431.y);
                phi_464_ = (_e371 + _e407);
                break;
            }
        }
        let _e438 = phi_461_;
        let _e440 = phi_462_;
        let _e442 = phi_463_;
        let _e444 = phi_464_;
        global_2[((_e55.y * 4u) + _e55.x)] = type_3(_e438, _e440, _e442, _e444);
    }
    workgroupBarrier();
    if all((_e56 < vec2<u32>(2u, 2u))) {
        let _e451 = (_e56 * vec2<u32>(2u, 2u));
        let _e456 = (_e451 + vec2<u32>(1u, 0u));
        let _e461 = (_e451 + vec2<u32>(0u, 1u));
        let _e466 = (_e451 + vec2<u32>(1u, 1u));
        let _e472 = global_2[((_e451.y * 4u) + _e451.x)];
        let _e478 = global_2[((_e456.y * 4u) + _e456.x)];
        let _e484 = global_2[((_e461.y * 4u) + _e461.x)];
        let _e490 = global_2[((_e466.y * 4u) + _e466.x)];
        let _e495 = (9u * _e77);
        let _e496 = (9u + _e495);
        let _e497 = _e472.member_2.xy;
        let _e498 = _e478.member_2.xy;
        let _e499 = min(_e497, _e498);
        let _e500 = _e472.member_2.zw;
        let _e501 = _e478.member_2.zw;
        let _e502 = max(_e500, _e501);
        let _e507 = vec4<f32>(_e499.x, _e499.y, _e502.x, _e502.y);
        let _e510 = (_e507.zw - _e507.xy);
        let _e515 = _e484.member_2.xy;
        let _e516 = min(_e497, _e515);
        let _e517 = _e484.member_2.zw;
        let _e518 = max(_e500, _e517);
        let _e523 = vec4<f32>(_e516.x, _e516.y, _e518.x, _e518.y);
        let _e526 = (_e523.zw - _e523.xy);
        let _e531 = _e490.member_2.xy;
        let _e532 = min(_e515, _e531);
        let _e533 = _e490.member_2.zw;
        let _e534 = max(_e517, _e533);
        let _e539 = vec4<f32>(_e532.x, _e532.y, _e534.x, _e534.y);
        let _e542 = (_e539.zw - _e539.xy);
        let _e547 = min(_e498, _e531);
        let _e548 = max(_e501, _e533);
        let _e553 = vec4<f32>(_e547.x, _e547.y, _e548.x, _e548.y);
        let _e556 = (_e553.zw - _e553.xy);
        let _e563 = ((max(0.0, (_e510.x * _e510.y)) + max(0.0, (_e542.x * _e542.y))) > (max(0.0, (_e526.x * _e526.y)) + max(0.0, (_e556.x * _e556.y))));
        let _e564 = select(_e484.member, _e478.member, _e563);
        let _e565 = select(_e484.member_1, _e478.member_1, _e563);
        let _e566 = vec4(_e563);
        let _e567 = select(_e484.member_2, _e478.member_2, _e566);
        let _e568 = select(_e484.member_3, _e478.member_3, _e563);
        let _e569 = select(_e478.member, _e484.member, _e563);
        let _e570 = select(_e478.member_1, _e484.member_1, _e563);
        let _e571 = select(_e478.member_2, _e484.member_2, _e566);
        let _e572 = select(_e478.member_3, _e484.member_3, _e563);
        let _e573 = (_e495 + 12u);
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e573] = bitcast<vec4<f32>>(vec4<u32>(_e472.member, _e472.member_1, _e569, _e570));
                let _e580 = (_e472.member_3 == 0u);
                global.member[(_e495 + 13u)] = select(_e472.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e580));
                let _e586 = (_e572 == 0u);
                global.member[(_e495 + 14u)] = select(_e571, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e586));
                if _e586 {
                    phi_626_ = _e472.member;
                    phi_627_ = _e472.member_1;
                    phi_628_ = _e472.member_2;
                    phi_629_ = _e472.member_3;
                    break;
                } else {
                    if _e580 {
                        phi_626_ = _e569;
                        phi_627_ = _e570;
                        phi_628_ = _e571;
                        phi_629_ = _e572;
                        break;
                    }
                }
                let _e593 = min(_e497, _e571.xy);
                let _e595 = max(_e500, _e571.zw);
                phi_626_ = 0u;
                phi_627_ = _e573;
                phi_628_ = vec4<f32>(_e593.x, _e593.y, _e595.x, _e595.y);
                phi_629_ = (_e472.member_3 + _e572);
                break;
            }
        }
        let _e602 = phi_626_;
        let _e604 = phi_627_;
        let _e606 = phi_628_;
        let _e608 = phi_629_;
        let _e609 = (_e495 + 15u);
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e609] = bitcast<vec4<f32>>(vec4<u32>(_e564, _e565, _e490.member, _e490.member_1));
                let _e616 = (_e568 == 0u);
                global.member[(_e495 + 16u)] = select(_e567, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e616));
                let _e622 = (_e490.member_3 == 0u);
                global.member[(_e495 + 17u)] = select(_e490.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e622));
                if _e622 {
                    phi_661_ = _e564;
                    phi_662_ = _e565;
                    phi_663_ = _e567;
                    phi_664_ = _e568;
                    break;
                } else {
                    if _e616 {
                        phi_661_ = _e490.member;
                        phi_662_ = _e490.member_1;
                        phi_663_ = _e490.member_2;
                        phi_664_ = _e490.member_3;
                        break;
                    }
                }
                let _e629 = min(_e567.xy, _e531);
                let _e631 = max(_e567.zw, _e533);
                phi_661_ = 0u;
                phi_662_ = _e609;
                phi_663_ = vec4<f32>(_e629.x, _e629.y, _e631.x, _e631.y);
                phi_664_ = (_e568 + _e490.member_3);
                break;
            }
        }
        let _e638 = phi_661_;
        let _e640 = phi_662_;
        let _e642 = phi_663_;
        let _e644 = phi_664_;
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e496] = bitcast<vec4<f32>>(vec4<u32>(_e602, _e604, _e638, _e640));
                let _e651 = (_e608 == 0u);
                global.member[(_e495 + 10u)] = select(_e606, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e651));
                let _e657 = (_e644 == 0u);
                global.member[(_e495 + 11u)] = select(_e642, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e657));
                if _e657 {
                    phi_697_ = _e602;
                    phi_698_ = _e604;
                    phi_699_ = _e606;
                    phi_700_ = _e608;
                    break;
                } else {
                    if _e651 {
                        phi_697_ = _e638;
                        phi_698_ = _e640;
                        phi_699_ = _e642;
                        phi_700_ = _e644;
                        break;
                    }
                }
                let _e665 = min(_e606.xy, _e642.xy);
                let _e668 = max(_e606.zw, _e642.zw);
                phi_697_ = 0u;
                phi_698_ = _e496;
                phi_699_ = vec4<f32>(_e665.x, _e665.y, _e668.x, _e668.y);
                phi_700_ = (_e608 + _e644);
                break;
            }
        }
        let _e675 = phi_697_;
        let _e677 = phi_698_;
        let _e679 = phi_699_;
        let _e681 = phi_700_;
        global_1[((_e55.y * 2u) + _e55.x)] = type_3(_e675, _e677, _e679, _e681);
    }
    if all((_e56 < vec2<u32>(1u, 1u))) {
        let _e686 = (_e56 * vec2<u32>(2u, 2u));
        let _e691 = (_e686 + vec2<u32>(1u, 0u));
        let _e696 = (_e686 + vec2<u32>(0u, 1u));
        let _e701 = (_e686 + vec2<u32>(1u, 1u));
        let _e707 = global_1[((_e686.y * 2u) + _e686.x)];
        let _e713 = global_1[((_e691.y * 2u) + _e691.x)];
        let _e719 = global_1[((_e696.y * 2u) + _e696.x)];
        let _e725 = global_1[((_e701.y * 2u) + _e701.x)];
        let _e730 = (9u * _e77);
        let _e731 = _e707.member_2.xy;
        let _e732 = _e713.member_2.xy;
        let _e733 = min(_e731, _e732);
        let _e734 = _e707.member_2.zw;
        let _e735 = _e713.member_2.zw;
        let _e736 = max(_e734, _e735);
        let _e741 = vec4<f32>(_e733.x, _e733.y, _e736.x, _e736.y);
        let _e744 = (_e741.zw - _e741.xy);
        let _e749 = _e719.member_2.xy;
        let _e750 = min(_e731, _e749);
        let _e751 = _e719.member_2.zw;
        let _e752 = max(_e734, _e751);
        let _e757 = vec4<f32>(_e750.x, _e750.y, _e752.x, _e752.y);
        let _e760 = (_e757.zw - _e757.xy);
        let _e765 = _e725.member_2.xy;
        let _e766 = min(_e749, _e765);
        let _e767 = _e725.member_2.zw;
        let _e768 = max(_e751, _e767);
        let _e773 = vec4<f32>(_e766.x, _e766.y, _e768.x, _e768.y);
        let _e776 = (_e773.zw - _e773.xy);
        let _e781 = min(_e732, _e765);
        let _e782 = max(_e735, _e767);
        let _e787 = vec4<f32>(_e781.x, _e781.y, _e782.x, _e782.y);
        let _e790 = (_e787.zw - _e787.xy);
        let _e797 = ((max(0.0, (_e744.x * _e744.y)) + max(0.0, (_e776.x * _e776.y))) > (max(0.0, (_e760.x * _e760.y)) + max(0.0, (_e790.x * _e790.y))));
        let _e798 = select(_e719.member, _e713.member, _e797);
        let _e799 = select(_e719.member_1, _e713.member_1, _e797);
        let _e800 = vec4(_e797);
        let _e801 = select(_e719.member_2, _e713.member_2, _e800);
        let _e802 = select(_e719.member_3, _e713.member_3, _e797);
        let _e803 = select(_e713.member, _e719.member, _e797);
        let _e804 = select(_e713.member_1, _e719.member_1, _e797);
        let _e805 = select(_e713.member_2, _e719.member_2, _e800);
        let _e806 = select(_e713.member_3, _e719.member_3, _e797);
        let _e807 = (_e730 + 3u);
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e807] = bitcast<vec4<f32>>(vec4<u32>(_e707.member, _e707.member_1, _e803, _e804));
                let _e814 = (_e707.member_3 == 0u);
                global.member[(_e730 + 4u)] = select(_e707.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e814));
                let _e820 = (_e806 == 0u);
                global.member[(_e730 + 5u)] = select(_e805, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e820));
                if _e820 {
                    phi_859_ = _e707.member;
                    phi_860_ = _e707.member_1;
                    phi_861_ = _e707.member_2;
                    phi_862_ = _e707.member_3;
                    break;
                } else {
                    if _e814 {
                        phi_859_ = _e803;
                        phi_860_ = _e804;
                        phi_861_ = _e805;
                        phi_862_ = _e806;
                        break;
                    }
                }
                let _e827 = min(_e731, _e805.xy);
                let _e829 = max(_e734, _e805.zw);
                phi_859_ = 0u;
                phi_860_ = _e807;
                phi_861_ = vec4<f32>(_e827.x, _e827.y, _e829.x, _e829.y);
                phi_862_ = (_e707.member_3 + _e806);
                break;
            }
        }
        let _e836 = phi_859_;
        let _e838 = phi_860_;
        let _e840 = phi_861_;
        let _e842 = phi_862_;
        let _e843 = (_e730 + 6u);
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e843] = bitcast<vec4<f32>>(vec4<u32>(_e798, _e799, _e725.member, _e725.member_1));
                let _e850 = (_e802 == 0u);
                global.member[(_e730 + 7u)] = select(_e801, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e850));
                let _e856 = (_e725.member_3 == 0u);
                global.member[(_e730 + 8u)] = select(_e725.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e856));
                if _e856 {
                    phi_894_ = _e798;
                    phi_895_ = _e799;
                    phi_896_ = _e801;
                    phi_897_ = _e802;
                    break;
                } else {
                    if _e850 {
                        phi_894_ = _e725.member;
                        phi_895_ = _e725.member_1;
                        phi_896_ = _e725.member_2;
                        phi_897_ = _e725.member_3;
                        break;
                    }
                }
                let _e863 = min(_e801.xy, _e765);
                let _e865 = max(_e801.zw, _e767);
                phi_894_ = 0u;
                phi_895_ = _e843;
                phi_896_ = vec4<f32>(_e863.x, _e863.y, _e865.x, _e865.y);
                phi_897_ = (_e802 + _e725.member_3);
                break;
            }
        }
        let _e872 = phi_894_;
        let _e874 = phi_895_;
        let _e876 = phi_896_;
        let _e878 = phi_897_;
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e730] = bitcast<vec4<f32>>(vec4<u32>(_e836, _e838, _e872, _e874));
                let _e885 = (_e842 == 0u);
                global.member[(_e730 + 1u)] = select(_e840, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e885));
                let _e891 = (_e878 == 0u);
                global.member[(_e730 + 2u)] = select(_e876, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e891));
                if _e891 {
                    break;
                } else {
                    if _e885 {
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
