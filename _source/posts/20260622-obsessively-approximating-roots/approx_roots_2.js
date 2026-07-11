import {
    bitcast
} from '../../util.js';


const find_magic_one_pass = WebAssembly.instantiateStreaming(fetch("res/find_magic_one_pass.wasm")).then(
    w  => w.instance.exports
);

export const findMagicOnePassInterface = find_magic_one_pass.then(funcs=>{
    return {
        calc_magic: (inv_root) => {
            const magic = funcs.calc_root_magic(inv_root);
            const delta_min_input = funcs.get_delta_min_input();
            const delta_max_input = funcs.get_delta_max_input();
            const delta_min = funcs.get_delta_min();
            const delta_max = funcs.get_delta_max();
            return {
                magic: bitcast.i32tou32(magic),
                delta_min_input_u: bitcast.i32tou32(delta_min_input),
                delta_min_input_f: bitcast.u32tof32(delta_min_input),
                delta_max_input_u: bitcast.i32tou32(delta_max_input),
                delta_max_input_f: bitcast.u32tof32(delta_max_input),
                delta_min: bitcast.i32tou32(delta_min),
                delta_max: bitcast.i32tou32(delta_max)
            };
        }
    };
});

