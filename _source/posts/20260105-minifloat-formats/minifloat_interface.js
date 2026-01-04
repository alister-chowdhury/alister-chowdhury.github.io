import {
    bitcast
} from '../../util.js';


const minifloat = WebAssembly.instantiateStreaming(fetch("/res/minifloat.wasm")).then(
    w  => {
    const wasm_funcs = w.instance.exports
    return {
        bfloat16_to_f32: wasm_funcs.bfloat16_to_f32_,
        binary4p2se_to_f32: wasm_funcs.binary4p2se_to_f32_,
        binary4p2sf_to_f32: wasm_funcs.binary4p2sf_to_f32_,
        e2m1_to_f32: wasm_funcs.e2m1_to_f32_,
        e4m3_to_f32: wasm_funcs.e4m3_to_f32_,
        e5m2_to_f16: wasm_funcs.e5m2_to_f16_,
        e5m2_to_f32: wasm_funcs.e5m2_to_f32_,
        f16_to_e5m2: wasm_funcs.f16_to_e5m2_,
        f16_to_f32: wasm_funcs.f16_to_f32_,
        f16_to_fp8: wasm_funcs.f16_to_fp8_,
        f16_to_u10: wasm_funcs.f16_to_u10_,
        f16_to_u11: wasm_funcs.f16_to_u11_,
        f32_to_bfloat16: wasm_funcs.f32_to_bfloat16_,
        f32_to_binary4p2se: wasm_funcs.f32_to_binary4p2se_,
        f32_to_binary4p2sf: wasm_funcs.f32_to_binary4p2sf_,
        f32_to_e2m1: wasm_funcs.f32_to_e2m1_,
        f32_to_e4m3: wasm_funcs.f32_to_e4m3_,
        f32_to_e5m2: wasm_funcs.f32_to_e5m2_,
        f32_to_f16: wasm_funcs.f32_to_f16_,
        f32_to_fp8: wasm_funcs.f32_to_fp8_,
        f32_to_u10: wasm_funcs.f32_to_u10_,
        f32_to_u11: wasm_funcs.f32_to_u11_,
        fp8_to_f16: wasm_funcs.fp8_to_f16_,
        fp8_to_f32: wasm_funcs.fp8_to_f32_,
        u10_to_f16: wasm_funcs.u10_to_f16_,
        u10_to_f32: wasm_funcs.u10_to_f32_,
        u11_to_f16: wasm_funcs.u11_to_f16_,
        u11_to_f32: wasm_funcs.u11_to_f32_
    };
});


export const minifloatInterface = minifloat.then( funcs => {

    const bfloat16 = {
        has_sign: true,
        e_bits: 8,
        m_bits: 7,
        num_bits: 16,
        to_f32: funcs.bfloat16_to_f32,
        from_f32: funcs.f32_to_bfloat16
    };

    const f16 = {
        has_sign: true,
        e_bits: 5,
        m_bits: 10,
        num_bits: 16,
        to_f32: funcs.f16_to_f32,
        from_f32: funcs.f32_to_f16
    };

    const u10 = {
        has_sign: false,
        e_bits: 5,
        m_bits: 5,
        num_bits: 10,
        to_f32: funcs.u10_to_f32,
        from_f32: funcs.f32_to_u10
    };

    const u11 = {
        has_sign: false,
        e_bits: 5,
        m_bits: 6,
        num_bits: 11,
        to_f32: funcs.u11_to_f32,
        from_f32: funcs.f32_to_u11
    };

    const fp8 = {
        has_sign: true,
        e_bits: 5,
        m_bits: 2,
        num_bits: 8,
        to_f32: funcs.fp8_to_f32,
        from_f32: funcs.f32_to_fp8
    };

    const e5m2_sat = {
        has_sign: true,
        e_bits: 5,
        m_bits: 2,
        num_bits: 8,
        to_f32: funcs.e5m2_to_f32,
        from_f32: (x) => funcs.f32_to_e5m2(x, true)
    };

    const e5m2_nosat = {
        has_sign: true,
        e_bits: 5,
        m_bits: 2,
        num_bits: 8,
        to_f32: funcs.e5m2_to_f32,
        from_f32: (x)  => funcs.f32_to_e5m2(x, false)
    };

    const e4m3_sat = {
        has_sign: true,
        e_bits: 4,
        m_bits: 3,
        num_bits: 8,
        to_f32: funcs.e4m3_to_f32,
        from_f32: (x) => funcs.f32_to_e4m3(x, true)
    };

    const e4m3_nosat = {
        has_sign: true,
        e_bits: 4,
        m_bits: 3,
        num_bits: 8,
        to_f32: funcs.e4m3_to_f32,
        from_f32: (x) => funcs.f32_to_e4m3(x, false)
    };

    const e2m1 = {
        has_sign: true,
        e_bits: 2,
        m_bits: 1,
        num_bits: 4,
        to_f32: funcs.e2m1_to_f32,
        from_f32: funcs.f32_to_e2m1
    };

    const binary4p2se = {
        has_sign: true,
        e_bits: 2,
        m_bits: 1,
        num_bits: 4,
        to_f32: funcs.binary4p2se_to_f32,
        from_f32: funcs.f32_to_binary4p2se
    };

    const binary4p2sf = {
        has_sign: true,
        e_bits: 2,
        m_bits: 1,
        num_bits: 4,
        to_f32: funcs.binary4p2sf_to_f32,
        from_f32: funcs.f32_to_binary4p2sf
    };

    const interfaces = {
        "e2m1": e2m1,
        "binary4p2sf": binary4p2sf,
        "binary4p2se": binary4p2se,

        "fp8": fp8,
        "e5m2_sat": e5m2_sat,
        "e5m2_nosat": e5m2_nosat,
        "e4m3_sat": e4m3_sat,
        "e4m3_nosat": e4m3_nosat,

        "u10": u10,
        "u11": u11,

        "bfloat16": bfloat16,
        "f16": f16
    };

    // Breaks down a minifloat into it's components (s, exp, mant).
    const breakdown = (v, interface_) => {
        const val = interface_.to_f32(v);
        const s = v >> (interface_.e_bits + interface_.m_bits);
        const s_val = (s == 0 ? 1.0 : -1.0);
        const e_mask = (1 << interface_.e_bits) - 1;
        const e = (v >> interface_.m_bits) & e_mask;
        const subnormal = e == 0;
        const e_val = (e + subnormal) - Math.floor(e_mask / 2);
        const m_mask = (1 << interface_.m_bits) - 1;
        const m = v & m_mask;
        const m_val = subnormal ? Math.abs(val) : bitcast.u32tof32(
            (bitcast.f32tou32(val) & 0x7fffff) | 0x3f800000
        );
        return {
            "val": val,
            "s": s,
            "s_val": s_val,
            "e": e,
            "e_val": e_val,
            "m": m,
            "m_val": m_val,
            "subnormal": subnormal
        }
    };

    return {
        "interfaces": interfaces,
        "breakdown": breakdown,
        "remove_eng_notation": (x) => x.toLocaleString( "fullwide",
                                                        {
                                                            useGrouping: false,
                                                            maximumSignificantDigits:21
                                                        })
    }
});
