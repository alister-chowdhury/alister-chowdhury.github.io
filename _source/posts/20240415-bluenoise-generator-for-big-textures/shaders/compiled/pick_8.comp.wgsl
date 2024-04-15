struct type_8 {
    member: array<f32>,
}

struct type_15 {
    member: vec4<f32>,
    member_1: vec4<f32>,
}

struct type_16 {
    member: type_15,
}

struct type_22 {
    member: array<vec4<f32>>,
}

@group(0) @binding(2) 
var<storage, read_write> global: type_8;
@group(0) @binding(1) 
var<storage> global_1: type_8;
var<workgroup> global_2: array<f32, 64>;
@group(0) @binding(0) 
var<uniform> global_3: type_16;
var<private> global_4: vec3<u32>;
var<private> global_5: vec3<u32>;
@group(0) @binding(3) 
var<storage, read_write> global_6: type_22;

fn function() {
    var phi_95_: vec2<i32>;
    var phi_98_: i32;
    var phi_118_: f32;
    var local: i32;
    var phi_157_: i32;
    var phi_160_: f32;
    var phi_162_: u32;
    var local_1: f32;
    var local_2: i32;
    var phi_193_: f32;
    var phi_196_: vec2<i32>;
    var phi_198_: u32;
    var phi_197_: vec2<i32>;
    var local_3: vec2<i32>;
    var local_4: vec2<i32>;
    var local_5: vec2<i32>;
    var local_6: f32;
    var local_7: vec2<i32>;

    let _e36 = global_3.member;
    let _e46 = global_4;
    let _e48 = bitcast<vec2<i32>>(_e46.xy);
    let _e49 = global_5;
    let _e53 = ((bitcast<vec2<i32>>(_e49.xy) * vec2<i32>(2i, 2i)) + bitcast<vec2<i32>>(_e36.member.xy));
    let _e58 = ((_e53.y * bitcast<vec2<i32>>(_e36.member.zw).x) + _e53.x);
    let _e59 = (_e58 * 64i);
    phi_95_ = _e48;
    phi_98_ = 0i;
    loop {
        let _e61 = phi_95_;
        let _e63 = phi_98_;
        if (_e63 < 1i) {
            let _e66 = (_e61.y * 8i);
            let _e69 = ((_e59 + _e66) + _e61.x);
            local = _e61.y;
            switch bitcast<i32>(0u) {
                default: {
                    let _e74 = global.member[_e69];
                    if (_e74 == 0f) {
                        let _e78 = global_1.member[_e69];
                        phi_118_ = _e78;
                        break;
                    }
                    phi_118_ = 100000000000000000000000000000000000f;
                    break;
                }
            }
            let _e80 = phi_118_;
            global_2[(_e66 + _e61.x)] = _e80;
            continue;
        } else {
            break;
        }
        continuing {
            let _e84 = local;
            phi_95_ = vec2<i32>(_e61.x, (_e84 + 8i));
            phi_98_ = (_e63 + 1i);
        }
    }
    workgroupBarrier();
    let _e90 = bitcast<vec2<u32>>((_e53 * vec2<i32>(8i, 8i)));
    let _e91 = (_e90 + vec2<u32>(1u, 1u));
    let _e103 = (((1405471321u ^ (((3041117094u ^ _e91.x) * (1383044322u ^ _e91.y)) >> bitcast<u32>(5u))) * (1953774619u ^ bitcast<u32>(_e36.member_1.z))) >> bitcast<u32>(3i));
    let _e104 = (_e90 + vec2<u32>(13u, 11u));
    let _e116 = (((1405471321u ^ (((3041117094u ^ _e104.x) * (1383044322u ^ _e104.y)) >> bitcast<u32>(5u))) * (1953774619u ^ _e103)) >> bitcast<u32>(5i));
    let _e118 = (_e48.y == 0i);
    if _e118 {
        let _e121 = bitcast<i32>((_e103 & 7u));
        let _e125 = global_2[((_e121 * 8i) + _e48.x)];
        phi_157_ = _e121;
        phi_160_ = _e125;
        phi_162_ = 1u;
        loop {
            let _e127 = phi_157_;
            let _e129 = phi_160_;
            let _e131 = phi_162_;
            local_1 = _e129;
            local_2 = _e127;
            if (_e131 < 8u) {
                continue;
            } else {
                break;
            }
            continuing {
                let _e135 = bitcast<i32>(((_e103 ^ _e131) & 7u));
                let _e139 = global_2[((_e135 * 8i) + _e48.x)];
                let _e140 = (_e139 < _e129);
                phi_157_ = select(_e127, _e135, _e140);
                phi_160_ = select(_e129, _e139, _e140);
                phi_162_ = (_e131 + bitcast<u32>(1i));
            }
        }
        let _e147 = local_1;
        global_2[_e48.x] = _e147;
        let _e150 = local_2;
        global_2[(8i + _e48.x)] = bitcast<f32>(_e150);
    }
    workgroupBarrier();
    let _e154 = (_e48.x == 0i);
    if select(_e154, _e118, _e154) {
        let _e157 = bitcast<i32>((_e116 & 7u));
        let _e159 = global_2[_e157];
        let _e162 = global_2[(8i + _e157)];
        phi_193_ = _e159;
        phi_196_ = vec2<i32>(_e157, bitcast<i32>(_e162));
        phi_198_ = 1u;
        loop {
            let _e166 = phi_193_;
            let _e168 = phi_196_;
            let _e170 = phi_198_;
            local_3 = _e168;
            local_4 = _e168;
            local_5 = _e168;
            if (_e170 < 8u) {
                let _e174 = bitcast<i32>(((_e116 ^ _e170) & 7u));
                let _e176 = global_2[_e174];
                let _e177 = (_e176 < _e166);
                phi_197_ = _e168;
                if _e177 {
                    let _e180 = global_2[(8i + _e174)];
                    phi_197_ = vec2<i32>(_e174, bitcast<i32>(_e180));
                }
                let _e184 = phi_197_;
                local_6 = select(_e166, _e176, _e177);
                local_7 = _e184;
                continue;
            } else {
                break;
            }
            continuing {
                let _e218 = local_6;
                phi_193_ = _e218;
                let _e221 = local_7;
                phi_196_ = _e221;
                phi_198_ = (_e170 + bitcast<u32>(1i));
            }
        }
        let _e189 = local_3;
        let _e194 = local_4;
        let _e198 = local_5;
        let _e199 = vec2<f32>(_e198);
        global_6.member[_e58] = vec4<f32>(_e199.x, _e199.y, _e36.member_1.y, 0f);
        global.member[((_e59 + (_e189.y * 8i)) + _e194.x)] = _e36.member_1.y;
    }
    return;
}

@compute @workgroup_size(8, 8, 1) 
fn main(@builtin(local_invocation_id) param: vec3<u32>, @builtin(workgroup_id) param_1: vec3<u32>) {
    global_4 = param;
    global_5 = param_1;
    function();
}
