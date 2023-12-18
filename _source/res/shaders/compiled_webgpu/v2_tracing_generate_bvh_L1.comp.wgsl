struct type_3 {
    member: u32,
    member_1: u32,
    member_2: vec4<f32>,
    member_3: u32,
}

struct type_9 {
    member: array<vec4<f32>>,
}

struct type_12 {
    member: u32,
}

@group(0) @binding(1) 
var<storage, read_write> global: type_9;
var<workgroup> global_1: array<type_3, 4>;
var<private> global_2: vec3<u32>;
@group(0) @binding(2) 
var<uniform> global_3: type_12;
@group(0) @binding(0) 
var<storage, read_write> global_4: type_9;
var<workgroup> global_5: array<u32, 4>;

fn function() {
    var phi_101_: u32;
    var phi_104_: u32;
    var phi_106_: vec4<f32>;
    var phi_108_: u32;
    var phi_110_: u32;
    var phi_131_: bool;
    var phi_102_: u32;
    var phi_105_: u32;
    var phi_107_: vec4<f32>;
    var phi_109_: u32;
    var local: u32;
    var phi_158_: u32;
    var phi_161_: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: vec4<f32>;
    var local_4: u32;
    var phi_172_: u32;
    var phi_175_: u32;
    var local_5: u32;
    var phi_194_: bool;
    var phi_173_: u32;
    var phi_361_: u32;
    var phi_362_: u32;
    var phi_363_: vec4<f32>;
    var phi_364_: u32;
    var phi_396_: u32;
    var phi_397_: u32;
    var phi_398_: vec4<f32>;
    var phi_399_: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: vec4<f32>;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;

    let _e34 = global_2;
    let _e35 = _e34.xy;
    let _e40 = (_e34.x | (_e34.y << bitcast<u32>(16)));
    let _e44 = ((_e40 | (_e40 << bitcast<u32>(4))) & 252645135u);
    let _e48 = ((_e44 | (_e44 << bitcast<u32>(2))) & 858993459u);
    let _e52 = ((_e48 | (_e48 << bitcast<u32>(1))) & 1431655765u);
    let _e56 = ((_e52 | (_e52 >> bitcast<u32>(15))) & 65535u);
    let _e57 = vec2<f32>(_e35);
    let _e59 = vec2<f32>((_e35 + vec2<u32>(1u, 1u)));
    let _e64 = vec4<f32>(_e57.x, _e57.y, _e59.x, _e59.y);
    phi_101_ = 0u;
    phi_104_ = 0u;
    phi_106_ = vec4<f32>(1.0, 1.0, -1.0, -1.0);
    phi_108_ = 0u;
    phi_110_ = 0u;
    loop {
        let _e66 = phi_101_;
        let _e68 = phi_104_;
        let _e70 = phi_106_;
        let _e72 = phi_108_;
        let _e74 = phi_110_;
        let _e76 = global_3.member;
        local = _e72;
        local_1 = _e72;
        local_3 = _e70;
        local_4 = _e72;
        local_12 = _e68;
        local_5 = _e66;
        if (_e74 < _e76) {
            let _e80 = global_4.member[_e74];
            let _e81 = _e80.xy;
            let _e82 = _e80.zw;
            let _e84 = ((_e81 + _e82) * 0.5);
            let _e87 = all((_e84 >= _e64.xy));
            phi_131_ = _e87;
            if _e87 {
                phi_131_ = all((_e84 < _e64.zw));
            }
            let _e92 = phi_131_;
            phi_102_ = _e66;
            phi_105_ = _e68;
            phi_107_ = _e70;
            phi_109_ = _e72;
            if _e92 {
                let _e96 = min(_e81, _e82);
                let _e97 = max(_e81, _e82);
                let _e102 = vec4<f32>(_e96.x, _e96.y, _e97.x, _e97.y);
                let _e105 = min(_e70.xy, _e102.xy);
                let _e108 = max(_e70.zw, _e102.zw);
                phi_102_ = (_e74 + 1u);
                phi_105_ = select(_e68, _e74, (_e72 == 0u));
                phi_107_ = vec4<f32>(_e105.x, _e105.y, _e108.x, _e108.y);
                phi_109_ = (_e72 + bitcast<u32>(1));
            }
            let _e117 = phi_102_;
            let _e119 = phi_105_;
            let _e121 = phi_107_;
            let _e123 = phi_109_;
            local_6 = _e117;
            local_7 = _e119;
            local_8 = _e121;
            local_9 = _e123;
            continue;
        } else {
            break;
        }
        continuing {
            let _e402 = local_6;
            phi_101_ = _e402;
            let _e405 = local_7;
            phi_104_ = _e405;
            let _e408 = local_8;
            phi_106_ = _e408;
            let _e411 = local_9;
            phi_108_ = _e411;
            phi_110_ = (_e74 + bitcast<u32>(1));
        }
    }
    let _e128 = local;
    global_5[_e56] = _e128;
    workgroupBarrier();
    phi_158_ = 9u;
    phi_161_ = 0u;
    loop {
        let _e130 = phi_158_;
        let _e132 = phi_161_;
        local_2 = _e130;
        local_10 = _e130;
        if (_e132 < _e56) {
            continue;
        } else {
            break;
        }
        continuing {
            let _e135 = global_5[_e132];
            phi_158_ = (_e130 + _e135);
            phi_161_ = (_e132 + bitcast<u32>(1));
        }
    }
    let _e140 = local_1;
    let _e144 = local_2;
    let _e147 = local_3;
    let _e149 = local_4;
    global_1[_e56] = type_3(1u, (_e144 | (_e140 << bitcast<u32>(24))), _e147, _e149);
    workgroupBarrier();
    let _e427 = local_10;
    phi_172_ = _e427;
    let _e432 = local_12;
    phi_175_ = _e432;
    loop {
        let _e153 = phi_172_;
        let _e155 = phi_175_;
        let _e157 = local_5;
        if (_e155 < _e157) {
            let _e161 = global_4.member[_e155];
            let _e162 = _e161.xy;
            let _e163 = _e161.zw;
            let _e165 = ((_e162 + _e163) * 0.5);
            let _e168 = all((_e165 >= _e64.xy));
            phi_194_ = _e168;
            if _e168 {
                phi_194_ = all((_e165 < _e64.zw));
            }
            let _e173 = phi_194_;
            phi_173_ = _e153;
            if _e173 {
                let _e176 = (_e162 - _e163);
                global.member[_e153] = vec4<f32>(_e161.x, _e161.y, _e176.x, _e176.y);
                phi_173_ = (_e153 + bitcast<u32>(1));
            }
            let _e185 = phi_173_;
            local_11 = _e185;
            continue;
        } else {
            break;
        }
        continuing {
            let _e429 = local_11;
            phi_172_ = _e429;
            phi_175_ = (_e155 + bitcast<u32>(1));
        }
    }
    if all((_e35 < vec2<u32>(1u, 1u))) {
        let _e190 = (_e35 * vec2<u32>(2u, 2u));
        let _e195 = (_e190 + vec2<u32>(1u, 0u));
        let _e200 = (_e190 + vec2<u32>(0u, 1u));
        let _e205 = (_e190 + vec2<u32>(1u, 1u));
        let _e211 = global_1[((_e190.y * 2u) + _e190.x)];
        let _e217 = global_1[((_e195.y * 2u) + _e195.x)];
        let _e223 = global_1[((_e200.y * 2u) + _e200.x)];
        let _e229 = global_1[((_e205.y * 2u) + _e205.x)];
        let _e234 = (9u * _e56);
        let _e235 = _e211.member_2.xy;
        let _e236 = _e217.member_2.xy;
        let _e237 = min(_e235, _e236);
        let _e238 = _e211.member_2.zw;
        let _e239 = _e217.member_2.zw;
        let _e240 = max(_e238, _e239);
        let _e245 = vec4<f32>(_e237.x, _e237.y, _e240.x, _e240.y);
        let _e248 = (_e245.zw - _e245.xy);
        let _e253 = _e223.member_2.xy;
        let _e254 = min(_e235, _e253);
        let _e255 = _e223.member_2.zw;
        let _e256 = max(_e238, _e255);
        let _e261 = vec4<f32>(_e254.x, _e254.y, _e256.x, _e256.y);
        let _e264 = (_e261.zw - _e261.xy);
        let _e269 = _e229.member_2.xy;
        let _e270 = min(_e253, _e269);
        let _e271 = _e229.member_2.zw;
        let _e272 = max(_e255, _e271);
        let _e277 = vec4<f32>(_e270.x, _e270.y, _e272.x, _e272.y);
        let _e280 = (_e277.zw - _e277.xy);
        let _e285 = min(_e236, _e269);
        let _e286 = max(_e239, _e271);
        let _e291 = vec4<f32>(_e285.x, _e285.y, _e286.x, _e286.y);
        let _e294 = (_e291.zw - _e291.xy);
        let _e301 = ((max(0.0, (_e248.x * _e248.y)) + max(0.0, (_e280.x * _e280.y))) > (max(0.0, (_e264.x * _e264.y)) + max(0.0, (_e294.x * _e294.y))));
        let _e302 = select(_e223.member, _e217.member, _e301);
        let _e303 = select(_e223.member_1, _e217.member_1, _e301);
        let _e304 = vec4(_e301);
        let _e305 = select(_e223.member_2, _e217.member_2, _e304);
        let _e306 = select(_e223.member_3, _e217.member_3, _e301);
        let _e307 = select(_e217.member, _e223.member, _e301);
        let _e308 = select(_e217.member_1, _e223.member_1, _e301);
        let _e309 = select(_e217.member_2, _e223.member_2, _e304);
        let _e310 = select(_e217.member_3, _e223.member_3, _e301);
        let _e311 = (_e234 + 3u);
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e311] = bitcast<vec4<f32>>(vec4<u32>(_e211.member, _e211.member_1, _e307, _e308));
                let _e318 = (_e211.member_3 == 0u);
                global.member[(_e234 + 4u)] = select(_e211.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e318));
                let _e324 = (_e310 == 0u);
                global.member[(_e234 + 5u)] = select(_e309, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e324));
                if _e324 {
                    phi_361_ = _e211.member;
                    phi_362_ = _e211.member_1;
                    phi_363_ = _e211.member_2;
                    phi_364_ = _e211.member_3;
                    break;
                } else {
                    if _e318 {
                        phi_361_ = _e307;
                        phi_362_ = _e308;
                        phi_363_ = _e309;
                        phi_364_ = _e310;
                        break;
                    }
                }
                let _e331 = min(_e235, _e309.xy);
                let _e333 = max(_e238, _e309.zw);
                phi_361_ = 0u;
                phi_362_ = _e311;
                phi_363_ = vec4<f32>(_e331.x, _e331.y, _e333.x, _e333.y);
                phi_364_ = (_e211.member_3 + _e310);
                break;
            }
        }
        let _e340 = phi_361_;
        let _e342 = phi_362_;
        let _e344 = phi_363_;
        let _e346 = phi_364_;
        let _e347 = (_e234 + 6u);
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e347] = bitcast<vec4<f32>>(vec4<u32>(_e302, _e303, _e229.member, _e229.member_1));
                let _e354 = (_e306 == 0u);
                global.member[(_e234 + 7u)] = select(_e305, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e354));
                let _e360 = (_e229.member_3 == 0u);
                global.member[(_e234 + 8u)] = select(_e229.member_2, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e360));
                if _e360 {
                    phi_396_ = _e302;
                    phi_397_ = _e303;
                    phi_398_ = _e305;
                    phi_399_ = _e306;
                    break;
                } else {
                    if _e354 {
                        phi_396_ = _e229.member;
                        phi_397_ = _e229.member_1;
                        phi_398_ = _e229.member_2;
                        phi_399_ = _e229.member_3;
                        break;
                    }
                }
                let _e367 = min(_e305.xy, _e269);
                let _e369 = max(_e305.zw, _e271);
                phi_396_ = 0u;
                phi_397_ = _e347;
                phi_398_ = vec4<f32>(_e367.x, _e367.y, _e369.x, _e369.y);
                phi_399_ = (_e306 + _e229.member_3);
                break;
            }
        }
        let _e376 = phi_396_;
        let _e378 = phi_397_;
        let _e380 = phi_398_;
        let _e382 = phi_399_;
        switch bitcast<i32>(0u) {
            default: {
                global.member[_e234] = bitcast<vec4<f32>>(vec4<u32>(_e340, _e342, _e376, _e378));
                let _e389 = (_e346 == 0u);
                global.member[(_e234 + 1u)] = select(_e344, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e389));
                let _e395 = (_e382 == 0u);
                global.member[(_e234 + 2u)] = select(_e380, vec4<f32>(0.0, 0.0, 0.0, 0.0), vec4(_e395));
                if _e395 {
                    break;
                } else {
                    if _e389 {
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
