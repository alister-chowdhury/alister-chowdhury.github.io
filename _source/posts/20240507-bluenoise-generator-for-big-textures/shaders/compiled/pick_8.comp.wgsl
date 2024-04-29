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
    var phi_109_: f32;
    var phi_145_: i32;
    var phi_148_: f32;
    var phi_150_: u32;
    var local: f32;
    var local_1: i32;
    var phi_180_: f32;
    var phi_183_: vec2<i32>;
    var phi_185_: u32;
    var phi_184_: vec2<i32>;
    var local_2: vec2<i32>;
    var local_3: vec2<i32>;
    var local_4: vec2<i32>;
    var local_5: f32;
    var local_6: vec2<i32>;

    let _e36 = global_3.member;
    let _e46 = global_4;
    let _e48 = bitcast<vec2<i32>>(_e46.xy);
    let _e49 = global_5;
    let _e53 = ((bitcast<vec2<i32>>(_e49.xy) * vec2<i32>(2i, 2i)) + bitcast<vec2<i32>>(_e36.member.xy));
    let _e58 = ((_e53.y * bitcast<vec2<i32>>(_e36.member.zw).x) + _e53.x);
    let _e59 = (_e58 * 64i);
    let _e61 = (_e48.y * 8i);
    let _e64 = ((_e59 + _e61) + _e48.x);
    switch bitcast<i32>(0u) {
        default: {
            let _e69 = global.member[_e64];
            if (_e69 == 0f) {
                let _e73 = global_1.member[_e64];
                phi_109_ = _e73;
                break;
            }
            phi_109_ = 100000000000000000000000000000000000f;
            break;
        }
    }
    let _e75 = phi_109_;
    global_2[(_e61 + _e48.x)] = _e75;
    workgroupBarrier();
    let _e78 = bitcast<vec2<u32>>((_e53 * vec2<i32>(8i, 8i)));
    let _e79 = (_e78 + vec2<u32>(1u, 1u));
    let _e91 = (((1405471321u ^ (((3041117094u ^ _e79.x) * (1383044322u ^ _e79.y)) >> bitcast<u32>(5u))) * (1953774619u ^ bitcast<u32>(_e36.member_1.z))) >> bitcast<u32>(3i));
    let _e92 = (_e78 + vec2<u32>(13u, 11u));
    let _e104 = (((1405471321u ^ (((3041117094u ^ _e92.x) * (1383044322u ^ _e92.y)) >> bitcast<u32>(5u))) * (1953774619u ^ _e91)) >> bitcast<u32>(5i));
    let _e105 = (_e48.y == 0i);
    if _e105 {
        let _e107 = bitcast<i32>((_e91 & 7u));
        let _e111 = global_2[((_e107 * 8i) + _e48.x)];
        phi_145_ = _e107;
        phi_148_ = _e111;
        phi_150_ = 1u;
        loop {
            let _e113 = phi_145_;
            let _e115 = phi_148_;
            let _e117 = phi_150_;
            local = _e115;
            local_1 = _e113;
            if (_e117 < 8u) {
                continue;
            } else {
                break;
            }
            continuing {
                let _e121 = bitcast<i32>(((_e91 ^ _e117) & 7u));
                let _e125 = global_2[((_e121 * 8i) + _e48.x)];
                let _e126 = (_e125 < _e115);
                phi_145_ = select(_e113, _e121, _e126);
                phi_148_ = select(_e115, _e125, _e126);
                phi_150_ = (_e117 + bitcast<u32>(1i));
            }
        }
        let _e133 = local;
        global_2[_e48.x] = _e133;
        let _e136 = local_1;
        global_2[(8i + _e48.x)] = bitcast<f32>(_e136);
    }
    workgroupBarrier();
    let _e139 = (_e48.x == 0i);
    if select(_e139, _e105, _e139) {
        let _e142 = bitcast<i32>((_e104 & 7u));
        let _e144 = global_2[_e142];
        let _e147 = global_2[(8i + _e142)];
        phi_180_ = _e144;
        phi_183_ = vec2<i32>(_e142, bitcast<i32>(_e147));
        phi_185_ = 1u;
        loop {
            let _e151 = phi_180_;
            let _e153 = phi_183_;
            let _e155 = phi_185_;
            local_2 = _e153;
            local_3 = _e153;
            local_4 = _e153;
            if (_e155 < 8u) {
                let _e159 = bitcast<i32>(((_e104 ^ _e155) & 7u));
                let _e161 = global_2[_e159];
                let _e162 = (_e161 < _e151);
                phi_184_ = _e153;
                if _e162 {
                    let _e165 = global_2[(8i + _e159)];
                    phi_184_ = vec2<i32>(_e159, bitcast<i32>(_e165));
                }
                let _e169 = phi_184_;
                local_5 = select(_e151, _e161, _e162);
                local_6 = _e169;
                continue;
            } else {
                break;
            }
            continuing {
                let _e200 = local_5;
                phi_180_ = _e200;
                let _e203 = local_6;
                phi_183_ = _e203;
                phi_185_ = (_e155 + bitcast<u32>(1i));
            }
        }
        let _e174 = local_2;
        let _e179 = local_3;
        let _e183 = local_4;
        let _e184 = vec2<f32>(_e183);
        global_6.member[_e58] = vec4<f32>(_e184.x, _e184.y, _e36.member_1.y, 0f);
        global.member[((_e59 + (_e174.y * 8i)) + _e179.x)] = _e36.member_1.y;
    }
    return;
}

@compute @workgroup_size(8, 8, 1) 
fn main(@builtin(local_invocation_id) param: vec3<u32>, @builtin(workgroup_id) param_1: vec3<u32>) {
    global_4 = param;
    global_5 = param_1;
    function();
}
