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
        e2m3_to_f32: wasm_funcs.e2m3_to_f32_,
        e3m2_to_f32: wasm_funcs.e3m2_to_f32_,
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
        f32_to_e2m3: wasm_funcs.f32_to_e2m3_,
        f32_to_e3m2: wasm_funcs.f32_to_e3m2_,
        f32_to_e4m3: wasm_funcs.f32_to_e4m3_,
        f32_to_e5m2: wasm_funcs.f32_to_e5m2_,
        f32_to_f16: wasm_funcs.f32_to_f16_,
        f32_to_fp8: wasm_funcs.f32_to_fp8_,
        f32_to_tf32: wasm_funcs.f32_to_tf32_,
        f32_to_u10: wasm_funcs.f32_to_u10_,
        f32_to_u11: wasm_funcs.f32_to_u11_,
        fp8_to_f16: wasm_funcs.fp8_to_f16_,
        fp8_to_f32: wasm_funcs.fp8_to_f32_,
        tf32_to_f32: wasm_funcs.tf32_to_f32_,
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

    const e2m3 = {
        has_sign: true,
        e_bits: 2,
        m_bits: 3,
        num_bits: 6,
        to_f32: funcs.e2m3_to_f32,
        from_f32: funcs.f32_to_e2m3
    };

    const e3m2 = {
        has_sign: true,
        e_bits: 3,
        m_bits: 2,
        num_bits: 6,
        to_f32: funcs.e3m2_to_f32,
        from_f32: funcs.f32_to_e3m2
    };

    const binary4p2sf = {
        has_sign: true,
        e_bits: 2,
        m_bits: 1,
        num_bits: 4,
        to_f32: funcs.binary4p2sf_to_f32,
        from_f32: funcs.f32_to_binary4p2sf
    };

    const tf32 = {
        has_sign: true,
        e_bits: 8,
        m_bits: 10,
        num_bits: 19,
        to_f32: funcs.tf32_to_f32,
        from_f32: funcs.f32_to_tf32
    };

    const interfaces = {
        "e2m1": e2m1,
        "binary4p2sf": binary4p2sf,
        "binary4p2se": binary4p2se,

        "e2m3": e2m3,
        "e3m2": e3m2,

        "fp8": fp8,
        "e5m2_sat": e5m2_sat,
        "e5m2_nosat": e5m2_nosat,
        "e4m3_sat": e4m3_sat,
        "e4m3_nosat": e4m3_nosat,

        "u10": u10,
        "u11": u11,

        "bfloat16": bfloat16,
        "f16": f16,

        "tf32": tf32
    };

/*
    // Helper for generating tables about the extremes of a format

    const generateBreakdownTable = (key)=>
    {
        const value = interfaces[key];

        const smallest_denorm = 1;
        const largest_denom = (1 << value.m_bits) - 1;
        const smallest_norm = 1 << value.m_bits;
        // formats with no NaN or Inf
        // 0x7fff...ffff
        let largest_norm = (1 << (value.e_bits + value.m_bits)) - 1;
        if (!isFinite(value.to_f32(largest_norm)))
        {
            // 0x7fff...fffe
            largest_norm -= 1;
            if (!isFinite(value.to_f32(largest_norm)))
            {
                // Standard
                largest_norm = (1 << (value.e_bits + value.m_bits)) - 1;
                largest_norm -= (1 << value.m_bits);
            }
        }

        const smallest_gt_one = value.from_f32(1.0) + 1;
        const largest_lt_one = value.from_f32(1.0) - 1;
        const closest_pi = value.from_f32(Math.PI);

        // Brute force, but probably not worth the effort in calculating this analytically.
        let largest_seq_integer_f32 = 1.0;
        while (value.to_f32(value.from_f32(largest_seq_integer_f32)) == largest_seq_integer_f32)
        {
            largest_seq_integer_f32 += 1.0;
        }
        largest_seq_integer_f32 -= 1.0;
        const largest_seq_integer = value.from_f32(largest_seq_integer_f32);

        const num_nibbles = Math.floor((value.num_bits + 3) / 4);
        const makeentry = (name, raw_val) => {
            const hex_value = raw_val.toString(16).padStart(num_nibbles, "0");
            const f32_value = value.to_f32(raw_val);
            return `| **${name}** | 0x${hex_value} | ${f32_value} |`
        };

        const make_delta_entry = (name, ref_val, raw_val) => {
            const hex_value = raw_val.toString(16).padStart(num_nibbles, "0");
            const f32_value = value.to_f32(raw_val);
            const delta = Math.abs((f32_value - ref_val)).toExponential();
            const [delta_up, delta_lo] = delta.split("e");

            let _10x_superscript = "";
            for (let v of delta_lo.toString()) {
                switch(v) {
                case "-": _10x_superscript += "&#8315;"; break;
                case "0": _10x_superscript += "&#8304;"; break;
                case "1": _10x_superscript += "&#185;"; break;
                case "2": _10x_superscript += "&#178;"; break;
                case "3": _10x_superscript += "&#179;"; break;
                case "4": _10x_superscript += "&#8308;"; break;
                case "5": _10x_superscript += "&#8309;"; break;
                case "6": _10x_superscript += "&#8310;"; break;
                case "7": _10x_superscript += "&#8311;"; break;
                case "8": _10x_superscript += "&#8312;"; break;
                case "9": _10x_superscript += "&#8313;"; break;
                default:
                    throw "Oh dear";
                }
            }

            const sci_v = `${Math.round(delta_up*1000)/1000}x10${_10x_superscript}`;
            return `| **${name}** | 0x${hex_value} | ${f32_value} (&Delta; &asymp; ${sci_v}) |`
        };
        

        let result =  `\n\n<br>\n\n| | Hex | Value |\n` +
                      "| -- | -- | -- |\n" +
                     `${makeentry("Smallest value (Denormal)", smallest_denorm)}\n` +
                     `${makeentry("Largest value (Denormal)", largest_denom)}\n` +
                     `${makeentry("Smallest value (Normal)", smallest_norm)}\n` +
                     `${makeentry("Largest value (Normal)", largest_norm)}\n` +
                     `${makeentry("Smallest value > 1", smallest_gt_one)}\n` +
                     `${makeentry("Largest value < 1", largest_lt_one)}\n` +
                     `${make_delta_entry("Closest value to &#x03C0;", Math.PI, closest_pi)}\n` +
                     `${makeentry("Largest sequential integer", largest_seq_integer)}\n`
                     ;
        result += "\n<br>\n\n";
        console.log(result);
    };
    generateBreakdownTable("bfloat16");
*/

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
