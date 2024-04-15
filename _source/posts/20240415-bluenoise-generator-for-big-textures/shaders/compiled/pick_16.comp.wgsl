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
var<workgroup> global_2: array<f32, 256>;
@group(0) @binding(0) 
var<uniform> global_3: type_16;
var<private> global_4: vec3<u32>;
var<private> global_5: vec3<u32>;
@group(0) @binding(3) 
var<storage, read_write> global_6: type_22;

fn function() {
    var phi_97_: vec2<i32>;
    var phi_100_: i32;
    var phi_120_: f32;
    var local: i32;
    var phi_159_: i32;
    var phi_162_: f32;
    var phi_164_: u32;
    var local_1: f32;
    var local_2: i32;
    var phi_195_: f32;
    var phi_198_: vec2<i32>;
    var phi_200_: u32;
    var phi_199_: vec2<i32>;
    var local_3: vec2<i32>;
    var local_4: vec2<i32>;
    var local_5: vec2<i32>;
    var local_6: f32;
    var local_7: vec2<i32>;

    let _e38 = global_3.member;
    let _e48 = global_4;
    let _e50 = bitcast<vec2<i32>>(_e48.xy);
    let _e51 = global_5;
    let _e55 = ((bitcast<vec2<i32>>(_e51.xy) * vec2<i32>(2i, 2i)) + bitcast<vec2<i32>>(_e38.member.xy));
    let _e60 = ((_e55.y * bitcast<vec2<i32>>(_e38.member.zw).x) + _e55.x);
    let _e61 = (_e60 * 256i);
    phi_97_ = _e50;
    phi_100_ = 0i;
    loop {
        let _e63 = phi_97_;
        let _e65 = phi_100_;
        if (_e65 < 4i) {
            let _e68 = (_e63.y * 16i);
            let _e71 = ((_e61 + _e68) + _e63.x);
            local = _e63.y;
            switch bitcast<i32>(0u) {
                default: {
                    let _e76 = global.member[_e71];
                    if (_e76 == 0f) {
                        let _e80 = global_1.member[_e71];
                        phi_120_ = _e80;
                        break;
                    }
                    phi_120_ = 100000000000000000000000000000000000f;
                    break;
                }
            }
            let _e82 = phi_120_;
            global_2[(_e68 + _e63.x)] = _e82;
            continue;
        } else {
            break;
        }
        continuing {
            let _e86 = local;
            phi_97_ = vec2<i32>(_e63.x, (_e86 + 4i));
            phi_100_ = (_e65 + 1i);
        }
    }
    workgroupBarrier();
    let _e92 = bitcast<vec2<u32>>((_e55 * vec2<i32>(16i, 16i)));
    let _e93 = (_e92 + vec2<u32>(1u, 1u));
    let _e105 = (((1405471321u ^ (((3041117094u ^ _e93.x) * (1383044322u ^ _e93.y)) >> bitcast<u32>(5u))) * (1953774619u ^ bitcast<u32>(_e38.member_1.z))) >> bitcast<u32>(3i));
    let _e106 = (_e92 + vec2<u32>(13u, 11u));
    let _e118 = (((1405471321u ^ (((3041117094u ^ _e106.x) * (1383044322u ^ _e106.y)) >> bitcast<u32>(5u))) * (1953774619u ^ _e105)) >> bitcast<u32>(5i));
    let _e120 = (_e50.y == 0i);
    if _e120 {
        let _e123 = bitcast<i32>((_e105 & 15u));
        let _e127 = global_2[((_e123 * 16i) + _e50.x)];
        phi_159_ = _e123;
        phi_162_ = _e127;
        phi_164_ = 1u;
        loop {
            let _e129 = phi_159_;
            let _e131 = phi_162_;
            let _e133 = phi_164_;
            local_1 = _e131;
            local_2 = _e129;
            if (_e133 < 16u) {
                continue;
            } else {
                break;
            }
            continuing {
                let _e137 = bitcast<i32>(((_e105 ^ _e133) & 15u));
                let _e141 = global_2[((_e137 * 16i) + _e50.x)];
                let _e142 = (_e141 < _e131);
                phi_159_ = select(_e129, _e137, _e142);
                phi_162_ = select(_e131, _e141, _e142);
                phi_164_ = (_e133 + bitcast<u32>(1i));
            }
        }
        let _e149 = local_1;
        global_2[_e50.x] = _e149;
        let _e152 = local_2;
        global_2[(16i + _e50.x)] = bitcast<f32>(_e152);
    }
    workgroupBarrier();
    let _e156 = (_e50.x == 0i);
    if select(_e156, _e120, _e156) {
        let _e159 = bitcast<i32>((_e118 & 15u));
        let _e161 = global_2[_e159];
        let _e164 = global_2[(16i + _e159)];
        phi_195_ = _e161;
        phi_198_ = vec2<i32>(_e159, bitcast<i32>(_e164));
        phi_200_ = 1u;
        loop {
            let _e168 = phi_195_;
            let _e170 = phi_198_;
            let _e172 = phi_200_;
            local_3 = _e170;
            local_4 = _e170;
            local_5 = _e170;
            if (_e172 < 16u) {
                let _e176 = bitcast<i32>(((_e118 ^ _e172) & 15u));
                let _e178 = global_2[_e176];
                let _e179 = (_e178 < _e168);
                phi_199_ = _e170;
                if _e179 {
                    let _e182 = global_2[(16i + _e176)];
                    phi_199_ = vec2<i32>(_e176, bitcast<i32>(_e182));
                }
                let _e186 = phi_199_;
                local_6 = select(_e168, _e178, _e179);
                local_7 = _e186;
                continue;
            } else {
                break;
            }
            continuing {
                let _e220 = local_6;
                phi_195_ = _e220;
                let _e223 = local_7;
                phi_198_ = _e223;
                phi_200_ = (_e172 + bitcast<u32>(1i));
            }
        }
        let _e191 = local_3;
        let _e196 = local_4;
        let _e200 = local_5;
        let _e201 = vec2<f32>(_e200);
        global_6.member[_e60] = vec4<f32>(_e201.x, _e201.y, _e38.member_1.y, 0f);
        global.member[((_e61 + (_e191.y * 16i)) + _e196.x)] = _e38.member_1.y;
    }
    return;
}

@compute @workgroup_size(16, 4, 1) 
fn main(@builtin(local_invocation_id) param: vec3<u32>, @builtin(workgroup_id) param_1: vec3<u32>) {
    global_4 = param;
    global_5 = param_1;
    function();
}
