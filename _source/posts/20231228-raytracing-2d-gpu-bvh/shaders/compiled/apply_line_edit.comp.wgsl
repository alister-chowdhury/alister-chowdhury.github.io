struct type_2 {
    member: vec2<u32>,
}

struct type_10 {
    member: array<vec4<f32>>,
}

struct type_13 {
    member: vec2<f32>,
}

@group(0) @binding(1) 
var<uniform> global: type_2;
@group(0) @binding(0) 
var<storage, read_write> global_1: type_10;
@group(0) @binding(2) 
var<uniform> global_2: type_13;

fn function() {
    let _e12 = global.member[0u];
    if (_e12 != 4294967295u) {
        let _e16 = global.member[1u];
        if (_e16 == 0u) {
            let _e19 = global_2.member;
            global_1.member[_e12][0u] = _e19.x;
            global_1.member[_e12][1u] = _e19.y;
        } else {
            let _e29 = global_2.member;
            global_1.member[_e12][2u] = _e29.x;
            global_1.member[_e12][3u] = _e29.y;
        }
    }
    return;
}

@compute @workgroup_size(1, 1, 1) 
fn main() {
    function();
}
