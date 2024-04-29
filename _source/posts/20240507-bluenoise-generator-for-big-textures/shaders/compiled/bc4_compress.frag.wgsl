var<private> global: vec4<f32>;
@group(0) @binding(0) 
var global_1: texture_2d<f32>;
var<private> global_2: vec2<u32>;

fn function() {
    var phi_173_: u32;
    var phi_182_: u32;
    var phi_191_: u32;
    var phi_200_: u32;
    var phi_210_: u32;
    var phi_219_: u32;
    var phi_228_: u32;
    var phi_237_: u32;
    var phi_247_: u32;
    var phi_256_: u32;
    var phi_265_: u32;
    var phi_274_: u32;
    var phi_284_: u32;
    var phi_293_: u32;
    var phi_302_: u32;
    var phi_311_: u32;

    let _e44 = global;
    let _e48 = (vec2<i32>(_e44.xy) << bitcast<vec2<u32>>(vec2<i32>(2i, 2i)));
    let _e49 = textureLoad(global_1, _e48, 0i);
    let _e52 = textureLoad(global_1, (_e48 + vec2<i32>(1i, 0i)), 0i);
    let _e55 = textureLoad(global_1, (_e48 + vec2<i32>(2i, 0i)), 0i);
    let _e58 = textureLoad(global_1, (_e48 + vec2<i32>(3i, 0i)), 0i);
    let _e60 = vec4<f32>(_e49.x, _e52.x, _e55.x, _e58.x);
    let _e62 = textureLoad(global_1, (_e48 + vec2<i32>(0i, 1i)), 0i);
    let _e65 = textureLoad(global_1, (_e48 + vec2<i32>(1i, 1i)), 0i);
    let _e68 = textureLoad(global_1, (_e48 + vec2<i32>(2i, 1i)), 0i);
    let _e71 = textureLoad(global_1, (_e48 + vec2<i32>(3i, 1i)), 0i);
    let _e73 = vec4<f32>(_e62.x, _e65.x, _e68.x, _e71.x);
    let _e75 = textureLoad(global_1, (_e48 + vec2<i32>(0i, 2i)), 0i);
    let _e78 = textureLoad(global_1, (_e48 + vec2<i32>(1i, 2i)), 0i);
    let _e81 = textureLoad(global_1, (_e48 + vec2<i32>(2i, 2i)), 0i);
    let _e84 = textureLoad(global_1, (_e48 + vec2<i32>(3i, 2i)), 0i);
    let _e86 = vec4<f32>(_e75.x, _e78.x, _e81.x, _e84.x);
    let _e88 = textureLoad(global_1, (_e48 + vec2<i32>(0i, 3i)), 0i);
    let _e91 = textureLoad(global_1, (_e48 + vec2<i32>(1i, 3i)), 0i);
    let _e94 = textureLoad(global_1, (_e48 + vec2<i32>(2i, 3i)), 0i);
    let _e97 = textureLoad(global_1, (_e48 + vec2<i32>(3i, 3i)), 0i);
    let _e99 = vec4<f32>(_e88.x, _e91.x, _e94.x, _e97.x);
    let _e102 = min(min(_e60, _e73), min(_e86, _e99));
    let _e105 = max(max(_e60, _e73), max(_e86, _e99));
    let _e112 = min(min(_e102.x, _e102.y), min(_e102.z, _e102.w));
    let _e119 = max(max(_e105.x, _e105.y), max(_e105.z, _e105.w));
    let _e121 = (7f / (_e119 - _e112));
    let _e122 = vec4(_e112);
    let _e137 = bitcast<vec4<u32>>(clamp(vec4<i32>((((_e60 - _e122) * _e121) + vec4<f32>(0.5f, 0.5f, 0.5f, 0.5f))), vec4<i32>(0i, 0i, 0i, 0i), vec4<i32>(7i, 7i, 7i, 7i)));
    let _e140 = bitcast<vec4<u32>>(clamp(vec4<i32>((((_e73 - _e122) * _e121) + vec4<f32>(0.5f, 0.5f, 0.5f, 0.5f))), vec4<i32>(0i, 0i, 0i, 0i), vec4<i32>(7i, 7i, 7i, 7i)));
    let _e143 = bitcast<vec4<u32>>(clamp(vec4<i32>((((_e86 - _e122) * _e121) + vec4<f32>(0.5f, 0.5f, 0.5f, 0.5f))), vec4<i32>(0i, 0i, 0i, 0i), vec4<i32>(7i, 7i, 7i, 7i)));
    let _e146 = bitcast<vec4<u32>>(clamp(vec4<i32>((((_e99 - _e122) * _e121) + vec4<f32>(0.5f, 0.5f, 0.5f, 0.5f))), vec4<i32>(0i, 0i, 0i, 0i), vec4<i32>(7i, 7i, 7i, 7i)));
    let _e148 = (7u - _e137.x);
    phi_173_ = _e148;
    if (_e148 != 0u) {
        phi_173_ = (bitcast<u32>(8i) - _e137.x);
    }
    let _e153 = phi_173_;
    let _e157 = (7u - _e137.y);
    phi_182_ = _e157;
    if (_e157 != 0u) {
        phi_182_ = (bitcast<u32>(8i) - _e137.y);
    }
    let _e162 = phi_182_;
    let _e166 = (7u - _e137.z);
    phi_191_ = _e166;
    if (_e166 != 0u) {
        phi_191_ = (bitcast<u32>(8i) - _e137.z);
    }
    let _e171 = phi_191_;
    let _e175 = (7u - _e137.w);
    phi_200_ = _e175;
    if (_e175 != 0u) {
        phi_200_ = (bitcast<u32>(8i) - _e137.w);
    }
    let _e180 = phi_200_;
    let _e185 = (7u - _e140.x);
    phi_210_ = _e185;
    if (_e185 != 0u) {
        phi_210_ = (bitcast<u32>(8i) - _e140.x);
    }
    let _e190 = phi_210_;
    let _e194 = (7u - _e140.y);
    phi_219_ = _e194;
    if (_e194 != 0u) {
        phi_219_ = (bitcast<u32>(8i) - _e140.y);
    }
    let _e199 = phi_219_;
    let _e203 = (7u - _e140.z);
    phi_228_ = _e203;
    if (_e203 != 0u) {
        phi_228_ = (bitcast<u32>(8i) - _e140.z);
    }
    let _e208 = phi_228_;
    let _e212 = (7u - _e140.w);
    phi_237_ = _e212;
    if (_e212 != 0u) {
        phi_237_ = (bitcast<u32>(8i) - _e140.w);
    }
    let _e217 = phi_237_;
    let _e222 = (7u - _e143.x);
    phi_247_ = _e222;
    if (_e222 != 0u) {
        phi_247_ = (bitcast<u32>(8i) - _e143.x);
    }
    let _e227 = phi_247_;
    let _e231 = (7u - _e143.y);
    phi_256_ = _e231;
    if (_e231 != 0u) {
        phi_256_ = (bitcast<u32>(8i) - _e143.y);
    }
    let _e236 = phi_256_;
    let _e240 = (7u - _e143.z);
    phi_265_ = _e240;
    if (_e240 != 0u) {
        phi_265_ = (bitcast<u32>(8i) - _e143.z);
    }
    let _e245 = phi_265_;
    let _e249 = (7u - _e143.w);
    phi_274_ = _e249;
    if (_e249 != 0u) {
        phi_274_ = (bitcast<u32>(8i) - _e143.w);
    }
    let _e254 = phi_274_;
    let _e259 = (7u - _e146.x);
    phi_284_ = _e259;
    if (_e259 != 0u) {
        phi_284_ = (bitcast<u32>(8i) - _e146.x);
    }
    let _e264 = phi_284_;
    let _e268 = (7u - _e146.y);
    phi_293_ = _e268;
    if (_e268 != 0u) {
        phi_293_ = (bitcast<u32>(8i) - _e146.y);
    }
    let _e273 = phi_293_;
    let _e277 = (7u - _e146.z);
    phi_302_ = _e277;
    if (_e277 != 0u) {
        phi_302_ = (bitcast<u32>(8i) - _e146.z);
    }
    let _e282 = phi_302_;
    let _e286 = (7u - _e146.w);
    phi_311_ = _e286;
    if (_e286 != 0u) {
        phi_311_ = (bitcast<u32>(8i) - _e146.w);
    }
    let _e291 = phi_311_;
    let _e296 = (vec4<u32>(select(_e153, 1u, (_e153 == 8u)), select(_e162, 1u, (_e162 == 8u)), select(_e171, 1u, (_e171 == 8u)), select(_e180, 1u, (_e180 == 8u))) << bitcast<vec4<u32>>(vec4<u32>(0u, 3u, 6u, 9u)));
    let _e298 = (vec4<u32>(select(_e190, 1u, (_e190 == 8u)), select(_e199, 1u, (_e199 == 8u)), select(_e208, 1u, (_e208 == 8u)), select(_e217, 1u, (_e217 == 8u))) << bitcast<vec4<u32>>(vec4<u32>(12u, 15u, 18u, 21u)));
    let _e300 = (vec4<u32>(select(_e227, 1u, (_e227 == 8u)), select(_e236, 1u, (_e236 == 8u)), select(_e245, 1u, (_e245 == 8u)), select(_e254, 1u, (_e254 == 8u))) << bitcast<vec4<u32>>(vec4<u32>(0u, 3u, 6u, 9u)));
    let _e302 = (vec4<u32>(select(_e264, 1u, (_e264 == 8u)), select(_e273, 1u, (_e273 == 8u)), select(_e282, 1u, (_e282 == 8u)), select(_e291, 1u, (_e291 == 8u))) << bitcast<vec4<u32>>(vec4<u32>(12u, 15u, 18u, 21u)));
    let _e317 = (((((((_e296.x | _e296.y) | _e296.z) | _e296.w) | _e298.x) | _e298.y) | _e298.z) | _e298.w);
    global_2 = vec2<u32>(((u32((_e119 * 255f)) | (u32((_e112 * 255f)) << bitcast<u32>(8i))) | (_e317 << bitcast<u32>(16i))), ((_e317 >> bitcast<u32>(16i)) | ((((((((_e300.x | _e300.y) | _e300.z) | _e300.w) | _e302.x) | _e302.y) | _e302.z) | _e302.w) << bitcast<u32>(8i))));
    return;
}

@fragment 
fn main(@builtin(position) param: vec4<f32>) -> @location(0) vec2<u32> {
    global = param;
    function();
    let _e3 = global_2;
    return _e3;
}
