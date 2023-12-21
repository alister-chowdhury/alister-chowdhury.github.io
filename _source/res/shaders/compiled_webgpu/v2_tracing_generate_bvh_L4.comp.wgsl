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
var<workgroup> global_1: array<type_3, 256>;
var<workgroup> global_2: array<type_3, 64>;
var<private> global_3: vec3<u32>;
@group(0) @binding(2) 
var<uniform> global_4: type_22;
@group(0) @binding(0) 
var<storage> global_5: type_10;
var<workgroup> global_6: array<u32, 256>;

fn function() {
    var phi_142_: u32;
    var phi_145_: u32;
    var phi_147_: vec4<f32>;
    var phi_149_: u32;
    var phi_151_: u32;
    var phi_172_: bool;
    var phi_143_: u32;
    var phi_146_: u32;
    var phi_148_: vec4<f32>;
    var phi_150_: u32;
    var local: u32;
    var phi_199_: u32;
    var phi_202_: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: vec4<f32>;
    var local_4: u32;
    var phi_215_: u32;
    var phi_218_: u32;
    var local_5: u32;
    var phi_237_: bool;
    var phi_216_: u32;
    var phi_346_: u32;
    var phi_347_: vec4<f32>;
    var phi_465_: u32;
    var phi_466_: u32;
    var phi_467_: vec4<f32>;
    var phi_468_: u32;
    var phi_500_: u32;
    var phi_501_: u32;
    var phi_502_: vec4<f32>;
    var phi_503_: u32;
    var phi_504_: u32;
    var phi_505_: u32;
    var phi_506_: vec4<f32>;
    var phi_507_: u32;
    var phi_508_: u32;
    var phi_509_: u32;
    var phi_510_: vec4<f32>;
    var phi_511_: u32;
    var phi_544_: u32;
    var phi_545_: u32;
    var phi_546_: vec4<f32>;
    var phi_547_: u32;
    var phi_550_: u32;
    var phi_551_: u32;
    var phi_552_: vec4<f32>;
    var phi_553_: u32;
    var phi_554_: u32;
    var phi_555_: u32;
    var phi_556_: vec4<f32>;
    var phi_557_: u32;
    var phi_656_: u32;
    var phi_657_: vec4<f32>;
    var phi_776_: u32;
    var phi_777_: u32;
    var phi_778_: vec4<f32>;
    var phi_779_: u32;
    var phi_811_: u32;
    var phi_812_: u32;
    var phi_813_: vec4<f32>;
    var phi_814_: u32;
    var phi_815_: u32;
    var phi_816_: u32;
    var phi_817_: vec4<f32>;
    var phi_818_: u32;
    var phi_819_: u32;
    var phi_820_: u32;
    var phi_821_: vec4<f32>;
    var phi_822_: u32;
    var phi_855_: u32;
    var phi_856_: u32;
    var phi_857_: vec4<f32>;
    var phi_858_: u32;
    var phi_861_: u32;
    var phi_862_: u32;
    var phi_863_: vec4<f32>;
    var phi_864_: u32;
    var phi_865_: u32;
    var phi_866_: u32;
    var phi_867_: vec4<f32>;
    var phi_868_: u32;
    var phi_967_: u32;
    var phi_968_: vec4<f32>;
    var phi_1087_: u32;
    var phi_1088_: u32;
    var phi_1089_: vec4<f32>;
    var phi_1090_: u32;
    var phi_1122_: u32;
    var phi_1123_: u32;
    var phi_1124_: vec4<f32>;
    var phi_1125_: u32;
    var phi_1126_: u32;
    var phi_1127_: u32;
    var phi_1128_: vec4<f32>;
    var phi_1129_: u32;
    var phi_1130_: u32;
    var phi_1131_: u32;
    var phi_1132_: vec4<f32>;
    var phi_1133_: u32;
    var phi_1166_: u32;
    var phi_1167_: u32;
    var phi_1168_: vec4<f32>;
    var phi_1169_: u32;
    var phi_1172_: u32;
    var phi_1173_: u32;
    var phi_1174_: vec4<f32>;
    var phi_1175_: u32;
    var phi_1176_: u32;
    var phi_1177_: u32;
    var phi_1178_: vec4<f32>;
    var phi_1179_: u32;
    var phi_1275_: u32;
    var phi_1276_: vec4<f32>;
    var phi_1395_: u32;
    var phi_1396_: u32;
    var phi_1397_: vec4<f32>;
    var phi_1398_: u32;
    var phi_1430_: u32;
    var phi_1431_: u32;
    var phi_1432_: vec4<f32>;
    var phi_1433_: u32;
    var phi_1434_: u32;
    var phi_1435_: u32;
    var phi_1436_: vec4<f32>;
    var phi_1437_: u32;
    var phi_1438_: u32;
    var phi_1439_: u32;
    var phi_1440_: vec4<f32>;
    var phi_1441_: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: vec4<f32>;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;

    let _e77 = global_3;
    let _e78 = _e77.xy;
    let _e83 = (_e77.x | (_e77.y << bitcast<u32>(16)));
    let _e87 = ((_e83 | (_e83 << bitcast<u32>(4))) & 252645135u);
    let _e91 = ((_e87 | (_e87 << bitcast<u32>(2))) & 858993459u);
    let _e95 = ((_e91 | (_e91 << bitcast<u32>(1))) & 1431655765u);
    let _e99 = ((_e95 | (_e95 >> bitcast<u32>(15))) & 65535u);
    let _e100 = vec2<f32>(_e78);
    let _e102 = vec2<f32>((_e78 + vec2<u32>(1u, 1u)));
    let _e108 = (vec4<f32>(_e100.x, _e100.y, _e102.x, _e102.y) * vec4<f32>(0.0625, 0.0625, 0.0625, 0.0625));
    phi_142_ = 0u;
    phi_145_ = 0u;
    phi_147_ = vec4<f32>(1.0, 1.0, -1.0, -1.0);
    phi_149_ = 0u;
    phi_151_ = 0u;
    loop {
        let _e110 = phi_142_;
        let _e112 = phi_145_;
        let _e114 = phi_147_;
        let _e116 = phi_149_;
        let _e118 = phi_151_;
        let _e120 = global_4.member;
        local = _e116;
        local_1 = _e116;
        local_3 = _e114;
        local_4 = _e116;
        local_12 = _e112;
        local_5 = _e110;
        if (_e118 < _e120) {
            let _e124 = global_5.member[_e118];
            let _e125 = _e124.xy;
            let _e126 = _e124.zw;
            let _e128 = ((_e125 + _e126) * 0.5);
            let _e131 = all((_e128 >= _e108.xy));
            phi_172_ = _e131;
            if _e131 {
                phi_172_ = all((_e128 < _e108.zw));
            }
            let _e136 = phi_172_;
            phi_143_ = _e110;
            phi_146_ = _e112;
            phi_148_ = _e114;
            phi_150_ = _e116;
            if _e136 {
                let _e140 = min(_e125, _e126);
                let _e141 = max(_e125, _e126);
                let _e146 = vec4<f32>(_e140.x, _e140.y, _e141.x, _e141.y);
                let _e149 = min(_e114.xy, _e146.xy);
                let _e152 = max(_e114.zw, _e146.zw);
                phi_143_ = (_e118 + 1u);
                phi_146_ = select(_e112, _e118, (_e116 == 0u));
                phi_148_ = vec4<f32>(_e149.x, _e149.y, _e152.x, _e152.y);
                phi_150_ = (_e116 + bitcast<u32>(1));
            }
            let _e161 = phi_143_;
            let _e163 = phi_146_;
            let _e165 = phi_148_;
            let _e167 = phi_150_;
            local_6 = _e161;
            local_7 = _e163;
            local_8 = _e165;
            local_9 = _e167;
            continue;
        } else {
            break;
        }
        continuing {
            let _e1502 = local_6;
            phi_142_ = _e1502;
            let _e1505 = local_7;
            phi_145_ = _e1505;
            let _e1508 = local_8;
            phi_147_ = _e1508;
            let _e1511 = local_9;
            phi_149_ = _e1511;
            phi_151_ = (_e118 + bitcast<u32>(1));
        }
    }
    let _e172 = local;
    global_6[_e99] = _e172;
    workgroupBarrier();
    phi_199_ = 765u;
    phi_202_ = 0u;
    loop {
        let _e174 = phi_199_;
        let _e176 = phi_202_;
        local_2 = _e174;
        local_10 = _e174;
        if (_e176 < _e99) {
            continue;
        } else {
            break;
        }
        continuing {
            let _e179 = global_6[_e176];
            phi_199_ = (_e174 + _e179);
            phi_202_ = (_e176 + bitcast<u32>(1));
        }
    }
    let _e186 = local_1;
    let _e191 = local_2;
    let _e193 = local_3;
    let _e195 = local_4;
    global_1[((_e77.y * 16u) + _e77.x)] = type_3((1u | (_e186 << bitcast<u32>(1))), _e191, _e193, _e195);
    workgroupBarrier();
    let _e1527 = local_10;
    phi_215_ = _e1527;
    let _e1532 = local_12;
    phi_218_ = _e1532;
    loop {
        let _e199 = phi_215_;
        let _e201 = phi_218_;
        let _e203 = local_5;
        if (_e201 < _e203) {
            let _e207 = global_5.member[_e201];
            let _e208 = _e207.xy;
            let _e209 = _e207.zw;
            let _e211 = ((_e208 + _e209) * 0.5);
            let _e214 = all((_e211 >= _e108.xy));
            phi_237_ = _e214;
            if _e214 {
                phi_237_ = all((_e211 < _e108.zw));
            }
            let _e219 = phi_237_;
            phi_216_ = _e199;
            if _e219 {
                let _e222 = (_e208 - _e209);
                global.member[_e199] = vec4<f32>(_e207.x, _e207.y, _e222.x, _e222.y);
                phi_216_ = (_e199 + bitcast<u32>(1));
            }
            let _e231 = phi_216_;
            local_11 = _e231;
            continue;
        } else {
            break;
        }
        continuing {
            let _e1529 = local_11;
            phi_215_ = _e1529;
            phi_218_ = (_e201 + bitcast<u32>(1));
        }
    }
    phi_550_ = u32();
    phi_551_ = u32();
    phi_552_ = vec4<f32>();
    phi_553_ = u32();
    phi_554_ = u32();
    phi_555_ = u32();
    phi_556_ = vec4<f32>();
    phi_557_ = u32();
    if all((_e78 < vec2<u32>(8u, 8u))) {
        let _e238 = (_e78 * vec2<u32>(2u, 2u));
        let _e243 = (_e238 + vec2<u32>(1u, 0u));
        let _e248 = (_e238 + vec2<u32>(0u, 1u));
        let _e253 = (_e238 + vec2<u32>(1u, 1u));
        let _e259 = global_1[((_e238.y * 16u) + _e238.x)];
        let _e265 = global_1[((_e243.y * 16u) + _e243.x)];
        let _e271 = global_1[((_e248.y * 16u) + _e248.x)];
        let _e277 = global_1[((_e253.y * 16u) + _e253.x)];
        let _e282 = (9u * _e99);
        let _e283 = (189u + _e282);
        let _e286 = (((_e259.member_3 + _e265.member_3) + _e271.member_3) + _e277.member_3);
        let _e292 = ((_e286 <= 16u) && all(((vec4<u32>(_e259.member, _e265.member, _e271.member, _e277.member) & vec4<u32>(1u, 1u, 1u, 1u)) == vec4<u32>(1u, 1u, 1u, 1u))));
        phi_346_ = u32();
        phi_347_ = vec4<f32>();
        if _e292 {
            let _e295 = min(_e259.member_2.xy, _e265.member_2.xy);
            let _e298 = max(_e259.member_2.zw, _e265.member_2.zw);
            let _e303 = vec4<f32>(_e295.x, _e295.y, _e298.x, _e298.y);
            let _e306 = min(_e271.member_2.xy, _e277.member_2.xy);
            let _e309 = max(_e271.member_2.zw, _e277.member_2.zw);
            let _e314 = vec4<f32>(_e306.x, _e306.y, _e309.x, _e309.y);
            let _e317 = min(_e303.xy, _e314.xy);
            let _e320 = max(_e303.zw, _e314.zw);
            phi_346_ = (1u | (_e286 << bitcast<u32>(1)));
            phi_347_ = vec4<f32>(_e317.x, _e317.y, _e320.x, _e320.y);
        }
        let _e330 = phi_346_;
        let _e332 = phi_347_;
        let _e334 = select(u32(), 0u, _e292);
        phi_504_ = select(u32(), 1u, _e292);
        phi_505_ = _e334;
        phi_506_ = select(vec4<f32>(), vec4<f32>(1.0, 1.0, -1.0, -1.0), vec4(_e292));
        phi_507_ = _e334;
        phi_508_ = _e330;
        phi_509_ = select(u32(), _e259.member_1, _e292);
        phi_510_ = _e332;
        phi_511_ = select(u32(), _e286, _e292);
        if !(select(false, true, _e292)) {
            let _e341 = _e259.member_2.xy;
            let _e342 = _e265.member_2.xy;
            let _e343 = min(_e341, _e342);
            let _e344 = _e259.member_2.zw;
            let _e345 = _e265.member_2.zw;
            let _e346 = max(_e344, _e345);
            let _e351 = vec4<f32>(_e343.x, _e343.y, _e346.x, _e346.y);
            let _e354 = (_e351.zw - _e351.xy);
            let _e359 = _e271.member_2.xy;
            let _e360 = min(_e341, _e359);
            let _e361 = _e271.member_2.zw;
            let _e362 = max(_e344, _e361);
            let _e367 = vec4<f32>(_e360.x, _e360.y, _e362.x, _e362.y);
            let _e370 = (_e367.zw - _e367.xy);
            let _e375 = _e277.member_2.xy;
            let _e376 = min(_e359, _e375);
            let _e377 = _e277.member_2.zw;
            let _e378 = max(_e361, _e377);
            let _e383 = vec4<f32>(_e376.x, _e376.y, _e378.x, _e378.y);
            let _e386 = (_e383.zw - _e383.xy);
            let _e391 = min(_e342, _e375);
            let _e392 = max(_e345, _e377);
            let _e397 = vec4<f32>(_e391.x, _e391.y, _e392.x, _e392.y);
            let _e400 = (_e397.zw - _e397.xy);
            let _e407 = ((max(0.0, (_e354.x * _e354.y)) + max(0.0, (_e386.x * _e386.y))) > (max(0.0, (_e370.x * _e370.y)) + max(0.0, (_e400.x * _e400.y))));
            let _e408 = select(_e271.member, _e265.member, _e407);
            let _e409 = select(_e271.member_1, _e265.member_1, _e407);
            let _e410 = vec4(_e407);
            let _e411 = select(_e271.member_2, _e265.member_2, _e410);
            let _e412 = select(_e271.member_3, _e265.member_3, _e407);
            let _e413 = select(_e265.member, _e271.member, _e407);
            let _e414 = select(_e265.member_1, _e271.member_1, _e407);
            let _e415 = select(_e265.member_2, _e271.member_2, _e410);
            let _e416 = select(_e265.member_3, _e271.member_3, _e407);
            let _e417 = (_e282 + 192u);
            switch bitcast<i32>(0u) {
                default: {
                    global.member[_e417] = bitcast<vec4<f32>>(vec4<u32>(_e259.member, _e259.member_1, _e413, _e414));
                    let _e424 = (_e259.member_3 == 0u);
                    global.member[(_e282 + 193u)] = select(_e259.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e424));
                    let _e430 = (_e416 == 0u);
                    global.member[(_e282 + 194u)] = select(_e415, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e430));
                    if _e430 {
                        phi_465_ = _e259.member;
                        phi_466_ = _e259.member_1;
                        phi_467_ = _e259.member_2;
                        phi_468_ = _e259.member_3;
                        break;
                    } else {
                        if _e424 {
                            phi_465_ = _e413;
                            phi_466_ = _e414;
                            phi_467_ = _e415;
                            phi_468_ = _e416;
                            break;
                        }
                    }
                    let _e437 = min(_e341, _e415.xy);
                    let _e439 = max(_e344, _e415.zw);
                    phi_465_ = 0u;
                    phi_466_ = _e417;
                    phi_467_ = vec4<f32>(_e437.x, _e437.y, _e439.x, _e439.y);
                    phi_468_ = (_e259.member_3 + _e416);
                    break;
                }
            }
            let _e446 = phi_465_;
            let _e448 = phi_466_;
            let _e450 = phi_467_;
            let _e452 = phi_468_;
            let _e453 = (_e282 + 195u);
            switch bitcast<i32>(0u) {
                default: {
                    global.member[_e453] = bitcast<vec4<f32>>(vec4<u32>(_e408, _e409, _e277.member, _e277.member_1));
                    let _e460 = (_e412 == 0u);
                    global.member[(_e282 + 196u)] = select(_e411, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e460));
                    let _e466 = (_e277.member_3 == 0u);
                    global.member[(_e282 + 197u)] = select(_e277.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e466));
                    if _e466 {
                        phi_500_ = _e408;
                        phi_501_ = _e409;
                        phi_502_ = _e411;
                        phi_503_ = _e412;
                        break;
                    } else {
                        if _e460 {
                            phi_500_ = _e277.member;
                            phi_501_ = _e277.member_1;
                            phi_502_ = _e277.member_2;
                            phi_503_ = _e277.member_3;
                            break;
                        }
                    }
                    let _e473 = min(_e411.xy, _e375);
                    let _e475 = max(_e411.zw, _e377);
                    phi_500_ = 0u;
                    phi_501_ = _e453;
                    phi_502_ = vec4<f32>(_e473.x, _e473.y, _e475.x, _e475.y);
                    phi_503_ = (_e412 + _e277.member_3);
                    break;
                }
            }
            let _e482 = phi_500_;
            let _e484 = phi_501_;
            let _e486 = phi_502_;
            let _e488 = phi_503_;
            phi_504_ = _e482;
            phi_505_ = _e484;
            phi_506_ = _e486;
            phi_507_ = _e488;
            phi_508_ = _e446;
            phi_509_ = _e448;
            phi_510_ = _e450;
            phi_511_ = _e452;
        }
        let _e490 = phi_504_;
        let _e492 = phi_505_;
        let _e494 = phi_506_;
        let _e496 = phi_507_;
        let _e498 = phi_508_;
        let _e500 = phi_509_;
        let _e502 = phi_510_;
        let _e504 = phi_511_;
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e283] = bitcast<vec4<f32>>(vec4<u32>(_e498, _e500, _e490, _e492));
                let _e511 = (_e504 == 0u);
                global.member[(_e282 + 190u)] = select(_e502, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e511));
                let _e517 = (_e496 == 0u);
                global.member[(_e282 + 191u)] = select(_e494, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e517));
                if _e517 {
                    phi_544_ = _e498;
                    phi_545_ = _e500;
                    phi_546_ = _e502;
                    phi_547_ = _e504;
                    break;
                } else {
                    if _e511 {
                        phi_544_ = _e490;
                        phi_545_ = _e492;
                        phi_546_ = _e494;
                        phi_547_ = _e496;
                        break;
                    }
                }
                let _e525 = min(_e502.xy, _e494.xy);
                let _e528 = max(_e502.zw, _e494.zw);
                phi_544_ = 0u;
                phi_545_ = _e283;
                phi_546_ = vec4<f32>(_e525.x, _e525.y, _e528.x, _e528.y);
                phi_547_ = (_e504 + _e496);
                break;
            }
        }
        let _e535 = phi_544_;
        let _e537 = phi_545_;
        let _e539 = phi_546_;
        let _e541 = phi_547_;
        global_2[((_e77.y * 8u) + _e77.x)] = type_3(_e535, _e537, _e539, _e541);
        phi_550_ = _e490;
        phi_551_ = _e492;
        phi_552_ = _e494;
        phi_553_ = _e496;
        phi_554_ = _e498;
        phi_555_ = _e500;
        phi_556_ = _e502;
        phi_557_ = _e504;
    }
    let _e545 = phi_550_;
    let _e547 = phi_551_;
    let _e549 = phi_552_;
    let _e551 = phi_553_;
    let _e553 = phi_554_;
    let _e555 = phi_555_;
    let _e557 = phi_556_;
    workgroupBarrier();
    let _e559 = phi_557_;
    phi_861_ = _e545;
    phi_862_ = _e547;
    phi_863_ = _e549;
    phi_864_ = _e551;
    phi_865_ = _e553;
    phi_866_ = _e555;
    phi_867_ = _e557;
    phi_868_ = _e559;
    if all((_e78 < vec2<u32>(4u, 4u))) {
        let _e564 = (_e78 * vec2<u32>(2u, 2u));
        let _e569 = (_e564 + vec2<u32>(1u, 0u));
        let _e574 = (_e564 + vec2<u32>(0u, 1u));
        let _e579 = (_e564 + vec2<u32>(1u, 1u));
        let _e585 = global_2[((_e564.y * 8u) + _e564.x)];
        let _e591 = global_2[((_e569.y * 8u) + _e569.x)];
        let _e597 = global_2[((_e574.y * 8u) + _e574.x)];
        let _e603 = global_2[((_e579.y * 8u) + _e579.x)];
        let _e608 = (9u * _e99);
        let _e609 = (45u + _e608);
        let _e612 = (((_e585.member_3 + _e591.member_3) + _e597.member_3) + _e603.member_3);
        let _e618 = ((_e612 <= 16u) && all(((vec4<u32>(_e585.member, _e591.member, _e597.member, _e603.member) & vec4<u32>(1u, 1u, 1u, 1u)) == vec4<u32>(1u, 1u, 1u, 1u))));
        phi_656_ = _e553;
        phi_657_ = _e557;
        if _e618 {
            let _e621 = min(_e585.member_2.xy, _e591.member_2.xy);
            let _e624 = max(_e585.member_2.zw, _e591.member_2.zw);
            let _e629 = vec4<f32>(_e621.x, _e621.y, _e624.x, _e624.y);
            let _e632 = min(_e597.member_2.xy, _e603.member_2.xy);
            let _e635 = max(_e597.member_2.zw, _e603.member_2.zw);
            let _e640 = vec4<f32>(_e632.x, _e632.y, _e635.x, _e635.y);
            let _e643 = min(_e629.xy, _e640.xy);
            let _e646 = max(_e629.zw, _e640.zw);
            phi_656_ = (1u | (_e612 << bitcast<u32>(1)));
            phi_657_ = vec4<f32>(_e643.x, _e643.y, _e646.x, _e646.y);
        }
        let _e656 = phi_656_;
        let _e658 = phi_657_;
        phi_815_ = select(_e545, 1u, _e618);
        phi_816_ = select(_e547, 0u, _e618);
        phi_817_ = select(_e549, vec4<f32>(1.0, 1.0, -1.0, -1.0), vec4(_e618));
        phi_818_ = select(_e551, 0u, _e618);
        phi_819_ = _e656;
        phi_820_ = select(_e555, _e585.member_1, _e618);
        phi_821_ = _e658;
        phi_822_ = select(_e559, _e612, _e618);
        if !(select(false, true, _e618)) {
            let _e668 = _e585.member_2.xy;
            let _e669 = _e591.member_2.xy;
            let _e670 = min(_e668, _e669);
            let _e671 = _e585.member_2.zw;
            let _e672 = _e591.member_2.zw;
            let _e673 = max(_e671, _e672);
            let _e678 = vec4<f32>(_e670.x, _e670.y, _e673.x, _e673.y);
            let _e681 = (_e678.zw - _e678.xy);
            let _e686 = _e597.member_2.xy;
            let _e687 = min(_e668, _e686);
            let _e688 = _e597.member_2.zw;
            let _e689 = max(_e671, _e688);
            let _e694 = vec4<f32>(_e687.x, _e687.y, _e689.x, _e689.y);
            let _e697 = (_e694.zw - _e694.xy);
            let _e702 = _e603.member_2.xy;
            let _e703 = min(_e686, _e702);
            let _e704 = _e603.member_2.zw;
            let _e705 = max(_e688, _e704);
            let _e710 = vec4<f32>(_e703.x, _e703.y, _e705.x, _e705.y);
            let _e713 = (_e710.zw - _e710.xy);
            let _e718 = min(_e669, _e702);
            let _e719 = max(_e672, _e704);
            let _e724 = vec4<f32>(_e718.x, _e718.y, _e719.x, _e719.y);
            let _e727 = (_e724.zw - _e724.xy);
            let _e734 = ((max(0.0, (_e681.x * _e681.y)) + max(0.0, (_e713.x * _e713.y))) > (max(0.0, (_e697.x * _e697.y)) + max(0.0, (_e727.x * _e727.y))));
            let _e735 = select(_e597.member, _e591.member, _e734);
            let _e736 = select(_e597.member_1, _e591.member_1, _e734);
            let _e737 = vec4(_e734);
            let _e738 = select(_e597.member_2, _e591.member_2, _e737);
            let _e739 = select(_e597.member_3, _e591.member_3, _e734);
            let _e740 = select(_e591.member, _e597.member, _e734);
            let _e741 = select(_e591.member_1, _e597.member_1, _e734);
            let _e742 = select(_e591.member_2, _e597.member_2, _e737);
            let _e743 = select(_e591.member_3, _e597.member_3, _e734);
            let _e744 = (_e608 + 48u);
            switch bitcast<i32>(0u) {
                default: {
                    global.member[_e744] = bitcast<vec4<f32>>(vec4<u32>(_e585.member, _e585.member_1, _e740, _e741));
                    let _e751 = (_e585.member_3 == 0u);
                    global.member[(_e608 + 49u)] = select(_e585.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e751));
                    let _e757 = (_e743 == 0u);
                    global.member[(_e608 + 50u)] = select(_e742, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e757));
                    if _e757 {
                        phi_776_ = _e585.member;
                        phi_777_ = _e585.member_1;
                        phi_778_ = _e585.member_2;
                        phi_779_ = _e585.member_3;
                        break;
                    } else {
                        if _e751 {
                            phi_776_ = _e740;
                            phi_777_ = _e741;
                            phi_778_ = _e742;
                            phi_779_ = _e743;
                            break;
                        }
                    }
                    let _e764 = min(_e668, _e742.xy);
                    let _e766 = max(_e671, _e742.zw);
                    phi_776_ = 0u;
                    phi_777_ = _e744;
                    phi_778_ = vec4<f32>(_e764.x, _e764.y, _e766.x, _e766.y);
                    phi_779_ = (_e585.member_3 + _e743);
                    break;
                }
            }
            let _e773 = phi_776_;
            let _e775 = phi_777_;
            let _e777 = phi_778_;
            let _e779 = phi_779_;
            let _e780 = (_e608 + 51u);
            switch bitcast<i32>(0u) {
                default: {
                    global.member[_e780] = bitcast<vec4<f32>>(vec4<u32>(_e735, _e736, _e603.member, _e603.member_1));
                    let _e787 = (_e739 == 0u);
                    global.member[(_e608 + 52u)] = select(_e738, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e787));
                    let _e793 = (_e603.member_3 == 0u);
                    global.member[(_e608 + 53u)] = select(_e603.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e793));
                    if _e793 {
                        phi_811_ = _e735;
                        phi_812_ = _e736;
                        phi_813_ = _e738;
                        phi_814_ = _e739;
                        break;
                    } else {
                        if _e787 {
                            phi_811_ = _e603.member;
                            phi_812_ = _e603.member_1;
                            phi_813_ = _e603.member_2;
                            phi_814_ = _e603.member_3;
                            break;
                        }
                    }
                    let _e800 = min(_e738.xy, _e702);
                    let _e802 = max(_e738.zw, _e704);
                    phi_811_ = 0u;
                    phi_812_ = _e780;
                    phi_813_ = vec4<f32>(_e800.x, _e800.y, _e802.x, _e802.y);
                    phi_814_ = (_e739 + _e603.member_3);
                    break;
                }
            }
            let _e809 = phi_811_;
            let _e811 = phi_812_;
            let _e813 = phi_813_;
            let _e815 = phi_814_;
            phi_815_ = _e809;
            phi_816_ = _e811;
            phi_817_ = _e813;
            phi_818_ = _e815;
            phi_819_ = _e773;
            phi_820_ = _e775;
            phi_821_ = _e777;
            phi_822_ = _e779;
        }
        let _e817 = phi_815_;
        let _e819 = phi_816_;
        let _e821 = phi_817_;
        let _e823 = phi_818_;
        let _e825 = phi_819_;
        let _e827 = phi_820_;
        let _e829 = phi_821_;
        let _e831 = phi_822_;
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e609] = bitcast<vec4<f32>>(vec4<u32>(_e825, _e827, _e817, _e819));
                let _e838 = (_e831 == 0u);
                global.member[(_e608 + 46u)] = select(_e829, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e838));
                let _e844 = (_e823 == 0u);
                global.member[(_e608 + 47u)] = select(_e821, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e844));
                if _e844 {
                    phi_855_ = _e825;
                    phi_856_ = _e827;
                    phi_857_ = _e829;
                    phi_858_ = _e831;
                    break;
                } else {
                    if _e838 {
                        phi_855_ = _e817;
                        phi_856_ = _e819;
                        phi_857_ = _e821;
                        phi_858_ = _e823;
                        break;
                    }
                }
                let _e852 = min(_e829.xy, _e821.xy);
                let _e855 = max(_e829.zw, _e821.zw);
                phi_855_ = 0u;
                phi_856_ = _e609;
                phi_857_ = vec4<f32>(_e852.x, _e852.y, _e855.x, _e855.y);
                phi_858_ = (_e831 + _e823);
                break;
            }
        }
        let _e862 = phi_855_;
        let _e864 = phi_856_;
        let _e866 = phi_857_;
        let _e868 = phi_858_;
        global_1[((_e77.y * 4u) + _e77.x)] = type_3(_e862, _e864, _e866, _e868);
        phi_861_ = _e817;
        phi_862_ = _e819;
        phi_863_ = _e821;
        phi_864_ = _e823;
        phi_865_ = _e825;
        phi_866_ = _e827;
        phi_867_ = _e829;
        phi_868_ = _e831;
    }
    let _e872 = phi_861_;
    let _e874 = phi_862_;
    let _e876 = phi_863_;
    let _e878 = phi_864_;
    let _e880 = phi_865_;
    let _e882 = phi_866_;
    let _e884 = phi_867_;
    workgroupBarrier();
    let _e886 = phi_868_;
    phi_1172_ = _e872;
    phi_1173_ = _e874;
    phi_1174_ = _e876;
    phi_1175_ = _e878;
    phi_1176_ = _e880;
    phi_1177_ = _e882;
    phi_1178_ = _e884;
    phi_1179_ = _e886;
    if all((_e78 < vec2<u32>(2u, 2u))) {
        let _e891 = (_e78 * vec2<u32>(2u, 2u));
        let _e896 = (_e891 + vec2<u32>(1u, 0u));
        let _e901 = (_e891 + vec2<u32>(0u, 1u));
        let _e906 = (_e891 + vec2<u32>(1u, 1u));
        let _e912 = global_1[((_e891.y * 4u) + _e891.x)];
        let _e918 = global_1[((_e896.y * 4u) + _e896.x)];
        let _e924 = global_1[((_e901.y * 4u) + _e901.x)];
        let _e930 = global_1[((_e906.y * 4u) + _e906.x)];
        let _e935 = (9u * _e99);
        let _e936 = (9u + _e935);
        let _e939 = (((_e912.member_3 + _e918.member_3) + _e924.member_3) + _e930.member_3);
        let _e945 = ((_e939 <= 16u) && all(((vec4<u32>(_e912.member, _e918.member, _e924.member, _e930.member) & vec4<u32>(1u, 1u, 1u, 1u)) == vec4<u32>(1u, 1u, 1u, 1u))));
        phi_967_ = _e880;
        phi_968_ = _e884;
        if _e945 {
            let _e948 = min(_e912.member_2.xy, _e918.member_2.xy);
            let _e951 = max(_e912.member_2.zw, _e918.member_2.zw);
            let _e956 = vec4<f32>(_e948.x, _e948.y, _e951.x, _e951.y);
            let _e959 = min(_e924.member_2.xy, _e930.member_2.xy);
            let _e962 = max(_e924.member_2.zw, _e930.member_2.zw);
            let _e967 = vec4<f32>(_e959.x, _e959.y, _e962.x, _e962.y);
            let _e970 = min(_e956.xy, _e967.xy);
            let _e973 = max(_e956.zw, _e967.zw);
            phi_967_ = (1u | (_e939 << bitcast<u32>(1)));
            phi_968_ = vec4<f32>(_e970.x, _e970.y, _e973.x, _e973.y);
        }
        let _e983 = phi_967_;
        let _e985 = phi_968_;
        phi_1126_ = select(_e872, 1u, _e945);
        phi_1127_ = select(_e874, 0u, _e945);
        phi_1128_ = select(_e876, vec4<f32>(1.0, 1.0, -1.0, -1.0), vec4(_e945));
        phi_1129_ = select(_e878, 0u, _e945);
        phi_1130_ = _e983;
        phi_1131_ = select(_e882, _e912.member_1, _e945);
        phi_1132_ = _e985;
        phi_1133_ = select(_e886, _e939, _e945);
        if !(select(false, true, _e945)) {
            let _e995 = _e912.member_2.xy;
            let _e996 = _e918.member_2.xy;
            let _e997 = min(_e995, _e996);
            let _e998 = _e912.member_2.zw;
            let _e999 = _e918.member_2.zw;
            let _e1000 = max(_e998, _e999);
            let _e1005 = vec4<f32>(_e997.x, _e997.y, _e1000.x, _e1000.y);
            let _e1008 = (_e1005.zw - _e1005.xy);
            let _e1013 = _e924.member_2.xy;
            let _e1014 = min(_e995, _e1013);
            let _e1015 = _e924.member_2.zw;
            let _e1016 = max(_e998, _e1015);
            let _e1021 = vec4<f32>(_e1014.x, _e1014.y, _e1016.x, _e1016.y);
            let _e1024 = (_e1021.zw - _e1021.xy);
            let _e1029 = _e930.member_2.xy;
            let _e1030 = min(_e1013, _e1029);
            let _e1031 = _e930.member_2.zw;
            let _e1032 = max(_e1015, _e1031);
            let _e1037 = vec4<f32>(_e1030.x, _e1030.y, _e1032.x, _e1032.y);
            let _e1040 = (_e1037.zw - _e1037.xy);
            let _e1045 = min(_e996, _e1029);
            let _e1046 = max(_e999, _e1031);
            let _e1051 = vec4<f32>(_e1045.x, _e1045.y, _e1046.x, _e1046.y);
            let _e1054 = (_e1051.zw - _e1051.xy);
            let _e1061 = ((max(0.0, (_e1008.x * _e1008.y)) + max(0.0, (_e1040.x * _e1040.y))) > (max(0.0, (_e1024.x * _e1024.y)) + max(0.0, (_e1054.x * _e1054.y))));
            let _e1062 = select(_e924.member, _e918.member, _e1061);
            let _e1063 = select(_e924.member_1, _e918.member_1, _e1061);
            let _e1064 = vec4(_e1061);
            let _e1065 = select(_e924.member_2, _e918.member_2, _e1064);
            let _e1066 = select(_e924.member_3, _e918.member_3, _e1061);
            let _e1067 = select(_e918.member, _e924.member, _e1061);
            let _e1068 = select(_e918.member_1, _e924.member_1, _e1061);
            let _e1069 = select(_e918.member_2, _e924.member_2, _e1064);
            let _e1070 = select(_e918.member_3, _e924.member_3, _e1061);
            let _e1071 = (_e935 + 12u);
            switch bitcast<i32>(0u) {
                default: {
                    global.member[_e1071] = bitcast<vec4<f32>>(vec4<u32>(_e912.member, _e912.member_1, _e1067, _e1068));
                    let _e1078 = (_e912.member_3 == 0u);
                    global.member[(_e935 + 13u)] = select(_e912.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e1078));
                    let _e1084 = (_e1070 == 0u);
                    global.member[(_e935 + 14u)] = select(_e1069, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e1084));
                    if _e1084 {
                        phi_1087_ = _e912.member;
                        phi_1088_ = _e912.member_1;
                        phi_1089_ = _e912.member_2;
                        phi_1090_ = _e912.member_3;
                        break;
                    } else {
                        if _e1078 {
                            phi_1087_ = _e1067;
                            phi_1088_ = _e1068;
                            phi_1089_ = _e1069;
                            phi_1090_ = _e1070;
                            break;
                        }
                    }
                    let _e1091 = min(_e995, _e1069.xy);
                    let _e1093 = max(_e998, _e1069.zw);
                    phi_1087_ = 0u;
                    phi_1088_ = _e1071;
                    phi_1089_ = vec4<f32>(_e1091.x, _e1091.y, _e1093.x, _e1093.y);
                    phi_1090_ = (_e912.member_3 + _e1070);
                    break;
                }
            }
            let _e1100 = phi_1087_;
            let _e1102 = phi_1088_;
            let _e1104 = phi_1089_;
            let _e1106 = phi_1090_;
            let _e1107 = (_e935 + 15u);
            switch bitcast<i32>(0u) {
                default: {
                    global.member[_e1107] = bitcast<vec4<f32>>(vec4<u32>(_e1062, _e1063, _e930.member, _e930.member_1));
                    let _e1114 = (_e1066 == 0u);
                    global.member[(_e935 + 16u)] = select(_e1065, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e1114));
                    let _e1120 = (_e930.member_3 == 0u);
                    global.member[(_e935 + 17u)] = select(_e930.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e1120));
                    if _e1120 {
                        phi_1122_ = _e1062;
                        phi_1123_ = _e1063;
                        phi_1124_ = _e1065;
                        phi_1125_ = _e1066;
                        break;
                    } else {
                        if _e1114 {
                            phi_1122_ = _e930.member;
                            phi_1123_ = _e930.member_1;
                            phi_1124_ = _e930.member_2;
                            phi_1125_ = _e930.member_3;
                            break;
                        }
                    }
                    let _e1127 = min(_e1065.xy, _e1029);
                    let _e1129 = max(_e1065.zw, _e1031);
                    phi_1122_ = 0u;
                    phi_1123_ = _e1107;
                    phi_1124_ = vec4<f32>(_e1127.x, _e1127.y, _e1129.x, _e1129.y);
                    phi_1125_ = (_e1066 + _e930.member_3);
                    break;
                }
            }
            let _e1136 = phi_1122_;
            let _e1138 = phi_1123_;
            let _e1140 = phi_1124_;
            let _e1142 = phi_1125_;
            phi_1126_ = _e1136;
            phi_1127_ = _e1138;
            phi_1128_ = _e1140;
            phi_1129_ = _e1142;
            phi_1130_ = _e1100;
            phi_1131_ = _e1102;
            phi_1132_ = _e1104;
            phi_1133_ = _e1106;
        }
        let _e1144 = phi_1126_;
        let _e1146 = phi_1127_;
        let _e1148 = phi_1128_;
        let _e1150 = phi_1129_;
        let _e1152 = phi_1130_;
        let _e1154 = phi_1131_;
        let _e1156 = phi_1132_;
        let _e1158 = phi_1133_;
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e936] = bitcast<vec4<f32>>(vec4<u32>(_e1152, _e1154, _e1144, _e1146));
                let _e1165 = (_e1158 == 0u);
                global.member[(_e935 + 10u)] = select(_e1156, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e1165));
                let _e1171 = (_e1150 == 0u);
                global.member[(_e935 + 11u)] = select(_e1148, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e1171));
                if _e1171 {
                    phi_1166_ = _e1152;
                    phi_1167_ = _e1154;
                    phi_1168_ = _e1156;
                    phi_1169_ = _e1158;
                    break;
                } else {
                    if _e1165 {
                        phi_1166_ = _e1144;
                        phi_1167_ = _e1146;
                        phi_1168_ = _e1148;
                        phi_1169_ = _e1150;
                        break;
                    }
                }
                let _e1179 = min(_e1156.xy, _e1148.xy);
                let _e1182 = max(_e1156.zw, _e1148.zw);
                phi_1166_ = 0u;
                phi_1167_ = _e936;
                phi_1168_ = vec4<f32>(_e1179.x, _e1179.y, _e1182.x, _e1182.y);
                phi_1169_ = (_e1158 + _e1150);
                break;
            }
        }
        let _e1189 = phi_1166_;
        let _e1191 = phi_1167_;
        let _e1193 = phi_1168_;
        let _e1195 = phi_1169_;
        global_2[((_e77.y * 2u) + _e77.x)] = type_3(_e1189, _e1191, _e1193, _e1195);
        phi_1172_ = _e1144;
        phi_1173_ = _e1146;
        phi_1174_ = _e1148;
        phi_1175_ = _e1150;
        phi_1176_ = _e1152;
        phi_1177_ = _e1154;
        phi_1178_ = _e1156;
        phi_1179_ = _e1158;
    }
    let _e1199 = phi_1172_;
    let _e1201 = phi_1173_;
    let _e1203 = phi_1174_;
    let _e1205 = phi_1175_;
    let _e1207 = phi_1176_;
    let _e1209 = phi_1177_;
    let _e1211 = phi_1178_;
    let _e1213 = phi_1179_;
    if all((_e78 < vec2<u32>(1u, 1u))) {
        let _e1216 = (_e78 * vec2<u32>(2u, 2u));
        let _e1221 = (_e1216 + vec2<u32>(1u, 0u));
        let _e1226 = (_e1216 + vec2<u32>(0u, 1u));
        let _e1231 = (_e1216 + vec2<u32>(1u, 1u));
        let _e1237 = global_2[((_e1216.y * 2u) + _e1216.x)];
        let _e1243 = global_2[((_e1221.y * 2u) + _e1221.x)];
        let _e1249 = global_2[((_e1226.y * 2u) + _e1226.x)];
        let _e1255 = global_2[((_e1231.y * 2u) + _e1231.x)];
        let _e1260 = (9u * _e99);
        let _e1263 = (((_e1237.member_3 + _e1243.member_3) + _e1249.member_3) + _e1255.member_3);
        let _e1269 = ((_e1263 <= 16u) && all(((vec4<u32>(_e1237.member, _e1243.member, _e1249.member, _e1255.member) & vec4<u32>(1u, 1u, 1u, 1u)) == vec4<u32>(1u, 1u, 1u, 1u))));
        phi_1275_ = _e1207;
        phi_1276_ = _e1211;
        if _e1269 {
            let _e1272 = min(_e1237.member_2.xy, _e1243.member_2.xy);
            let _e1275 = max(_e1237.member_2.zw, _e1243.member_2.zw);
            let _e1280 = vec4<f32>(_e1272.x, _e1272.y, _e1275.x, _e1275.y);
            let _e1283 = min(_e1249.member_2.xy, _e1255.member_2.xy);
            let _e1286 = max(_e1249.member_2.zw, _e1255.member_2.zw);
            let _e1291 = vec4<f32>(_e1283.x, _e1283.y, _e1286.x, _e1286.y);
            let _e1294 = min(_e1280.xy, _e1291.xy);
            let _e1297 = max(_e1280.zw, _e1291.zw);
            phi_1275_ = (1u | (_e1263 << bitcast<u32>(1)));
            phi_1276_ = vec4<f32>(_e1294.x, _e1294.y, _e1297.x, _e1297.y);
        }
        let _e1307 = phi_1275_;
        let _e1309 = phi_1276_;
        phi_1434_ = select(_e1199, 1u, _e1269);
        phi_1435_ = select(_e1201, 0u, _e1269);
        phi_1436_ = select(_e1203, vec4<f32>(1.0, 1.0, -1.0, -1.0), vec4(_e1269));
        phi_1437_ = select(_e1205, 0u, _e1269);
        phi_1438_ = _e1307;
        phi_1439_ = select(_e1209, _e1237.member_1, _e1269);
        phi_1440_ = _e1309;
        phi_1441_ = select(_e1213, _e1263, _e1269);
        if !(select(false, true, _e1269)) {
            let _e1319 = _e1237.member_2.xy;
            let _e1320 = _e1243.member_2.xy;
            let _e1321 = min(_e1319, _e1320);
            let _e1322 = _e1237.member_2.zw;
            let _e1323 = _e1243.member_2.zw;
            let _e1324 = max(_e1322, _e1323);
            let _e1329 = vec4<f32>(_e1321.x, _e1321.y, _e1324.x, _e1324.y);
            let _e1332 = (_e1329.zw - _e1329.xy);
            let _e1337 = _e1249.member_2.xy;
            let _e1338 = min(_e1319, _e1337);
            let _e1339 = _e1249.member_2.zw;
            let _e1340 = max(_e1322, _e1339);
            let _e1345 = vec4<f32>(_e1338.x, _e1338.y, _e1340.x, _e1340.y);
            let _e1348 = (_e1345.zw - _e1345.xy);
            let _e1353 = _e1255.member_2.xy;
            let _e1354 = min(_e1337, _e1353);
            let _e1355 = _e1255.member_2.zw;
            let _e1356 = max(_e1339, _e1355);
            let _e1361 = vec4<f32>(_e1354.x, _e1354.y, _e1356.x, _e1356.y);
            let _e1364 = (_e1361.zw - _e1361.xy);
            let _e1369 = min(_e1320, _e1353);
            let _e1370 = max(_e1323, _e1355);
            let _e1375 = vec4<f32>(_e1369.x, _e1369.y, _e1370.x, _e1370.y);
            let _e1378 = (_e1375.zw - _e1375.xy);
            let _e1385 = ((max(0.0, (_e1332.x * _e1332.y)) + max(0.0, (_e1364.x * _e1364.y))) > (max(0.0, (_e1348.x * _e1348.y)) + max(0.0, (_e1378.x * _e1378.y))));
            let _e1386 = select(_e1249.member, _e1243.member, _e1385);
            let _e1387 = select(_e1249.member_1, _e1243.member_1, _e1385);
            let _e1388 = vec4(_e1385);
            let _e1389 = select(_e1249.member_2, _e1243.member_2, _e1388);
            let _e1390 = select(_e1249.member_3, _e1243.member_3, _e1385);
            let _e1391 = select(_e1243.member, _e1249.member, _e1385);
            let _e1392 = select(_e1243.member_1, _e1249.member_1, _e1385);
            let _e1393 = select(_e1243.member_2, _e1249.member_2, _e1388);
            let _e1394 = select(_e1243.member_3, _e1249.member_3, _e1385);
            let _e1395 = (_e1260 + 3u);
            switch bitcast<i32>(0u) {
                default: {
                    global.member[_e1395] = bitcast<vec4<f32>>(vec4<u32>(_e1237.member, _e1237.member_1, _e1391, _e1392));
                    let _e1402 = (_e1237.member_3 == 0u);
                    global.member[(_e1260 + 4u)] = select(_e1237.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e1402));
                    let _e1408 = (_e1394 == 0u);
                    global.member[(_e1260 + 5u)] = select(_e1393, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e1408));
                    if _e1408 {
                        phi_1395_ = _e1237.member;
                        phi_1396_ = _e1237.member_1;
                        phi_1397_ = _e1237.member_2;
                        phi_1398_ = _e1237.member_3;
                        break;
                    } else {
                        if _e1402 {
                            phi_1395_ = _e1391;
                            phi_1396_ = _e1392;
                            phi_1397_ = _e1393;
                            phi_1398_ = _e1394;
                            break;
                        }
                    }
                    let _e1415 = min(_e1319, _e1393.xy);
                    let _e1417 = max(_e1322, _e1393.zw);
                    phi_1395_ = 0u;
                    phi_1396_ = _e1395;
                    phi_1397_ = vec4<f32>(_e1415.x, _e1415.y, _e1417.x, _e1417.y);
                    phi_1398_ = (_e1237.member_3 + _e1394);
                    break;
                }
            }
            let _e1424 = phi_1395_;
            let _e1426 = phi_1396_;
            let _e1428 = phi_1397_;
            let _e1430 = phi_1398_;
            let _e1431 = (_e1260 + 6u);
            switch bitcast<i32>(0u) {
                default: {
                    global.member[_e1431] = bitcast<vec4<f32>>(vec4<u32>(_e1386, _e1387, _e1255.member, _e1255.member_1));
                    let _e1438 = (_e1390 == 0u);
                    global.member[(_e1260 + 7u)] = select(_e1389, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e1438));
                    let _e1444 = (_e1255.member_3 == 0u);
                    global.member[(_e1260 + 8u)] = select(_e1255.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e1444));
                    if _e1444 {
                        phi_1430_ = _e1386;
                        phi_1431_ = _e1387;
                        phi_1432_ = _e1389;
                        phi_1433_ = _e1390;
                        break;
                    } else {
                        if _e1438 {
                            phi_1430_ = _e1255.member;
                            phi_1431_ = _e1255.member_1;
                            phi_1432_ = _e1255.member_2;
                            phi_1433_ = _e1255.member_3;
                            break;
                        }
                    }
                    let _e1451 = min(_e1389.xy, _e1353);
                    let _e1453 = max(_e1389.zw, _e1355);
                    phi_1430_ = 0u;
                    phi_1431_ = _e1431;
                    phi_1432_ = vec4<f32>(_e1451.x, _e1451.y, _e1453.x, _e1453.y);
                    phi_1433_ = (_e1390 + _e1255.member_3);
                    break;
                }
            }
            let _e1460 = phi_1430_;
            let _e1462 = phi_1431_;
            let _e1464 = phi_1432_;
            let _e1466 = phi_1433_;
            phi_1434_ = _e1460;
            phi_1435_ = _e1462;
            phi_1436_ = _e1464;
            phi_1437_ = _e1466;
            phi_1438_ = _e1424;
            phi_1439_ = _e1426;
            phi_1440_ = _e1428;
            phi_1441_ = _e1430;
        }
        let _e1468 = phi_1434_;
        let _e1470 = phi_1435_;
        let _e1472 = phi_1436_;
        let _e1474 = phi_1437_;
        let _e1476 = phi_1438_;
        let _e1478 = phi_1439_;
        let _e1480 = phi_1440_;
        let _e1482 = phi_1441_;
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e1260] = bitcast<vec4<f32>>(vec4<u32>(_e1476, _e1478, _e1468, _e1470));
                let _e1489 = (_e1482 == 0u);
                global.member[(_e1260 + 1u)] = select(_e1480, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e1489));
                let _e1495 = (_e1474 == 0u);
                global.member[(_e1260 + 2u)] = select(_e1472, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e1495));
                if _e1495 {
                    break;
                } else {
                    if _e1489 {
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
