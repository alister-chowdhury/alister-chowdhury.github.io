struct type_5 {
    member: u32,
}

struct type_12 {
    member: array<vec4<f32>>,
}

struct type_16 {
    member: vec2<f32>,
}

struct type_23 {
    member: vec2<u32>,
}

var<private> global: vec3<u32>;
@group(0) @binding(2) 
var<uniform> global_1: type_5;
@group(0) @binding(0) 
var<storage> global_2: type_12;
@group(0) @binding(3) 
var<uniform> global_3: type_16;
var<workgroup> global_4: array<vec3<u32>, 64>;
@group(0) @binding(1) 
var<storage, read_write> global_5: type_23;

fn function() {
    var phi_52_: f32;
    var phi_55_: u32;
    var phi_57_: u32;
    var phi_59_: u32;
    var local: f32;
    var local_1: u32;
    var local_2: u32;
    var phi_84_: f32;
    var phi_87_: i32;
    var phi_85_: f32;
    var local_3: f32;
    var local_4: f32;

    let _e18 = global[0u];
    phi_52_ = 0.00015625;
    phi_55_ = 0u;
    phi_57_ = 4294967295u;
    phi_59_ = _e18;
    loop {
        let _e20 = phi_52_;
        let _e22 = phi_55_;
        let _e24 = phi_57_;
        let _e26 = phi_59_;
        let _e28 = global_1.member;
        local = _e20;
        local_1 = _e24;
        local_2 = _e22;
        local_3 = _e20;
        if (_e26 < _e28) {
            continue;
        } else {
            break;
        }
        continuing {
            let _e32 = global_2.member[_e26];
            let _e34 = global_3.member;
            let _e36 = (_e32 - _e34.xyxy);
            let _e37 = _e36.xy;
            let _e38 = dot(_e37, _e37);
            let _e39 = _e36.zw;
            let _e40 = dot(_e39, _e39);
            let _e41 = (_e38 < _e20);
            let _e44 = select(_e20, _e38, _e41);
            let _e45 = (_e40 < _e44);
            phi_52_ = select(_e44, _e40, _e45);
            phi_55_ = select(select(_e22, 0u, _e41), 1u, _e45);
            phi_57_ = select(select(_e24, _e26, _e41), _e26, _e45);
            phi_59_ = (_e26 + 64u);
        }
    }
    let _e51 = local;
    let _e54 = local_1;
    let _e56 = local_2;
    global_4[_e18] = vec3<u32>(_e54, _e56, bitcast<u32>(_e51));
    workgroupBarrier();
    let _e90 = local_3;
    phi_84_ = _e90;
    phi_87_ = 32;
    loop {
        let _e60 = phi_84_;
        let _e62 = phi_87_;
        if (_e62 > 0) {
            let _e64 = bitcast<u32>(_e62);
            phi_85_ = _e60;
            if (_e18 < _e64) {
                let _e68 = global_4[(_e18 + _e64)];
                let _e70 = bitcast<f32>(_e68.z);
                let _e71 = (_e70 < _e60);
                if _e71 {
                    global_4[_e18] = _e68;
                }
                phi_85_ = select(_e60, _e70, _e71);
            }
            workgroupBarrier();
            let _e74 = phi_85_;
            local_4 = _e74;
            continue;
        } else {
            break;
        }
        continuing {
            let _e92 = local_4;
            phi_84_ = _e92;
            phi_87_ = (_e62 / 2);
        }
    }
    if (_e18 == 0u) {
        let _e78 = global_4[0];
        global_5.member = _e78.xy;
    }
    return;
}

@compute @workgroup_size(64, 1, 1) 
fn main(@builtin(local_invocation_id) param: vec3<u32>) {
    global = param;
    function();
}
