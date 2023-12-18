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
var<workgroup> global_1: array<type_3, 256>;
var<workgroup> global_2: array<type_3, 64>;
var<private> global_3: vec3<u32>;
@group(0) @binding(2) 
var<uniform> global_4: type_13;
@group(0) @binding(0) 
var<storage, read_write> global_5: type_9;
var<workgroup> global_6: array<u32, 256>;

fn function() {
    var phi_138_: u32;
    var phi_141_: u32;
    var phi_143_: vec4<f32>;
    var phi_145_: u32;
    var phi_147_: u32;
    var phi_168_: bool;
    var phi_139_: u32;
    var phi_142_: u32;
    var phi_144_: vec4<f32>;
    var phi_146_: u32;
    var local: u32;
    var phi_195_: u32;
    var phi_198_: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: vec4<f32>;
    var local_4: u32;
    var phi_209_: u32;
    var phi_212_: u32;
    var local_5: u32;
    var phi_231_: bool;
    var phi_210_: u32;
    var phi_401_: u32;
    var phi_402_: u32;
    var phi_403_: vec4<f32>;
    var phi_404_: u32;
    var phi_436_: u32;
    var phi_437_: u32;
    var phi_438_: vec4<f32>;
    var phi_439_: u32;
    var phi_472_: u32;
    var phi_473_: u32;
    var phi_474_: vec4<f32>;
    var phi_475_: u32;
    var phi_637_: u32;
    var phi_638_: u32;
    var phi_639_: vec4<f32>;
    var phi_640_: u32;
    var phi_672_: u32;
    var phi_673_: u32;
    var phi_674_: vec4<f32>;
    var phi_675_: u32;
    var phi_708_: u32;
    var phi_709_: u32;
    var phi_710_: vec4<f32>;
    var phi_711_: u32;
    var phi_873_: u32;
    var phi_874_: u32;
    var phi_875_: vec4<f32>;
    var phi_876_: u32;
    var phi_908_: u32;
    var phi_909_: u32;
    var phi_910_: vec4<f32>;
    var phi_911_: u32;
    var phi_944_: u32;
    var phi_945_: u32;
    var phi_946_: vec4<f32>;
    var phi_947_: u32;
    var phi_1106_: u32;
    var phi_1107_: u32;
    var phi_1108_: vec4<f32>;
    var phi_1109_: u32;
    var phi_1141_: u32;
    var phi_1142_: u32;
    var phi_1143_: vec4<f32>;
    var phi_1144_: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: vec4<f32>;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;

    let _e65 = global_3;
    let _e66 = _e65.xy;
    let _e71 = (_e65.x | (_e65.y << bitcast<u32>(16)));
    let _e75 = ((_e71 | (_e71 << bitcast<u32>(4))) & 252645135u);
    let _e79 = ((_e75 | (_e75 << bitcast<u32>(2))) & 858993459u);
    let _e83 = ((_e79 | (_e79 << bitcast<u32>(1))) & 1431655765u);
    let _e87 = ((_e83 | (_e83 >> bitcast<u32>(15))) & 65535u);
    let _e88 = vec2<f32>(_e66);
    let _e90 = vec2<f32>((_e66 + vec2<u32>(1u, 1u)));
    let _e96 = (vec4<f32>(_e88.x, _e88.y, _e90.x, _e90.y) * vec4<f32>(0.06666667, 0.06666667, 0.06666667, 0.06666667));
    phi_138_ = 0u;
    phi_141_ = 0u;
    phi_143_ = vec4<f32>(1.0, 1.0, -1.0, -1.0);
    phi_145_ = 0u;
    phi_147_ = 0u;
    loop {
        let _e98 = phi_138_;
        let _e100 = phi_141_;
        let _e102 = phi_143_;
        let _e104 = phi_145_;
        let _e106 = phi_147_;
        let _e108 = global_4.member;
        local = _e104;
        local_1 = _e104;
        local_3 = _e102;
        local_4 = _e104;
        local_12 = _e100;
        local_5 = _e98;
        if (_e106 < _e108) {
            let _e112 = global_5.member[_e106];
            let _e113 = _e112.xy;
            let _e114 = _e112.zw;
            let _e116 = ((_e113 + _e114) * 0.5);
            let _e119 = all((_e116 >= _e96.xy));
            phi_168_ = _e119;
            if _e119 {
                phi_168_ = all((_e116 < _e96.zw));
            }
            let _e124 = phi_168_;
            phi_139_ = _e98;
            phi_142_ = _e100;
            phi_144_ = _e102;
            phi_146_ = _e104;
            if _e124 {
                let _e128 = min(_e113, _e114);
                let _e129 = max(_e113, _e114);
                let _e134 = vec4<f32>(_e128.x, _e128.y, _e129.x, _e129.y);
                let _e137 = min(_e102.xy, _e134.xy);
                let _e140 = max(_e102.zw, _e134.zw);
                phi_139_ = (_e106 + 1u);
                phi_142_ = select(_e100, _e106, (_e104 == 0u));
                phi_144_ = vec4<f32>(_e137.x, _e137.y, _e140.x, _e140.y);
                phi_146_ = (_e104 + bitcast<u32>(1));
            }
            let _e149 = phi_139_;
            let _e151 = phi_142_;
            let _e153 = phi_144_;
            let _e155 = phi_146_;
            local_6 = _e149;
            local_7 = _e151;
            local_8 = _e153;
            local_9 = _e155;
            continue;
        } else {
            break;
        }
        continuing {
            let _e1145 = local_6;
            phi_138_ = _e1145;
            let _e1148 = local_7;
            phi_141_ = _e1148;
            let _e1151 = local_8;
            phi_143_ = _e1151;
            let _e1154 = local_9;
            phi_145_ = _e1154;
            phi_147_ = (_e106 + bitcast<u32>(1));
        }
    }
    let _e160 = local;
    global_6[_e87] = _e160;
    workgroupBarrier();
    phi_195_ = 765u;
    phi_198_ = 0u;
    loop {
        let _e162 = phi_195_;
        let _e164 = phi_198_;
        local_2 = _e162;
        local_10 = _e162;
        if (_e164 < _e87) {
            continue;
        } else {
            break;
        }
        continuing {
            let _e167 = global_6[_e164];
            phi_195_ = (_e162 + _e167);
            phi_198_ = (_e164 + bitcast<u32>(1));
        }
    }
    let _e172 = local_1;
    let _e176 = local_2;
    let _e179 = local_3;
    let _e181 = local_4;
    global_1[_e87] = type_3(1u, (_e176 | (_e172 << bitcast<u32>(24))), _e179, _e181);
    workgroupBarrier();
    let _e1170 = local_10;
    phi_209_ = _e1170;
    let _e1175 = local_12;
    phi_212_ = _e1175;
    loop {
        let _e185 = phi_209_;
        let _e187 = phi_212_;
        let _e189 = local_5;
        if (_e187 < _e189) {
            let _e193 = global_5.member[_e187];
            let _e194 = _e193.xy;
            let _e195 = _e193.zw;
            let _e197 = ((_e194 + _e195) * 0.5);
            let _e200 = all((_e197 >= _e96.xy));
            phi_231_ = _e200;
            if _e200 {
                phi_231_ = all((_e197 < _e96.zw));
            }
            let _e205 = phi_231_;
            phi_210_ = _e185;
            if _e205 {
                let _e208 = (_e194 - _e195);
                global.member[_e185] = vec4<f32>(_e193.x, _e193.y, _e208.x, _e208.y);
                phi_210_ = (_e185 + bitcast<u32>(1));
            }
            let _e217 = phi_210_;
            local_11 = _e217;
            continue;
        } else {
            break;
        }
        continuing {
            let _e1172 = local_11;
            phi_209_ = _e1172;
            phi_212_ = (_e187 + bitcast<u32>(1));
        }
    }
    if all((_e66 < vec2<u32>(8u, 8u))) {
        let _e224 = (_e66 * vec2<u32>(2u, 2u));
        let _e229 = (_e224 + vec2<u32>(1u, 0u));
        let _e234 = (_e224 + vec2<u32>(0u, 1u));
        let _e239 = (_e224 + vec2<u32>(1u, 1u));
        let _e245 = global_1[((_e224.y * 16u) + _e224.x)];
        let _e251 = global_1[((_e229.y * 16u) + _e229.x)];
        let _e257 = global_1[((_e234.y * 16u) + _e234.x)];
        let _e263 = global_1[((_e239.y * 16u) + _e239.x)];
        let _e268 = (9u * _e87);
        let _e269 = (189u + _e268);
        let _e270 = _e245.member_2.xy;
        let _e271 = _e251.member_2.xy;
        let _e272 = min(_e270, _e271);
        let _e273 = _e245.member_2.zw;
        let _e274 = _e251.member_2.zw;
        let _e275 = max(_e273, _e274);
        let _e280 = vec4<f32>(_e272.x, _e272.y, _e275.x, _e275.y);
        let _e283 = (_e280.zw - _e280.xy);
        let _e288 = _e257.member_2.xy;
        let _e289 = min(_e270, _e288);
        let _e290 = _e257.member_2.zw;
        let _e291 = max(_e273, _e290);
        let _e296 = vec4<f32>(_e289.x, _e289.y, _e291.x, _e291.y);
        let _e299 = (_e296.zw - _e296.xy);
        let _e304 = _e263.member_2.xy;
        let _e305 = min(_e288, _e304);
        let _e306 = _e263.member_2.zw;
        let _e307 = max(_e290, _e306);
        let _e312 = vec4<f32>(_e305.x, _e305.y, _e307.x, _e307.y);
        let _e315 = (_e312.zw - _e312.xy);
        let _e320 = min(_e271, _e304);
        let _e321 = max(_e274, _e306);
        let _e326 = vec4<f32>(_e320.x, _e320.y, _e321.x, _e321.y);
        let _e329 = (_e326.zw - _e326.xy);
        let _e336 = ((max(0.0, (_e283.x * _e283.y)) + max(0.0, (_e315.x * _e315.y))) > (max(0.0, (_e299.x * _e299.y)) + max(0.0, (_e329.x * _e329.y))));
        let _e337 = select(_e257.member, _e251.member, _e336);
        let _e338 = select(_e257.member_1, _e251.member_1, _e336);
        let _e339 = vec4(_e336);
        let _e340 = select(_e257.member_2, _e251.member_2, _e339);
        let _e341 = select(_e257.member_3, _e251.member_3, _e336);
        let _e342 = select(_e251.member, _e257.member, _e336);
        let _e343 = select(_e251.member_1, _e257.member_1, _e336);
        let _e344 = select(_e251.member_2, _e257.member_2, _e339);
        let _e345 = select(_e251.member_3, _e257.member_3, _e336);
        let _e346 = (_e268 + 192u);
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e346] = bitcast<vec4<f32>>(vec4<u32>(_e245.member, _e245.member_1, _e342, _e343));
                let _e353 = (_e245.member_3 == 0u);
                global.member[(_e268 + 193u)] = select(_e245.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e353));
                let _e359 = (_e345 == 0u);
                global.member[(_e268 + 194u)] = select(_e344, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e359));
                if _e359 {
                    phi_401_ = _e245.member;
                    phi_402_ = _e245.member_1;
                    phi_403_ = _e245.member_2;
                    phi_404_ = _e245.member_3;
                    break;
                } else {
                    if _e353 {
                        phi_401_ = _e342;
                        phi_402_ = _e343;
                        phi_403_ = _e344;
                        phi_404_ = _e345;
                        break;
                    }
                }
                let _e366 = min(_e270, _e344.xy);
                let _e368 = max(_e273, _e344.zw);
                phi_401_ = 0u;
                phi_402_ = _e346;
                phi_403_ = vec4<f32>(_e366.x, _e366.y, _e368.x, _e368.y);
                phi_404_ = (_e245.member_3 + _e345);
                break;
            }
        }
        let _e375 = phi_401_;
        let _e377 = phi_402_;
        let _e379 = phi_403_;
        let _e381 = phi_404_;
        let _e382 = (_e268 + 195u);
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e382] = bitcast<vec4<f32>>(vec4<u32>(_e337, _e338, _e263.member, _e263.member_1));
                let _e389 = (_e341 == 0u);
                global.member[(_e268 + 196u)] = select(_e340, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e389));
                let _e395 = (_e263.member_3 == 0u);
                global.member[(_e268 + 197u)] = select(_e263.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e395));
                if _e395 {
                    phi_436_ = _e337;
                    phi_437_ = _e338;
                    phi_438_ = _e340;
                    phi_439_ = _e341;
                    break;
                } else {
                    if _e389 {
                        phi_436_ = _e263.member;
                        phi_437_ = _e263.member_1;
                        phi_438_ = _e263.member_2;
                        phi_439_ = _e263.member_3;
                        break;
                    }
                }
                let _e402 = min(_e340.xy, _e304);
                let _e404 = max(_e340.zw, _e306);
                phi_436_ = 0u;
                phi_437_ = _e382;
                phi_438_ = vec4<f32>(_e402.x, _e402.y, _e404.x, _e404.y);
                phi_439_ = (_e341 + _e263.member_3);
                break;
            }
        }
        let _e411 = phi_436_;
        let _e413 = phi_437_;
        let _e415 = phi_438_;
        let _e417 = phi_439_;
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e269] = bitcast<vec4<f32>>(vec4<u32>(_e375, _e377, _e411, _e413));
                let _e424 = (_e381 == 0u);
                global.member[(_e268 + 190u)] = select(_e379, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e424));
                let _e430 = (_e417 == 0u);
                global.member[(_e268 + 191u)] = select(_e415, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e430));
                if _e430 {
                    phi_472_ = _e375;
                    phi_473_ = _e377;
                    phi_474_ = _e379;
                    phi_475_ = _e381;
                    break;
                } else {
                    if _e424 {
                        phi_472_ = _e411;
                        phi_473_ = _e413;
                        phi_474_ = _e415;
                        phi_475_ = _e417;
                        break;
                    }
                }
                let _e438 = min(_e379.xy, _e415.xy);
                let _e441 = max(_e379.zw, _e415.zw);
                phi_472_ = 0u;
                phi_473_ = _e269;
                phi_474_ = vec4<f32>(_e438.x, _e438.y, _e441.x, _e441.y);
                phi_475_ = (_e381 + _e417);
                break;
            }
        }
        let _e448 = phi_472_;
        let _e450 = phi_473_;
        let _e452 = phi_474_;
        let _e454 = phi_475_;
        global_2[((_e65.y * 8u) + _e65.x)] = type_3(_e448, _e450, _e452, _e454);
    }
    workgroupBarrier();
    if all((_e66 < vec2<u32>(4u, 4u))) {
        let _e461 = (_e66 * vec2<u32>(2u, 2u));
        let _e466 = (_e461 + vec2<u32>(1u, 0u));
        let _e471 = (_e461 + vec2<u32>(0u, 1u));
        let _e476 = (_e461 + vec2<u32>(1u, 1u));
        let _e482 = global_2[((_e461.y * 8u) + _e461.x)];
        let _e488 = global_2[((_e466.y * 8u) + _e466.x)];
        let _e494 = global_2[((_e471.y * 8u) + _e471.x)];
        let _e500 = global_2[((_e476.y * 8u) + _e476.x)];
        let _e505 = (9u * _e87);
        let _e506 = (45u + _e505);
        let _e507 = _e482.member_2.xy;
        let _e508 = _e488.member_2.xy;
        let _e509 = min(_e507, _e508);
        let _e510 = _e482.member_2.zw;
        let _e511 = _e488.member_2.zw;
        let _e512 = max(_e510, _e511);
        let _e517 = vec4<f32>(_e509.x, _e509.y, _e512.x, _e512.y);
        let _e520 = (_e517.zw - _e517.xy);
        let _e525 = _e494.member_2.xy;
        let _e526 = min(_e507, _e525);
        let _e527 = _e494.member_2.zw;
        let _e528 = max(_e510, _e527);
        let _e533 = vec4<f32>(_e526.x, _e526.y, _e528.x, _e528.y);
        let _e536 = (_e533.zw - _e533.xy);
        let _e541 = _e500.member_2.xy;
        let _e542 = min(_e525, _e541);
        let _e543 = _e500.member_2.zw;
        let _e544 = max(_e527, _e543);
        let _e549 = vec4<f32>(_e542.x, _e542.y, _e544.x, _e544.y);
        let _e552 = (_e549.zw - _e549.xy);
        let _e557 = min(_e508, _e541);
        let _e558 = max(_e511, _e543);
        let _e563 = vec4<f32>(_e557.x, _e557.y, _e558.x, _e558.y);
        let _e566 = (_e563.zw - _e563.xy);
        let _e573 = ((max(0.0, (_e520.x * _e520.y)) + max(0.0, (_e552.x * _e552.y))) > (max(0.0, (_e536.x * _e536.y)) + max(0.0, (_e566.x * _e566.y))));
        let _e574 = select(_e494.member, _e488.member, _e573);
        let _e575 = select(_e494.member_1, _e488.member_1, _e573);
        let _e576 = vec4(_e573);
        let _e577 = select(_e494.member_2, _e488.member_2, _e576);
        let _e578 = select(_e494.member_3, _e488.member_3, _e573);
        let _e579 = select(_e488.member, _e494.member, _e573);
        let _e580 = select(_e488.member_1, _e494.member_1, _e573);
        let _e581 = select(_e488.member_2, _e494.member_2, _e576);
        let _e582 = select(_e488.member_3, _e494.member_3, _e573);
        let _e583 = (_e505 + 48u);
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e583] = bitcast<vec4<f32>>(vec4<u32>(_e482.member, _e482.member_1, _e579, _e580));
                let _e590 = (_e482.member_3 == 0u);
                global.member[(_e505 + 49u)] = select(_e482.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e590));
                let _e596 = (_e582 == 0u);
                global.member[(_e505 + 50u)] = select(_e581, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e596));
                if _e596 {
                    phi_637_ = _e482.member;
                    phi_638_ = _e482.member_1;
                    phi_639_ = _e482.member_2;
                    phi_640_ = _e482.member_3;
                    break;
                } else {
                    if _e590 {
                        phi_637_ = _e579;
                        phi_638_ = _e580;
                        phi_639_ = _e581;
                        phi_640_ = _e582;
                        break;
                    }
                }
                let _e603 = min(_e507, _e581.xy);
                let _e605 = max(_e510, _e581.zw);
                phi_637_ = 0u;
                phi_638_ = _e583;
                phi_639_ = vec4<f32>(_e603.x, _e603.y, _e605.x, _e605.y);
                phi_640_ = (_e482.member_3 + _e582);
                break;
            }
        }
        let _e612 = phi_637_;
        let _e614 = phi_638_;
        let _e616 = phi_639_;
        let _e618 = phi_640_;
        let _e619 = (_e505 + 51u);
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e619] = bitcast<vec4<f32>>(vec4<u32>(_e574, _e575, _e500.member, _e500.member_1));
                let _e626 = (_e578 == 0u);
                global.member[(_e505 + 52u)] = select(_e577, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e626));
                let _e632 = (_e500.member_3 == 0u);
                global.member[(_e505 + 53u)] = select(_e500.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e632));
                if _e632 {
                    phi_672_ = _e574;
                    phi_673_ = _e575;
                    phi_674_ = _e577;
                    phi_675_ = _e578;
                    break;
                } else {
                    if _e626 {
                        phi_672_ = _e500.member;
                        phi_673_ = _e500.member_1;
                        phi_674_ = _e500.member_2;
                        phi_675_ = _e500.member_3;
                        break;
                    }
                }
                let _e639 = min(_e577.xy, _e541);
                let _e641 = max(_e577.zw, _e543);
                phi_672_ = 0u;
                phi_673_ = _e619;
                phi_674_ = vec4<f32>(_e639.x, _e639.y, _e641.x, _e641.y);
                phi_675_ = (_e578 + _e500.member_3);
                break;
            }
        }
        let _e648 = phi_672_;
        let _e650 = phi_673_;
        let _e652 = phi_674_;
        let _e654 = phi_675_;
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e506] = bitcast<vec4<f32>>(vec4<u32>(_e612, _e614, _e648, _e650));
                let _e661 = (_e618 == 0u);
                global.member[(_e505 + 46u)] = select(_e616, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e661));
                let _e667 = (_e654 == 0u);
                global.member[(_e505 + 47u)] = select(_e652, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e667));
                if _e667 {
                    phi_708_ = _e612;
                    phi_709_ = _e614;
                    phi_710_ = _e616;
                    phi_711_ = _e618;
                    break;
                } else {
                    if _e661 {
                        phi_708_ = _e648;
                        phi_709_ = _e650;
                        phi_710_ = _e652;
                        phi_711_ = _e654;
                        break;
                    }
                }
                let _e675 = min(_e616.xy, _e652.xy);
                let _e678 = max(_e616.zw, _e652.zw);
                phi_708_ = 0u;
                phi_709_ = _e506;
                phi_710_ = vec4<f32>(_e675.x, _e675.y, _e678.x, _e678.y);
                phi_711_ = (_e618 + _e654);
                break;
            }
        }
        let _e685 = phi_708_;
        let _e687 = phi_709_;
        let _e689 = phi_710_;
        let _e691 = phi_711_;
        global_1[((_e65.y * 4u) + _e65.x)] = type_3(_e685, _e687, _e689, _e691);
    }
    workgroupBarrier();
    if all((_e66 < vec2<u32>(2u, 2u))) {
        let _e698 = (_e66 * vec2<u32>(2u, 2u));
        let _e703 = (_e698 + vec2<u32>(1u, 0u));
        let _e708 = (_e698 + vec2<u32>(0u, 1u));
        let _e713 = (_e698 + vec2<u32>(1u, 1u));
        let _e719 = global_1[((_e698.y * 4u) + _e698.x)];
        let _e725 = global_1[((_e703.y * 4u) + _e703.x)];
        let _e731 = global_1[((_e708.y * 4u) + _e708.x)];
        let _e737 = global_1[((_e713.y * 4u) + _e713.x)];
        let _e742 = (9u * _e87);
        let _e743 = (9u + _e742);
        let _e744 = _e719.member_2.xy;
        let _e745 = _e725.member_2.xy;
        let _e746 = min(_e744, _e745);
        let _e747 = _e719.member_2.zw;
        let _e748 = _e725.member_2.zw;
        let _e749 = max(_e747, _e748);
        let _e754 = vec4<f32>(_e746.x, _e746.y, _e749.x, _e749.y);
        let _e757 = (_e754.zw - _e754.xy);
        let _e762 = _e731.member_2.xy;
        let _e763 = min(_e744, _e762);
        let _e764 = _e731.member_2.zw;
        let _e765 = max(_e747, _e764);
        let _e770 = vec4<f32>(_e763.x, _e763.y, _e765.x, _e765.y);
        let _e773 = (_e770.zw - _e770.xy);
        let _e778 = _e737.member_2.xy;
        let _e779 = min(_e762, _e778);
        let _e780 = _e737.member_2.zw;
        let _e781 = max(_e764, _e780);
        let _e786 = vec4<f32>(_e779.x, _e779.y, _e781.x, _e781.y);
        let _e789 = (_e786.zw - _e786.xy);
        let _e794 = min(_e745, _e778);
        let _e795 = max(_e748, _e780);
        let _e800 = vec4<f32>(_e794.x, _e794.y, _e795.x, _e795.y);
        let _e803 = (_e800.zw - _e800.xy);
        let _e810 = ((max(0.0, (_e757.x * _e757.y)) + max(0.0, (_e789.x * _e789.y))) > (max(0.0, (_e773.x * _e773.y)) + max(0.0, (_e803.x * _e803.y))));
        let _e811 = select(_e731.member, _e725.member, _e810);
        let _e812 = select(_e731.member_1, _e725.member_1, _e810);
        let _e813 = vec4(_e810);
        let _e814 = select(_e731.member_2, _e725.member_2, _e813);
        let _e815 = select(_e731.member_3, _e725.member_3, _e810);
        let _e816 = select(_e725.member, _e731.member, _e810);
        let _e817 = select(_e725.member_1, _e731.member_1, _e810);
        let _e818 = select(_e725.member_2, _e731.member_2, _e813);
        let _e819 = select(_e725.member_3, _e731.member_3, _e810);
        let _e820 = (_e742 + 12u);
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e820] = bitcast<vec4<f32>>(vec4<u32>(_e719.member, _e719.member_1, _e816, _e817));
                let _e827 = (_e719.member_3 == 0u);
                global.member[(_e742 + 13u)] = select(_e719.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e827));
                let _e833 = (_e819 == 0u);
                global.member[(_e742 + 14u)] = select(_e818, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e833));
                if _e833 {
                    phi_873_ = _e719.member;
                    phi_874_ = _e719.member_1;
                    phi_875_ = _e719.member_2;
                    phi_876_ = _e719.member_3;
                    break;
                } else {
                    if _e827 {
                        phi_873_ = _e816;
                        phi_874_ = _e817;
                        phi_875_ = _e818;
                        phi_876_ = _e819;
                        break;
                    }
                }
                let _e840 = min(_e744, _e818.xy);
                let _e842 = max(_e747, _e818.zw);
                phi_873_ = 0u;
                phi_874_ = _e820;
                phi_875_ = vec4<f32>(_e840.x, _e840.y, _e842.x, _e842.y);
                phi_876_ = (_e719.member_3 + _e819);
                break;
            }
        }
        let _e849 = phi_873_;
        let _e851 = phi_874_;
        let _e853 = phi_875_;
        let _e855 = phi_876_;
        let _e856 = (_e742 + 15u);
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e856] = bitcast<vec4<f32>>(vec4<u32>(_e811, _e812, _e737.member, _e737.member_1));
                let _e863 = (_e815 == 0u);
                global.member[(_e742 + 16u)] = select(_e814, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e863));
                let _e869 = (_e737.member_3 == 0u);
                global.member[(_e742 + 17u)] = select(_e737.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e869));
                if _e869 {
                    phi_908_ = _e811;
                    phi_909_ = _e812;
                    phi_910_ = _e814;
                    phi_911_ = _e815;
                    break;
                } else {
                    if _e863 {
                        phi_908_ = _e737.member;
                        phi_909_ = _e737.member_1;
                        phi_910_ = _e737.member_2;
                        phi_911_ = _e737.member_3;
                        break;
                    }
                }
                let _e876 = min(_e814.xy, _e778);
                let _e878 = max(_e814.zw, _e780);
                phi_908_ = 0u;
                phi_909_ = _e856;
                phi_910_ = vec4<f32>(_e876.x, _e876.y, _e878.x, _e878.y);
                phi_911_ = (_e815 + _e737.member_3);
                break;
            }
        }
        let _e885 = phi_908_;
        let _e887 = phi_909_;
        let _e889 = phi_910_;
        let _e891 = phi_911_;
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e743] = bitcast<vec4<f32>>(vec4<u32>(_e849, _e851, _e885, _e887));
                let _e898 = (_e855 == 0u);
                global.member[(_e742 + 10u)] = select(_e853, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e898));
                let _e904 = (_e891 == 0u);
                global.member[(_e742 + 11u)] = select(_e889, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e904));
                if _e904 {
                    phi_944_ = _e849;
                    phi_945_ = _e851;
                    phi_946_ = _e853;
                    phi_947_ = _e855;
                    break;
                } else {
                    if _e898 {
                        phi_944_ = _e885;
                        phi_945_ = _e887;
                        phi_946_ = _e889;
                        phi_947_ = _e891;
                        break;
                    }
                }
                let _e912 = min(_e853.xy, _e889.xy);
                let _e915 = max(_e853.zw, _e889.zw);
                phi_944_ = 0u;
                phi_945_ = _e743;
                phi_946_ = vec4<f32>(_e912.x, _e912.y, _e915.x, _e915.y);
                phi_947_ = (_e855 + _e891);
                break;
            }
        }
        let _e922 = phi_944_;
        let _e924 = phi_945_;
        let _e926 = phi_946_;
        let _e928 = phi_947_;
        global_2[((_e65.y * 2u) + _e65.x)] = type_3(_e922, _e924, _e926, _e928);
    }
    if all((_e66 < vec2<u32>(1u, 1u))) {
        let _e933 = (_e66 * vec2<u32>(2u, 2u));
        let _e938 = (_e933 + vec2<u32>(1u, 0u));
        let _e943 = (_e933 + vec2<u32>(0u, 1u));
        let _e948 = (_e933 + vec2<u32>(1u, 1u));
        let _e954 = global_2[((_e933.y * 2u) + _e933.x)];
        let _e960 = global_2[((_e938.y * 2u) + _e938.x)];
        let _e966 = global_2[((_e943.y * 2u) + _e943.x)];
        let _e972 = global_2[((_e948.y * 2u) + _e948.x)];
        let _e977 = (9u * _e87);
        let _e978 = _e954.member_2.xy;
        let _e979 = _e960.member_2.xy;
        let _e980 = min(_e978, _e979);
        let _e981 = _e954.member_2.zw;
        let _e982 = _e960.member_2.zw;
        let _e983 = max(_e981, _e982);
        let _e988 = vec4<f32>(_e980.x, _e980.y, _e983.x, _e983.y);
        let _e991 = (_e988.zw - _e988.xy);
        let _e996 = _e966.member_2.xy;
        let _e997 = min(_e978, _e996);
        let _e998 = _e966.member_2.zw;
        let _e999 = max(_e981, _e998);
        let _e1004 = vec4<f32>(_e997.x, _e997.y, _e999.x, _e999.y);
        let _e1007 = (_e1004.zw - _e1004.xy);
        let _e1012 = _e972.member_2.xy;
        let _e1013 = min(_e996, _e1012);
        let _e1014 = _e972.member_2.zw;
        let _e1015 = max(_e998, _e1014);
        let _e1020 = vec4<f32>(_e1013.x, _e1013.y, _e1015.x, _e1015.y);
        let _e1023 = (_e1020.zw - _e1020.xy);
        let _e1028 = min(_e979, _e1012);
        let _e1029 = max(_e982, _e1014);
        let _e1034 = vec4<f32>(_e1028.x, _e1028.y, _e1029.x, _e1029.y);
        let _e1037 = (_e1034.zw - _e1034.xy);
        let _e1044 = ((max(0.0, (_e991.x * _e991.y)) + max(0.0, (_e1023.x * _e1023.y))) > (max(0.0, (_e1007.x * _e1007.y)) + max(0.0, (_e1037.x * _e1037.y))));
        let _e1045 = select(_e966.member, _e960.member, _e1044);
        let _e1046 = select(_e966.member_1, _e960.member_1, _e1044);
        let _e1047 = vec4(_e1044);
        let _e1048 = select(_e966.member_2, _e960.member_2, _e1047);
        let _e1049 = select(_e966.member_3, _e960.member_3, _e1044);
        let _e1050 = select(_e960.member, _e966.member, _e1044);
        let _e1051 = select(_e960.member_1, _e966.member_1, _e1044);
        let _e1052 = select(_e960.member_2, _e966.member_2, _e1047);
        let _e1053 = select(_e960.member_3, _e966.member_3, _e1044);
        let _e1054 = (_e977 + 3u);
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e1054] = bitcast<vec4<f32>>(vec4<u32>(_e954.member, _e954.member_1, _e1050, _e1051));
                let _e1061 = (_e954.member_3 == 0u);
                global.member[(_e977 + 4u)] = select(_e954.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e1061));
                let _e1067 = (_e1053 == 0u);
                global.member[(_e977 + 5u)] = select(_e1052, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e1067));
                if _e1067 {
                    phi_1106_ = _e954.member;
                    phi_1107_ = _e954.member_1;
                    phi_1108_ = _e954.member_2;
                    phi_1109_ = _e954.member_3;
                    break;
                } else {
                    if _e1061 {
                        phi_1106_ = _e1050;
                        phi_1107_ = _e1051;
                        phi_1108_ = _e1052;
                        phi_1109_ = _e1053;
                        break;
                    }
                }
                let _e1074 = min(_e978, _e1052.xy);
                let _e1076 = max(_e981, _e1052.zw);
                phi_1106_ = 0u;
                phi_1107_ = _e1054;
                phi_1108_ = vec4<f32>(_e1074.x, _e1074.y, _e1076.x, _e1076.y);
                phi_1109_ = (_e954.member_3 + _e1053);
                break;
            }
        }
        let _e1083 = phi_1106_;
        let _e1085 = phi_1107_;
        let _e1087 = phi_1108_;
        let _e1089 = phi_1109_;
        let _e1090 = (_e977 + 6u);
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e1090] = bitcast<vec4<f32>>(vec4<u32>(_e1045, _e1046, _e972.member, _e972.member_1));
                let _e1097 = (_e1049 == 0u);
                global.member[(_e977 + 7u)] = select(_e1048, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e1097));
                let _e1103 = (_e972.member_3 == 0u);
                global.member[(_e977 + 8u)] = select(_e972.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e1103));
                if _e1103 {
                    phi_1141_ = _e1045;
                    phi_1142_ = _e1046;
                    phi_1143_ = _e1048;
                    phi_1144_ = _e1049;
                    break;
                } else {
                    if _e1097 {
                        phi_1141_ = _e972.member;
                        phi_1142_ = _e972.member_1;
                        phi_1143_ = _e972.member_2;
                        phi_1144_ = _e972.member_3;
                        break;
                    }
                }
                let _e1110 = min(_e1048.xy, _e1012);
                let _e1112 = max(_e1048.zw, _e1014);
                phi_1141_ = 0u;
                phi_1142_ = _e1090;
                phi_1143_ = vec4<f32>(_e1110.x, _e1110.y, _e1112.x, _e1112.y);
                phi_1144_ = (_e1049 + _e972.member_3);
                break;
            }
        }
        let _e1119 = phi_1141_;
        let _e1121 = phi_1142_;
        let _e1123 = phi_1143_;
        let _e1125 = phi_1144_;
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e977] = bitcast<vec4<f32>>(vec4<u32>(_e1083, _e1085, _e1119, _e1121));
                let _e1132 = (_e1089 == 0u);
                global.member[(_e977 + 1u)] = select(_e1087, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e1132));
                let _e1138 = (_e1125 == 0u);
                global.member[(_e977 + 2u)] = select(_e1123, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e1138));
                if _e1138 {
                    break;
                } else {
                    if _e1132 {
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

@compute @workgroup_size(16, 16, 1) 
fn main(@builtin(local_invocation_id) param: vec3<u32>) {
    global_3 = param;
    function();
}
