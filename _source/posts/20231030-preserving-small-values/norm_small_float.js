import {
    bitcast
} from '../../util.js';

import {
    drawNormalised,
    drawGridLines
} from './graphing.js';


export const NormSmallFloat = (()=>{

    const asuint = bitcast.f32tou32;
    const asfloat = bitcast.u32tof32;
    const f32 = bitcast.f32;
    const u32 = bitcast.u32;

    const calcCoefs = (exBits)=>
    {
        let mask;
        if(Number.isInteger(exBits))
        {
            mask = (1 << (23 + exBits)) - 1;
        }
        else
        {
            let a = (1 << (23 + Math.floor(exBits))) - 1;
            let b = (1 << (23 + Math.ceil(exBits))) - 1;
            let x = exBits - Math.floor(exBits);
            mask = Math.floor(a + (b-a) * x);
        }

        // encode:
        //  uint y = asuint(encodeM * x);
        //  float z = float(y) * encodeS;
        const encodeM = asfloat(mask);
        const encodeS = 1.0 / mask;

        // decode
        // uint y = uint(x * decodeM);
        // float z = asfloat(y) * decodeS;
        const decodeM = mask;
        const decodeS = 1.0 / encodeM;

        return [encodeM, encodeS,
                decodeM, decodeS];
    };
    

    const drawGraph = (canvas, coefs, signed, gamutBits) =>
    {
        const ctx = canvas.getContext("2d");
        canvas.width = canvas.clientWidth;
        canvas.height = canvas.clientHeight;
        const width = canvas.width;
        const height = canvas.height;


        // flip y
        ctx.setTransform(width, 0, 0, -height, 0, height);
        ctx.clearRect(0, 0, 1, 1);
        ctx.rect(0, 0, 1, 1);
        ctx.fillStyle = "#400778";
        ctx.fill();

        ctx.lineWidth = 1.0 / Math.sqrt(width * height);
        ctx.strokeStyle = "#aaaaaa";
        drawGridLines(ctx, signed);

        const encode = (x)=>
        {
            const y = asuint(x * coefs[0]);
            const z = f32(y * coefs[1]);
            return f32(y * coefs[1]);
        };

        const encodeSigned = (x)=>
        {
            // Vis only
            x = x * 2 - 1;  // move to -1=>1

            const y = Math.abs(x) * coefs[0];
            const z = coefs[1] * 0.5 * Math.sign(x);
            return asuint(y) * z + 0.5;
        };

        const decode = (x)=>
        {
            const y = u32(x * coefs[2]);
            return asfloat(y) * coefs[3];
        };

        const decodeSigned = (x)=>
        {
            const y = x * 2 * coefs[2] - coefs[2];
            const z = asfloat(u32(Math.abs(y))) * coefs[3];
            const w = z * Math.sign(y);

            // Vis only
            // Ooutput in [0, 1]
            return w * 0.5 + 0.5;
        };

        const quantAmount = (1 << gamutBits) - 1;
        const invQuantAmount = 1 / quantAmount;
        
        const quant = (x)=>{
            return Math.floor(quantAmount * x + 0.5) * invQuantAmount;
        };

        ctx.lineWidth *= 2;
        ctx.strokeStyle = "#ffd5ff";
        ctx.strokeStyle = "#00d5ff";

        drawNormalised(canvas, ctx, signed ? ((x)=>decodeSigned(quant(encodeSigned(x))))
                                           : ((x)=>decode(quant(encode(x)))));
    };


    const generateSourceCode = (coefs, signed)=>
    {
        const floatHexLit = (x)=>{
            return `asfloat(0x${asuint(x).toString(16)}u)`;
        };

        let encodeFunc = null;
        let decodeFunc = null;
        if(signed)
        {
            encodeFunc = `float encode(float x)
{
     // 5 x full rate
    float y = abs(x) * ${floatHexLit(coefs[0])};
    uint z = 0x${asuint(coefs[1] * 0.5).toString(16)}u
            | (asuint(x) & 0x80000000u);
    return float(asuint(y)) * asfloat(z) + 0.5;
}`;
            decodeFunc = `float decode(float x)
{
     // 5 x full rate
    float y = x * ${floatHexLit(2 * coefs[2])}
                - ${floatHexLit(coefs[2])};
    float z = asfloat(uint(abs(y)))
            * ${floatHexLit(coefs[3])};
    return asfloat(asuint(z)
                | (asuint(y) & 0x80000000u));
}`;
        }
        else
        {
            encodeFunc = `float encode(float x)
{
     // 3 x full rate
    float y = x * ${floatHexLit(coefs[0])};
    float z = float(asuint(y));
    return z * ${floatHexLit(coefs[1])};
}`;
            decodeFunc = `float decode(float x)
{
     // 3 x full rate
    float y = x * ${floatHexLit(coefs[2])};
    float z = asfloat(uint(y));
    return z * ${floatHexLit(coefs[3])};
}`;
        }
        return [encodeFunc, decodeFunc];
    };

    return {
        calcCoefs: calcCoefs,
        drawGraph: drawGraph,
        generateSourceCode: generateSourceCode
    };

})();
