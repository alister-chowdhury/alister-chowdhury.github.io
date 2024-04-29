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
var<workgroup> global_2: array<f32, 1024>;
@group(0) @binding(0) 
var<uniform> global_3: type_16;
var<private> global_4: vec3<u32>;
var<private> global_5: vec3<u32>;
@group(0) @binding(3) 
var<storage, read_write> global_6: type_22;

fn function() {
    var phi_96_: vec2<i32>;
    var phi_99_: i32;
    var phi_119_: f32;
    var local: i32;
    var phi_158_: i32;
    var phi_161_: f32;
    var phi_163_: u32;
    var local_1: f32;
    var local_2: i32;
    var phi_194_: f32;
    var phi_197_: vec2<i32>;
    var phi_199_: u32;
    var phi_198_: vec2<i32>;
    var local_3: vec2<i32>;
    var local_4: vec2<i32>;
    var local_5: vec2<i32>;
    var local_6: f32;
    var local_7: vec2<i32>;

    let _e37 = global_3.member;
    let _e47 = global_4;
    let _e49 = bitcast<vec2<i32>>(_e47.xy);
    let _e50 = global_5;
    let _e54 = ((bitcast<vec2<i32>>(_e50.xy) * vec2<i32>(2i, 2i)) + bitcast<vec2<i32>>(_e37.member.xy));
    let _e59 = ((_e54.y * bitcast<vec2<i32>>(_e37.member.zw).x) + _e54.x);
    let _e60 = (_e59 * 1024i);
    phi_96_ = _e49;
    phi_99_ = 0i;
    loop {
        let _e62 = phi_96_;
        let _e64 = phi_99_;
        if (_e64 < 16i) {
            let _e67 = (_e62.y * 32i);
            let _e70 = ((_e60 + _e67) + _e62.x);
            local = _e62.y;
            switch bitcast<i32>(0u) {
                default: {
                    let _e75 = global.member[_e70];
                    if (_e75 == 0f) {
                        let _e79 = global_1.member[_e70];
                        phi_119_ = _e79;
                        break;
                    }
                    phi_119_ = 100000000000000000000000000000000000f;
                    break;
                }
            }
            let _e81 = phi_119_;
            global_2[(_e67 + _e62.x)] = _e81;
            continue;
        } else {
            break;
        }
        continuing {
            let _e85 = local;
            phi_96_ = vec2<i32>(_e62.x, (_e85 + 2i));
            phi_99_ = (_e64 + 1i);
        }
    }
    workgroupBarrier();
    let _e91 = bitcast<vec2<u32>>((_e54 * vec2<i32>(32i, 32i)));
    let _e92 = (_e91 + vec2<u32>(1u, 1u));
    let _e104 = (((1405471321u ^ (((3041117094u ^ _e92.x) * (1383044322u ^ _e92.y)) >> bitcast<u32>(5u))) * (1953774619u ^ bitcast<u32>(_e37.member_1.z))) >> bitcast<u32>(3i));
    let _e105 = (_e91 + vec2<u32>(13u, 11u));
    let _e117 = (((1405471321u ^ (((3041117094u ^ _e105.x) * (1383044322u ^ _e105.y)) >> bitcast<u32>(5u))) * (1953774619u ^ _e104)) >> bitcast<u32>(5i));
    let _e119 = (_e49.y == 0i);
    if _e119 {
        let _e122 = bitcast<i32>((_e104 & 31u));
        let _e126 = global_2[((_e122 * 32i) + _e49.x)];
        phi_158_ = _e122;
        phi_161_ = _e126;
        phi_163_ = 1u;
        loop {
            let _e128 = phi_158_;
            let _e130 = phi_161_;
            let _e132 = phi_163_;
            local_1 = _e130;
            local_2 = _e128;
            if (_e132 < 32u) {
                continue;
            } else {
                break;
            }
            continuing {
                let _e136 = bitcast<i32>(((_e104 ^ _e132) & 31u));
                let _e140 = global_2[((_e136 * 32i) + _e49.x)];
                let _e141 = (_e140 < _e130);
                phi_158_ = select(_e128, _e136, _e141);
                phi_161_ = select(_e130, _e140, _e141);
                phi_163_ = (_e132 + bitcast<u32>(1i));
            }
        }
        let _e148 = local_1;
        global_2[_e49.x] = _e148;
        let _e151 = local_2;
        global_2[(32i + _e49.x)] = bitcast<f32>(_e151);
    }
    workgroupBarrier();
    let _e155 = (_e49.x == 0i);
    if select(_e155, _e119, _e155) {
        let _e158 = bitcast<i32>((_e117 & 31u));
        let _e160 = global_2[_e158];
        let _e163 = global_2[(32i + _e158)];
        phi_194_ = _e160;
        phi_197_ = vec2<i32>(_e158, bitcast<i32>(_e163));
        phi_199_ = 1u;
        loop {
            let _e167 = phi_194_;
            let _e169 = phi_197_;
            let _e171 = phi_199_;
            local_3 = _e169;
            local_4 = _e169;
            local_5 = _e169;
            if (_e171 < 32u) {
                let _e175 = bitcast<i32>(((_e117 ^ _e171) & 31u));
                let _e177 = global_2[_e175];
                let _e178 = (_e177 < _e167);
                phi_198_ = _e169;
                if _e178 {
                    let _e181 = global_2[(32i + _e175)];
                    phi_198_ = vec2<i32>(_e175, bitcast<i32>(_e181));
                }
                let _e185 = phi_198_;
                local_6 = select(_e167, _e177, _e178);
                local_7 = _e185;
                continue;
            } else {
                break;
            }
            continuing {
                let _e219 = local_6;
                phi_194_ = _e219;
                let _e222 = local_7;
                phi_197_ = _e222;
                phi_199_ = (_e171 + bitcast<u32>(1i));
            }
        }
        let _e190 = local_3;
        let _e195 = local_4;
        let _e199 = local_5;
        let _e200 = vec2<f32>(_e199);
        global_6.member[_e59] = vec4<f32>(_e200.x, _e200.y, _e37.member_1.y, 0f);
        global.member[((_e60 + (_e190.y * 32i)) + _e195.x)] = _e37.member_1.y;
    }
    return;
}

@compute @workgroup_size(32, 2, 1) 
fn main(@builtin(local_invocation_id) param: vec3<u32>, @builtin(workgroup_id) param_1: vec3<u32>) {
    global_4 = param;
    global_5 = param_1;
    function();
}
