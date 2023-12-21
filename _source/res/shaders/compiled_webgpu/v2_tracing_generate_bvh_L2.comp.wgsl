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
var<workgroup> global_1: array<type_3, 16>;
var<workgroup> global_2: array<type_3, 4>;
var<private> global_3: vec3<u32>;
@group(0) @binding(2) 
var<uniform> global_4: type_22;
@group(0) @binding(0) 
var<storage> global_5: type_10;
var<workgroup> global_6: array<u32, 16>;

fn function() {
    var phi_120_: u32;
    var phi_123_: u32;
    var phi_125_: vec4<f32>;
    var phi_127_: u32;
    var phi_129_: u32;
    var phi_150_: bool;
    var phi_121_: u32;
    var phi_124_: u32;
    var phi_126_: vec4<f32>;
    var phi_128_: u32;
    var local: u32;
    var phi_177_: u32;
    var phi_180_: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: vec4<f32>;
    var local_4: u32;
    var phi_193_: u32;
    var phi_196_: u32;
    var local_5: u32;
    var phi_215_: bool;
    var phi_194_: u32;
    var phi_324_: u32;
    var phi_325_: vec4<f32>;
    var phi_443_: u32;
    var phi_444_: u32;
    var phi_445_: vec4<f32>;
    var phi_446_: u32;
    var phi_478_: u32;
    var phi_479_: u32;
    var phi_480_: vec4<f32>;
    var phi_481_: u32;
    var phi_482_: u32;
    var phi_483_: u32;
    var phi_484_: vec4<f32>;
    var phi_485_: u32;
    var phi_486_: u32;
    var phi_487_: u32;
    var phi_488_: vec4<f32>;
    var phi_489_: u32;
    var phi_522_: u32;
    var phi_523_: u32;
    var phi_524_: vec4<f32>;
    var phi_525_: u32;
    var phi_528_: u32;
    var phi_529_: u32;
    var phi_530_: vec4<f32>;
    var phi_531_: u32;
    var phi_532_: u32;
    var phi_533_: u32;
    var phi_534_: vec4<f32>;
    var phi_535_: u32;
    var phi_631_: u32;
    var phi_632_: vec4<f32>;
    var phi_751_: u32;
    var phi_752_: u32;
    var phi_753_: vec4<f32>;
    var phi_754_: u32;
    var phi_786_: u32;
    var phi_787_: u32;
    var phi_788_: vec4<f32>;
    var phi_789_: u32;
    var phi_790_: u32;
    var phi_791_: u32;
    var phi_792_: vec4<f32>;
    var phi_793_: u32;
    var phi_794_: u32;
    var phi_795_: u32;
    var phi_796_: vec4<f32>;
    var phi_797_: u32;
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
    let _e86 = (vec4<f32>(_e78.x, _e78.y, _e80.x, _e80.y) * vec4<f32>(0.25, 0.25, 0.25, 0.25));
    phi_120_ = 0u;
    phi_123_ = 0u;
    phi_125_ = vec4<f32>(1.0, 1.0, -1.0, -1.0);
    phi_127_ = 0u;
    phi_129_ = 0u;
    loop {
        let _e88 = phi_120_;
        let _e90 = phi_123_;
        let _e92 = phi_125_;
        let _e94 = phi_127_;
        let _e96 = phi_129_;
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
            phi_150_ = _e109;
            if _e109 {
                phi_150_ = all((_e106 < _e86.zw));
            }
            let _e114 = phi_150_;
            phi_121_ = _e88;
            phi_124_ = _e90;
            phi_126_ = _e92;
            phi_128_ = _e94;
            if _e114 {
                let _e118 = min(_e103, _e104);
                let _e119 = max(_e103, _e104);
                let _e124 = vec4<f32>(_e118.x, _e118.y, _e119.x, _e119.y);
                let _e127 = min(_e92.xy, _e124.xy);
                let _e130 = max(_e92.zw, _e124.zw);
                phi_121_ = (_e96 + 1u);
                phi_124_ = select(_e90, _e96, (_e94 == 0u));
                phi_126_ = vec4<f32>(_e127.x, _e127.y, _e130.x, _e130.y);
                phi_128_ = (_e94 + bitcast<u32>(1));
            }
            let _e139 = phi_121_;
            let _e141 = phi_124_;
            let _e143 = phi_126_;
            let _e145 = phi_128_;
            local_6 = _e139;
            local_7 = _e141;
            local_8 = _e143;
            local_9 = _e145;
            continue;
        } else {
            break;
        }
        continuing {
            let _e826 = local_6;
            phi_120_ = _e826;
            let _e829 = local_7;
            phi_123_ = _e829;
            let _e832 = local_8;
            phi_125_ = _e832;
            let _e835 = local_9;
            phi_127_ = _e835;
            phi_129_ = (_e96 + bitcast<u32>(1));
        }
    }
    let _e150 = local;
    global_6[_e77] = _e150;
    workgroupBarrier();
    phi_177_ = 45u;
    phi_180_ = 0u;
    loop {
        let _e152 = phi_177_;
        let _e154 = phi_180_;
        local_2 = _e152;
        local_10 = _e152;
        if (_e154 < _e77) {
            continue;
        } else {
            break;
        }
        continuing {
            let _e157 = global_6[_e154];
            phi_177_ = (_e152 + _e157);
            phi_180_ = (_e154 + bitcast<u32>(1));
        }
    }
    let _e164 = local_1;
    let _e169 = local_2;
    let _e171 = local_3;
    let _e173 = local_4;
    global_1[((_e55.y * 4u) + _e55.x)] = type_3((1u | (_e164 << bitcast<u32>(1))), _e169, _e171, _e173);
    workgroupBarrier();
    let _e851 = local_10;
    phi_193_ = _e851;
    let _e856 = local_12;
    phi_196_ = _e856;
    loop {
        let _e177 = phi_193_;
        let _e179 = phi_196_;
        let _e181 = local_5;
        if (_e179 < _e181) {
            let _e185 = global_5.member[_e179];
            let _e186 = _e185.xy;
            let _e187 = _e185.zw;
            let _e189 = ((_e186 + _e187) * 0.5);
            let _e192 = all((_e189 >= _e86.xy));
            phi_215_ = _e192;
            if _e192 {
                phi_215_ = all((_e189 < _e86.zw));
            }
            let _e197 = phi_215_;
            phi_194_ = _e177;
            if _e197 {
                let _e200 = (_e186 - _e187);
                global.member[_e177] = vec4<f32>(_e185.x, _e185.y, _e200.x, _e200.y);
                phi_194_ = (_e177 + bitcast<u32>(1));
            }
            let _e209 = phi_194_;
            local_11 = _e209;
            continue;
        } else {
            break;
        }
        continuing {
            let _e853 = local_11;
            phi_193_ = _e853;
            phi_196_ = (_e179 + bitcast<u32>(1));
        }
    }
    phi_528_ = u32();
    phi_529_ = u32();
    phi_530_ = vec4<f32>();
    phi_531_ = u32();
    phi_532_ = u32();
    phi_533_ = u32();
    phi_534_ = vec4<f32>();
    phi_535_ = u32();
    if all((_e56 < vec2<u32>(2u, 2u))) {
        let _e216 = (_e56 * vec2<u32>(2u, 2u));
        let _e221 = (_e216 + vec2<u32>(1u, 0u));
        let _e226 = (_e216 + vec2<u32>(0u, 1u));
        let _e231 = (_e216 + vec2<u32>(1u, 1u));
        let _e237 = global_1[((_e216.y * 4u) + _e216.x)];
        let _e243 = global_1[((_e221.y * 4u) + _e221.x)];
        let _e249 = global_1[((_e226.y * 4u) + _e226.x)];
        let _e255 = global_1[((_e231.y * 4u) + _e231.x)];
        let _e260 = (9u * _e77);
        let _e261 = (9u + _e260);
        let _e264 = (((_e237.member_3 + _e243.member_3) + _e249.member_3) + _e255.member_3);
        let _e270 = ((_e264 <= 16u) && all(((vec4<u32>(_e237.member, _e243.member, _e249.member, _e255.member) & vec4<u32>(1u, 1u, 1u, 1u)) == vec4<u32>(1u, 1u, 1u, 1u))));
        phi_324_ = u32();
        phi_325_ = vec4<f32>();
        if _e270 {
            let _e273 = min(_e237.member_2.xy, _e243.member_2.xy);
            let _e276 = max(_e237.member_2.zw, _e243.member_2.zw);
            let _e281 = vec4<f32>(_e273.x, _e273.y, _e276.x, _e276.y);
            let _e284 = min(_e249.member_2.xy, _e255.member_2.xy);
            let _e287 = max(_e249.member_2.zw, _e255.member_2.zw);
            let _e292 = vec4<f32>(_e284.x, _e284.y, _e287.x, _e287.y);
            let _e295 = min(_e281.xy, _e292.xy);
            let _e298 = max(_e281.zw, _e292.zw);
            phi_324_ = (1u | (_e264 << bitcast<u32>(1)));
            phi_325_ = vec4<f32>(_e295.x, _e295.y, _e298.x, _e298.y);
        }
        let _e308 = phi_324_;
        let _e310 = phi_325_;
        let _e312 = select(u32(), 0u, _e270);
        phi_482_ = select(u32(), 1u, _e270);
        phi_483_ = _e312;
        phi_484_ = select(vec4<f32>(), vec4<f32>(1.0, 1.0, -1.0, -1.0), vec4(_e270));
        phi_485_ = _e312;
        phi_486_ = _e308;
        phi_487_ = select(u32(), _e237.member_1, _e270);
        phi_488_ = _e310;
        phi_489_ = select(u32(), _e264, _e270);
        if !(select(false, true, _e270)) {
            let _e319 = _e237.member_2.xy;
            let _e320 = _e243.member_2.xy;
            let _e321 = min(_e319, _e320);
            let _e322 = _e237.member_2.zw;
            let _e323 = _e243.member_2.zw;
            let _e324 = max(_e322, _e323);
            let _e329 = vec4<f32>(_e321.x, _e321.y, _e324.x, _e324.y);
            let _e332 = (_e329.zw - _e329.xy);
            let _e337 = _e249.member_2.xy;
            let _e338 = min(_e319, _e337);
            let _e339 = _e249.member_2.zw;
            let _e340 = max(_e322, _e339);
            let _e345 = vec4<f32>(_e338.x, _e338.y, _e340.x, _e340.y);
            let _e348 = (_e345.zw - _e345.xy);
            let _e353 = _e255.member_2.xy;
            let _e354 = min(_e337, _e353);
            let _e355 = _e255.member_2.zw;
            let _e356 = max(_e339, _e355);
            let _e361 = vec4<f32>(_e354.x, _e354.y, _e356.x, _e356.y);
            let _e364 = (_e361.zw - _e361.xy);
            let _e369 = min(_e320, _e353);
            let _e370 = max(_e323, _e355);
            let _e375 = vec4<f32>(_e369.x, _e369.y, _e370.x, _e370.y);
            let _e378 = (_e375.zw - _e375.xy);
            let _e385 = ((max(0.0, (_e332.x * _e332.y)) + max(0.0, (_e364.x * _e364.y))) > (max(0.0, (_e348.x * _e348.y)) + max(0.0, (_e378.x * _e378.y))));
            let _e386 = select(_e249.member, _e243.member, _e385);
            let _e387 = select(_e249.member_1, _e243.member_1, _e385);
            let _e388 = vec4(_e385);
            let _e389 = select(_e249.member_2, _e243.member_2, _e388);
            let _e390 = select(_e249.member_3, _e243.member_3, _e385);
            let _e391 = select(_e243.member, _e249.member, _e385);
            let _e392 = select(_e243.member_1, _e249.member_1, _e385);
            let _e393 = select(_e243.member_2, _e249.member_2, _e388);
            let _e394 = select(_e243.member_3, _e249.member_3, _e385);
            let _e395 = (_e260 + 12u);
            switch bitcast<i32>(0u) {
                default: {
                    global.member[_e395] = bitcast<vec4<f32>>(vec4<u32>(_e237.member, _e237.member_1, _e391, _e392));
                    let _e402 = (_e237.member_3 == 0u);
                    global.member[(_e260 + 13u)] = select(_e237.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e402));
                    let _e408 = (_e394 == 0u);
                    global.member[(_e260 + 14u)] = select(_e393, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e408));
                    if _e408 {
                        phi_443_ = _e237.member;
                        phi_444_ = _e237.member_1;
                        phi_445_ = _e237.member_2;
                        phi_446_ = _e237.member_3;
                        break;
                    } else {
                        if _e402 {
                            phi_443_ = _e391;
                            phi_444_ = _e392;
                            phi_445_ = _e393;
                            phi_446_ = _e394;
                            break;
                        }
                    }
                    let _e415 = min(_e319, _e393.xy);
                    let _e417 = max(_e322, _e393.zw);
                    phi_443_ = 0u;
                    phi_444_ = _e395;
                    phi_445_ = vec4<f32>(_e415.x, _e415.y, _e417.x, _e417.y);
                    phi_446_ = (_e237.member_3 + _e394);
                    break;
                }
            }
            let _e424 = phi_443_;
            let _e426 = phi_444_;
            let _e428 = phi_445_;
            let _e430 = phi_446_;
            let _e431 = (_e260 + 15u);
            switch bitcast<i32>(0u) {
                default: {
                    global.member[_e431] = bitcast<vec4<f32>>(vec4<u32>(_e386, _e387, _e255.member, _e255.member_1));
                    let _e438 = (_e390 == 0u);
                    global.member[(_e260 + 16u)] = select(_e389, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e438));
                    let _e444 = (_e255.member_3 == 0u);
                    global.member[(_e260 + 17u)] = select(_e255.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e444));
                    if _e444 {
                        phi_478_ = _e386;
                        phi_479_ = _e387;
                        phi_480_ = _e389;
                        phi_481_ = _e390;
                        break;
                    } else {
                        if _e438 {
                            phi_478_ = _e255.member;
                            phi_479_ = _e255.member_1;
                            phi_480_ = _e255.member_2;
                            phi_481_ = _e255.member_3;
                            break;
                        }
                    }
                    let _e451 = min(_e389.xy, _e353);
                    let _e453 = max(_e389.zw, _e355);
                    phi_478_ = 0u;
                    phi_479_ = _e431;
                    phi_480_ = vec4<f32>(_e451.x, _e451.y, _e453.x, _e453.y);
                    phi_481_ = (_e390 + _e255.member_3);
                    break;
                }
            }
            let _e460 = phi_478_;
            let _e462 = phi_479_;
            let _e464 = phi_480_;
            let _e466 = phi_481_;
            phi_482_ = _e460;
            phi_483_ = _e462;
            phi_484_ = _e464;
            phi_485_ = _e466;
            phi_486_ = _e424;
            phi_487_ = _e426;
            phi_488_ = _e428;
            phi_489_ = _e430;
        }
        let _e468 = phi_482_;
        let _e470 = phi_483_;
        let _e472 = phi_484_;
        let _e474 = phi_485_;
        let _e476 = phi_486_;
        let _e478 = phi_487_;
        let _e480 = phi_488_;
        let _e482 = phi_489_;
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e261] = bitcast<vec4<f32>>(vec4<u32>(_e476, _e478, _e468, _e470));
                let _e489 = (_e482 == 0u);
                global.member[(_e260 + 10u)] = select(_e480, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e489));
                let _e495 = (_e474 == 0u);
                global.member[(_e260 + 11u)] = select(_e472, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e495));
                if _e495 {
                    phi_522_ = _e476;
                    phi_523_ = _e478;
                    phi_524_ = _e480;
                    phi_525_ = _e482;
                    break;
                } else {
                    if _e489 {
                        phi_522_ = _e468;
                        phi_523_ = _e470;
                        phi_524_ = _e472;
                        phi_525_ = _e474;
                        break;
                    }
                }
                let _e503 = min(_e480.xy, _e472.xy);
                let _e506 = max(_e480.zw, _e472.zw);
                phi_522_ = 0u;
                phi_523_ = _e261;
                phi_524_ = vec4<f32>(_e503.x, _e503.y, _e506.x, _e506.y);
                phi_525_ = (_e482 + _e474);
                break;
            }
        }
        let _e513 = phi_522_;
        let _e515 = phi_523_;
        let _e517 = phi_524_;
        let _e519 = phi_525_;
        global_2[((_e55.y * 2u) + _e55.x)] = type_3(_e513, _e515, _e517, _e519);
        phi_528_ = _e468;
        phi_529_ = _e470;
        phi_530_ = _e472;
        phi_531_ = _e474;
        phi_532_ = _e476;
        phi_533_ = _e478;
        phi_534_ = _e480;
        phi_535_ = _e482;
    }
    let _e523 = phi_528_;
    let _e525 = phi_529_;
    let _e527 = phi_530_;
    let _e529 = phi_531_;
    let _e531 = phi_532_;
    let _e533 = phi_533_;
    let _e535 = phi_534_;
    workgroupBarrier();
    let _e537 = phi_535_;
    if all((_e56 < vec2<u32>(1u, 1u))) {
        let _e540 = (_e56 * vec2<u32>(2u, 2u));
        let _e545 = (_e540 + vec2<u32>(1u, 0u));
        let _e550 = (_e540 + vec2<u32>(0u, 1u));
        let _e555 = (_e540 + vec2<u32>(1u, 1u));
        let _e561 = global_2[((_e540.y * 2u) + _e540.x)];
        let _e567 = global_2[((_e545.y * 2u) + _e545.x)];
        let _e573 = global_2[((_e550.y * 2u) + _e550.x)];
        let _e579 = global_2[((_e555.y * 2u) + _e555.x)];
        let _e584 = (9u * _e77);
        let _e587 = (((_e561.member_3 + _e567.member_3) + _e573.member_3) + _e579.member_3);
        let _e593 = ((_e587 <= 16u) && all(((vec4<u32>(_e561.member, _e567.member, _e573.member, _e579.member) & vec4<u32>(1u, 1u, 1u, 1u)) == vec4<u32>(1u, 1u, 1u, 1u))));
        phi_631_ = _e531;
        phi_632_ = _e535;
        if _e593 {
            let _e596 = min(_e561.member_2.xy, _e567.member_2.xy);
            let _e599 = max(_e561.member_2.zw, _e567.member_2.zw);
            let _e604 = vec4<f32>(_e596.x, _e596.y, _e599.x, _e599.y);
            let _e607 = min(_e573.member_2.xy, _e579.member_2.xy);
            let _e610 = max(_e573.member_2.zw, _e579.member_2.zw);
            let _e615 = vec4<f32>(_e607.x, _e607.y, _e610.x, _e610.y);
            let _e618 = min(_e604.xy, _e615.xy);
            let _e621 = max(_e604.zw, _e615.zw);
            phi_631_ = (1u | (_e587 << bitcast<u32>(1)));
            phi_632_ = vec4<f32>(_e618.x, _e618.y, _e621.x, _e621.y);
        }
        let _e631 = phi_631_;
        let _e633 = phi_632_;
        phi_790_ = select(_e523, 1u, _e593);
        phi_791_ = select(_e525, 0u, _e593);
        phi_792_ = select(_e527, vec4<f32>(1.0, 1.0, -1.0, -1.0), vec4(_e593));
        phi_793_ = select(_e529, 0u, _e593);
        phi_794_ = _e631;
        phi_795_ = select(_e533, _e561.member_1, _e593);
        phi_796_ = _e633;
        phi_797_ = select(_e537, _e587, _e593);
        if !(select(false, true, _e593)) {
            let _e643 = _e561.member_2.xy;
            let _e644 = _e567.member_2.xy;
            let _e645 = min(_e643, _e644);
            let _e646 = _e561.member_2.zw;
            let _e647 = _e567.member_2.zw;
            let _e648 = max(_e646, _e647);
            let _e653 = vec4<f32>(_e645.x, _e645.y, _e648.x, _e648.y);
            let _e656 = (_e653.zw - _e653.xy);
            let _e661 = _e573.member_2.xy;
            let _e662 = min(_e643, _e661);
            let _e663 = _e573.member_2.zw;
            let _e664 = max(_e646, _e663);
            let _e669 = vec4<f32>(_e662.x, _e662.y, _e664.x, _e664.y);
            let _e672 = (_e669.zw - _e669.xy);
            let _e677 = _e579.member_2.xy;
            let _e678 = min(_e661, _e677);
            let _e679 = _e579.member_2.zw;
            let _e680 = max(_e663, _e679);
            let _e685 = vec4<f32>(_e678.x, _e678.y, _e680.x, _e680.y);
            let _e688 = (_e685.zw - _e685.xy);
            let _e693 = min(_e644, _e677);
            let _e694 = max(_e647, _e679);
            let _e699 = vec4<f32>(_e693.x, _e693.y, _e694.x, _e694.y);
            let _e702 = (_e699.zw - _e699.xy);
            let _e709 = ((max(0.0, (_e656.x * _e656.y)) + max(0.0, (_e688.x * _e688.y))) > (max(0.0, (_e672.x * _e672.y)) + max(0.0, (_e702.x * _e702.y))));
            let _e710 = select(_e573.member, _e567.member, _e709);
            let _e711 = select(_e573.member_1, _e567.member_1, _e709);
            let _e712 = vec4(_e709);
            let _e713 = select(_e573.member_2, _e567.member_2, _e712);
            let _e714 = select(_e573.member_3, _e567.member_3, _e709);
            let _e715 = select(_e567.member, _e573.member, _e709);
            let _e716 = select(_e567.member_1, _e573.member_1, _e709);
            let _e717 = select(_e567.member_2, _e573.member_2, _e712);
            let _e718 = select(_e567.member_3, _e573.member_3, _e709);
            let _e719 = (_e584 + 3u);
            switch bitcast<i32>(0u) {
                default: {
                    global.member[_e719] = bitcast<vec4<f32>>(vec4<u32>(_e561.member, _e561.member_1, _e715, _e716));
                    let _e726 = (_e561.member_3 == 0u);
                    global.member[(_e584 + 4u)] = select(_e561.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e726));
                    let _e732 = (_e718 == 0u);
                    global.member[(_e584 + 5u)] = select(_e717, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e732));
                    if _e732 {
                        phi_751_ = _e561.member;
                        phi_752_ = _e561.member_1;
                        phi_753_ = _e561.member_2;
                        phi_754_ = _e561.member_3;
                        break;
                    } else {
                        if _e726 {
                            phi_751_ = _e715;
                            phi_752_ = _e716;
                            phi_753_ = _e717;
                            phi_754_ = _e718;
                            break;
                        }
                    }
                    let _e739 = min(_e643, _e717.xy);
                    let _e741 = max(_e646, _e717.zw);
                    phi_751_ = 0u;
                    phi_752_ = _e719;
                    phi_753_ = vec4<f32>(_e739.x, _e739.y, _e741.x, _e741.y);
                    phi_754_ = (_e561.member_3 + _e718);
                    break;
                }
            }
            let _e748 = phi_751_;
            let _e750 = phi_752_;
            let _e752 = phi_753_;
            let _e754 = phi_754_;
            let _e755 = (_e584 + 6u);
            switch bitcast<i32>(0u) {
                default: {
                    global.member[_e755] = bitcast<vec4<f32>>(vec4<u32>(_e710, _e711, _e579.member, _e579.member_1));
                    let _e762 = (_e714 == 0u);
                    global.member[(_e584 + 7u)] = select(_e713, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e762));
                    let _e768 = (_e579.member_3 == 0u);
                    global.member[(_e584 + 8u)] = select(_e579.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e768));
                    if _e768 {
                        phi_786_ = _e710;
                        phi_787_ = _e711;
                        phi_788_ = _e713;
                        phi_789_ = _e714;
                        break;
                    } else {
                        if _e762 {
                            phi_786_ = _e579.member;
                            phi_787_ = _e579.member_1;
                            phi_788_ = _e579.member_2;
                            phi_789_ = _e579.member_3;
                            break;
                        }
                    }
                    let _e775 = min(_e713.xy, _e677);
                    let _e777 = max(_e713.zw, _e679);
                    phi_786_ = 0u;
                    phi_787_ = _e755;
                    phi_788_ = vec4<f32>(_e775.x, _e775.y, _e777.x, _e777.y);
                    phi_789_ = (_e714 + _e579.member_3);
                    break;
                }
            }
            let _e784 = phi_786_;
            let _e786 = phi_787_;
            let _e788 = phi_788_;
            let _e790 = phi_789_;
            phi_790_ = _e784;
            phi_791_ = _e786;
            phi_792_ = _e788;
            phi_793_ = _e790;
            phi_794_ = _e748;
            phi_795_ = _e750;
            phi_796_ = _e752;
            phi_797_ = _e754;
        }
        let _e792 = phi_790_;
        let _e794 = phi_791_;
        let _e796 = phi_792_;
        let _e798 = phi_793_;
        let _e800 = phi_794_;
        let _e802 = phi_795_;
        let _e804 = phi_796_;
        let _e806 = phi_797_;
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e584] = bitcast<vec4<f32>>(vec4<u32>(_e800, _e802, _e792, _e794));
                let _e813 = (_e806 == 0u);
                global.member[(_e584 + 1u)] = select(_e804, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e813));
                let _e819 = (_e798 == 0u);
                global.member[(_e584 + 2u)] = select(_e796, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e819));
                if _e819 {
                    break;
                } else {
                    if _e813 {
                        break;
                    }
                }
                break;
            }
        }
    }
    return;
}

@compute @workgroup_size(4, 4, 1) 
fn main(@builtin(local_invocation_id) param: vec3<u32>) {
    global_3 = param;
    function();
}
