struct type_8 {
    member: vec2<f32>,
}

struct type_12 {
    member: u32,
}

struct type_17 {
    member: vec2<u32>,
}

struct type_20 {
    member: array<vec4<f32>>,
}

var<private> global: vec3<u32>;
@group(0) @binding(3) 
var<storage, read_write> global_1: type_8;
@group(0) @binding(2) 
var<uniform> global_2: type_12;
@group(0) @binding(1) 
var<uniform> global_3: type_17;
@group(0) @binding(0) 
var<storage> global_4: type_20;
var<workgroup> global_5: array<vec3<f32>, 64>;

fn function() {
    var phi_60_: vec3<f32>;
    var phi_63_: u32;
    var phi_61_: vec3<f32>;
    var local: vec3<f32>;
    var phi_99_: vec3<f32>;
    var phi_102_: i32;
    var phi_120_: vec3<f32>;
    var phi_100_: vec3<f32>;
    var local_1: vec3<f32>;
    var local_2: vec3<f32>;

    let _e20 = global[0u];
    let _e22 = global_1.member;
    phi_60_ = vec3<f32>(_e22.x, _e22.y, 0.00015625);
    phi_63_ = _e20;
    loop {
        let _e27 = phi_60_;
        let _e29 = phi_63_;
        let _e31 = global_2.member;
        local = _e27;
        local_1 = _e27;
        if (_e29 < _e31) {
            let _e35 = global_3.member[0u];
            if (_e29 == _e35) {
                phi_61_ = _e27;
                continue;
            }
            let _e39 = global_4.member[_e29];
            let _e40 = _e39.xy;
            let _e41 = (_e40 - _e22);
            let _e43 = (_e40 - _e39.zw);
            let _e49 = (_e43 * max(0.0, min(1.0, (dot(_e41, _e43) / dot(_e43, _e43)))));
            let _e50 = (_e41 - _e49);
            let _e51 = dot(_e50, _e50);
            let _e52 = (_e40 - _e49);
            phi_61_ = select(_e27, vec3<f32>(_e52.x, _e52.y, _e51), vec3((_e51 < _e27.z)));
            continue;
        } else {
            break;
        }
        continuing {
            let _e61 = phi_61_;
            phi_60_ = _e61;
            phi_63_ = (_e29 + 64u);
        }
    }
    let _e65 = local;
    global_5[_e20] = _e65;
    workgroupBarrier();
    let _e98 = local_1;
    phi_99_ = _e98;
    phi_102_ = 32;
    loop {
        let _e67 = phi_99_;
        let _e69 = phi_102_;
        if (_e69 > 0) {
            let _e71 = bitcast<u32>(_e69);
            phi_100_ = _e67;
            if (_e20 < _e71) {
                let _e75 = global_5[(_e20 + _e71)];
                phi_120_ = _e67;
                if (_e75.z < _e67.z) {
                    global_5[_e20] = _e75;
                    phi_120_ = vec3<f32>(vec3<f32>().x, vec3<f32>().y, _e75.z);
                }
                let _e84 = phi_120_;
                phi_100_ = _e84;
            }
            workgroupBarrier();
            let _e86 = phi_100_;
            local_2 = _e86;
            continue;
        } else {
            break;
        }
        continuing {
            let _e100 = local_2;
            phi_99_ = _e100;
            phi_102_ = (_e69 / 2);
        }
    }
    if (_e20 == 0u) {
        let _e90 = global_5[0];
        global_1.member = _e90.xy;
    }
    return;
}

@compute @workgroup_size(64, 1, 1) 
fn main(@builtin(local_invocation_id) param: vec3<u32>) {
    global = param;
    function();
}
