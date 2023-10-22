
// Worker thread, evaluates the ULP error for a given exponent + magic number.

((self)=>
{

    WebAssembly.instantiateStreaming(fetch("res/calc_ulp_error.wasm"))
               .then(obj => obj.instance.exports)
               .then(calc_ulp_error => {

        self.addEventListener('message', function(event)
        {
            const { invExponent, magic, gid, applyMagicAsFloat } = event.data;
            const weight = calc_ulp_error.calc_magic_error(invExponent, magic, applyMagicAsFloat);
            const maxerr = calc_ulp_error.get_max_ulp_err();
            const avgerr = calc_ulp_error.get_avg_ulp_err();
            self.postMessage({
                taskGid: gid,
                magic: magic,
                weight: weight,
                maxerr: maxerr,
                avgerr: avgerr
            });
        });

        // Mark this worker as available!
        self.postMessage(null);
    });
})(self);