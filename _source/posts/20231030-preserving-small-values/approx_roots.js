import {
    drawNormalised,
    drawLinesArray,
    drawGridLines
} from './graphing.js';

import {
    bitcast
} from '../../util.js';

export const ApproxRoots = (()=>{

    const asuint = bitcast.f32tou32;
    const asfloat = bitcast.u32tof32;
    const f32 = bitcast.f32;
    const u32 = bitcast.u32;
    
    // Each time the magic number we're targetting
    // changes, generate a new global id.
    //
    // We do this so we can discard calculated ULPs
    // which were being processed when the target exponent
    // has been switched and the previous exponent wasn't
    // finished.
    let gid = -1;

    const numWorkersToInitialize = Math.max(2, navigator.hardwareConcurrency || 2);
    const idleWorkerThreads = [];
    const onFinishCallbacks = [];
    const progressCallbacks = [];
    const magicUpdateCallbacks = [];
    
    const valuesToTest = [];
    let currentPass = null;
    let remainingPasses = [];
    
    const allProcessedValues = [];
    let processedTasks = 0;
    let passTasksEnd = 0;
    let totalTasks = 0;
    let passId = 0;
    let numPasses = 0;

    let flippedExponent = false;
    let exponent = 0;
    let invExponent = 0;
    let applyMagicAsFloat = true;
    let bestPick = {weight: Infinity};
    let calcPercentage = ()=>processedTasks/totalTasks;

    const launchIdleWorkers = ()=>
    {
        for(let i=0; i<idleWorkerThreads.length; ++i)
        {
            if(valuesToTest.length > 0)
            {
                idleWorkerThreads.pop().postMessage({
                    gid: gid,
                    invExponent: invExponent,
                    applyMagicAsFloat: applyMagicAsFloat,
                    magic: valuesToTest.pop()
                });
            }
            else
            {
                break;
            }
        }
    };

    // Construct passes to solve a subset of bits at a time.
    // Trying to manually solve all 23 bits in one go, while
    // possible, would take an incredibly tedious amount of time.
    //
    // Each pass will pick up where the last pass left off,
    // solving (nsearchbits-1) each time, except for the last
    // pass, which will solve nsearchbits.
    // A bit confusing, but hopefully the example below, will
    // make this a bit clearer:
    //
    //
    //  If the first pass searches 8 bits, it'll test out
    //      00000000000000000000000 => 11111111000000000000000
    //
    //  Lets say the value with the minimum error was:
    //      00111000000000000000000
    //
    //  We will now limit our search +/- 00000001000000000000000
    //      00110111000000000000000 => 00111001000000000000000
    //
    //  Which leaves us with 2^16 values, and 16 bits to solve,
    //  abstractly telling us we have solved 7 bits.
    //
    //  --
    //
    //  If the second pass solves 6 bits, it will search
    //      00110111000000000000000 + [0000000000000000 => 1111110000000000]
    //
    //  Lets say the value with the minimum error was:
    //      00110111101010000000000
    //
    //  We will now limit our search +/- 0000010000000000
    //      00110111101000000000000 => 00110111101100000000000
    //
    //  Which leaves us with 2^11 values, and 11 bits to solve,
    //  telling us we have solved a further 6 bits.
    //
    //  --
    //
    //  This carries on until we've reached some point where
    //  we we're comparing the least significant bits, at which
    //  point our magic number as been solved!
    const generatePasses = ()=>{

        let bitsLeft = 23;
        let cumSumTaskCount = 0;
        const passes = [];

        const addPass = (searchBits)=>
        {
            if(bitsLeft <= 0)
            {
                return false;
            }

            let newBitsLeft = 0;
            if(bitsLeft <= searchBits)
            {
                searchBits = bitsLeft;
            }
            else
            {
                newBitsLeft = bitsLeft - (searchBits - 1);
            }

            const numSearchValues = 1 << searchBits;
            const shift = (bitsLeft - searchBits);
            const incrementAmount = 1 << shift;

            cumSumTaskCount += numSearchValues;

            passes.push({
                numSearchValues: numSearchValues,
                shift: shift,
                incrementAmount: incrementAmount,
                cumSumTaskCount: cumSumTaskCount
            });

            bitsLeft = newBitsLeft;
            return bitsLeft != 0;
        };

        // 4 bits at a time is typically fast and accurate, with no
        // real risk of overshooting.
        while(addPass(4));
        return passes;
    };

    const onFinish = ()=>
    {
        for(let callback of onFinishCallbacks)
        {
            callback();
        }
    };

    const nextPass = ()=>
    {
        if(remainingPasses.length != 0)
        {
            // First pass
            let magicStart = bestPick.magic;

            // Pick up from the last pass
            if(currentPass != null)
            {
                magicStart -= currentPass.incrementAmount;
                passId += 1;
            }
            else
            {
                passId = 0;
            }
            const pass = remainingPasses.shift();
            const shift = pass.shift;
            for(let i=0; i<pass.numSearchValues; ++i)
            {
                valuesToTest.push(magicStart + (i << shift));
            }
            passTasksEnd = pass.cumSumTaskCount;
            currentPass = pass;
            launchIdleWorkers();
        }
        else
        {
            onFinish();
        }
    };


    const newGlobalId = (()=>
    {
        let idx = 0;
        return ()=>{gid = idx++};
    })();


    const setupWorker = (worker) =>
    {
        let waitForReady = null;
        waitForReady = ()=>
        {
            console.log("worker connected");
            worker.removeEventListener("message", waitForReady);
            
            function processNextOrMakeAvailable()
            {
                if(valuesToTest.length != 0)
                {
                    worker.postMessage({
                        gid: gid,
                        invExponent: invExponent,
                        applyMagicAsFloat: applyMagicAsFloat,
                        magic: valuesToTest.pop()
                    });
                }
                else
                {
                    idleWorkerThreads.push(worker);
                }
            };

            worker.addEventListener('message', function(event)
            {
                const { taskGid, magic, weight, maxerr, avgerr } = event.data;

                // Discard old results
                if(taskGid == gid)
                {
                    ++processedTasks;
                    if(weight < bestPick.weight)
                    {
                        bestPick = {
                            magic: magic,
                            weight: weight,
                            maxerr: maxerr,
                            avgerr: avgerr
                        };

                        for(let f of magicUpdateCallbacks) { f(bestPick); }
                    }

                    allProcessedValues.push({
                        offset: magic,
                        maxerr: maxerr,
                        passId: passId
                    });

                    const progress = calcPercentage();
                    for(let f of progressCallbacks) { f(progress); }
                    // console.log(`0x${bestPick.magic.toString(16)} | ${bestPick.maxerr} | ${bestPick.avgerr} | ${100.0 * calcPercentage()}%`);
                    // console.log(`0x${magic.toString(16)} | ${maxerr} | ${bestPick.avgerr} | ${100.0 * calcPercentage()}%`);
 
                    if(processedTasks >= passTasksEnd)
                    {
                        nextPass();
                    }
                }

                processNextOrMakeAvailable();
            });
            processNextOrMakeAvailable();
        };
        worker.addEventListener('message', waitForReady);
    };

    for(let i=0; i<numWorkersToInitialize; ++i)
    {
        const worker = new Worker("approx_roots_worker.js");
        setupWorker(worker);
    }

    const newJob = (exponent_, applyMagicAsFloat_=true)=>
    {
        // Told to solve 1/0.x, instead solve for 0.x and
        // simply use an inversion function.
        flippedExponent = Math.abs(exponent_) < 1.0;
        if(flippedExponent)
        {
            exponent_ = 1.0 / exponent_;
        }

        newGlobalId();
        valuesToTest.length = 0;
        processedTasks = 0;
        passTasksEnd = 0;
        totalTasks = 0;
        allProcessedValues.length = 0;
        exponent = exponent_;
        invExponent = 1.0 / exponent;
        applyMagicAsFloat = applyMagicAsFloat_;

        // TODO: Don't currently support negative roots, e.g -0.5, but fairly
        // sure you need to do a ceil instead of a floor.
        let initialMagicNumber = exponent > 0
                                ? (Math.floor(127 - 127 * invExponent) << 23)
                                : (Math.ceil(127 - 127 * invExponent) << 23)
                                ;
        
        bestPick = {
            magic: initialMagicNumber,
            weight: Infinity
        };
        currentPass = null;
        remainingPasses = generatePasses();
        numPasses = remainingPasses.length;
        totalTasks = remainingPasses[remainingPasses.length-1].cumSumTaskCount;

        nextPass();
    };

    const makeRefinementGraphData = (zoomLevel=-1)=>{

        allProcessedValues.sort((x, y)=>(x.offset-y.offset));
        let minErr = Infinity;
        let maxErr = -Infinity;
        let minOffset = Infinity;
        let maxOffset = -Infinity;
        for(let v of allProcessedValues)
        {
            if(v.passId != zoomLevel) { continue; }
            if(v.maxerr < minErr) { minErr = v.maxerr; }
            if(v.maxerr > maxErr) { maxErr = v.maxerr; }
            if(v.offset < minOffset) { minOffset = v.offset; }
            if(v.offset > maxOffset) { maxOffset = v.offset; }
        }
        const offsetNorm = 1.0 / (maxOffset - minOffset + 1);
        const errorNorm = 1.0 / (maxErr - minErr + 1);
        const chartPoints = [];
        for(let v of allProcessedValues)
        {
            if(v.passId != zoomLevel) { continue; }

            const depth = 1.0 / ((v.passId - zoomLevel) + 1.0);
            const depthLinear = (v.passId / numPasses);
            const col = "#"
                        + (Math.floor(depthLinear*255 + 0.5).toString(16).padStart(2, "0"))
                        + "d5ff"
                        ;

            chartPoints.push([
                (v.offset - minOffset + 0.5) * offsetNorm,
                (v.maxerr - minErr + 0.5) * errorNorm,
                depth,
                col
            ]);
        }

        return {
            points: chartPoints,
            minOffset: minOffset,
            maxOffset: maxOffset,
            minErr: minErr,
            maxErr: maxErr
        };
    };


    const makeRefinementGraph = (canvas, zoomLevel=-1)=>
    {
        const data = makeRefinementGraphData(zoomLevel);
        const ctx = canvas.getContext("2d");
        const width = canvas.width;
        const height = canvas.height;

        // flip y
        const psize = 1.0 / Math.sqrt(width * height);
        ctx.setTransform(width, 0, 0, -height, 0, height);
        ctx.clearRect(0, 0, 1, 1);
        ctx.rect(0, 0, 1, 1);
        ctx.fillStyle = "#400778";
        ctx.lineWidth = psize;
        ctx.fill();

        ctx.strokeStyle = "#00d5ff";
        ctx.fillStyle = "#ffd5ff";
        const points = data.points;

        const pntoffset = 0.1;
        const pntscale = 0.8;

        drawLinesArray(ctx, points, (x)=>
        {
            return [
                x[0] * pntscale + pntoffset,
                x[1] * pntscale + pntoffset
            ];
        });

        points.sort((x, y)=>(x[2] - y[2]));
        for(let p of points)
        {
            const depth = p[2];
            ctx.fillStyle = p[3];
            ctx.beginPath();
            ctx.arc(p[0] * pntscale + pntoffset,
                    p[1] * pntscale + pntoffset,
                    psize * depth * 3,
                    0,
                    2 * Math.PI);
            ctx.fill();
        }

        return data;
    };


    const makeRefinementGraphStages = (doc, rootNode)=>
    {
        rootNode.innerHTML = "";
        const allDrawables = [];
        for(let passId=0; passId < numPasses; ++passId)
        {
            const container = doc.createElement("div");
            const canvas = doc.createElement("canvas");
            const text = doc.createElement("div");
            container.appendChild(canvas);
            container.appendChild(text);
            text.innerHTML = `Pass ${passId+1}`;
            rootNode.appendChild(container);
            allDrawables.push([canvas, text]);
        }

        let zoomLevel = 0;
        for(let canvasText of allDrawables)
        {
            const canvas = canvasText[0];
            const text = canvasText[1];
            canvas.style.width = "150px";
            canvas.style.height ="150px";
            canvas.width = canvas.clientWidth;
            canvas.height = canvas.clientHeight;
            let data = makeRefinementGraph(canvas, zoomLevel++);
            text.innerHTML += `<br>0x${data.minOffset.toString(16)} - 0x${data.maxOffset.toString(16)}`;
        }
    };


    const generateSourceCode = ()=>
    {

        const floatify = (x)=>{
            if(Number.isInteger(x))
            {
                return x + ".0";
            }
            return x;
        };

        const approxBody = applyMagicAsFloat
                             ?
 `    // 3 x full rate
    float y = float(asuint(x));
    y = y * ${floatify(invExponent)}f
          + ${floatify(bestPick.magic)}f;
    return asfloat(uint(y));`
                             :
`    // 4 x full rate
    float y = float(asuint(x));
    y = y * ${floatify(invExponent)}f;
    uint z = uint(y);
    return asfloat(z + 0x${bestPick.magic.toString(16)}u);`;

        const invApproxBody = applyMagicAsFloat
                             ?
`    // 3 x full rate
    float y = float(asuint(x));
    y = y * ${floatify(exponent)}f
          - ${floatify(bestPick.magic * exponent)}f;
    return asfloat(uint(y));`
                            :
`    // 4 x full rate
    uint z = asuint(x) - 0x${bestPick.magic.toString(16)}u;
    float y = float(z);
    y = y * ${floatify(exponent)}f;
    return asfloat(uint(y));`;

        return [`
float encode(float x)
{
${(flippedExponent ? invApproxBody : approxBody)}
}
`, `
float decode(float x)
{
${(flippedExponent ? approxBody : invApproxBody)}
}
`];
    };

    const makeComparisonGraph = (canvas, gamutBits=8)=>
    {
        canvas.width = canvas.clientWidth;
        canvas.height = canvas.clientHeight;

        const ctx = canvas.getContext("2d");
        const width = canvas.width;
        const height = canvas.height;

        const quantAmount = (1 << gamutBits) - 1;
        const invQuantAmount = 1 / quantAmount;
        const quant = (x)=>{
            return Math.floor(quantAmount * x + 0.5) * invQuantAmount
        };


        // flip y
        ctx.setTransform(width, 0, 0, -height, 0, height);
        ctx.clearRect(0, 0, 1, 1);
        ctx.rect(0, 0, 1, 1);
        ctx.fillStyle = "#400778";
        ctx.fill();

        ctx.lineWidth = 1.0 / Math.sqrt(width * height);
        ctx.strokeStyle = "#aaaaaa";
        drawGridLines(ctx, false);


        ctx.lineWidth *= 2;
        ctx.strokeStyle = "#00d5ff";
        let approx = null;
        let invapprox = null;
        if(applyMagicAsFloat)
        {
            approx = (x)=>
            {
                let y = f32(asuint(x));
                y = y * invExponent + bestPick.magic;
                return asfloat(u32(y));
            };
            invapprox = (x)=>
            {
                let y = f32(asuint(x));
                y = y * exponent - (bestPick.magic * exponent);
                return asfloat(u32(y));
            };
        }
        else
        {
            approx = (x)=>
            {
                let y = f32(asuint(x));
                y = y * invExponent;
                let z = u32(y);
                return asfloat(z + bestPick.magic);
            };
            invapprox = (x)=>
            {
                let z = asuint(x) - bestPick.magic;
                let y = f32(z) * exponent;
                return asfloat(u32(y));
            };
        }

        if(flippedExponent)
        {
            const tmp = approx;
            approx = invapprox;
            invapprox = tmp;
        }

        drawNormalised(canvas, ctx, (x)=>
        {
            return invapprox(quant(approx(x)));
        });
    }

    return {
        newJob: newJob,
        makeRefinementGraphStages: makeRefinementGraphStages,
        generateSourceCode: generateSourceCode,
        makeComparisonGraph: makeComparisonGraph,
        onFinish: (f)=>{onFinishCallbacks.push(f);},
        onProgress: (f)=>{progressCallbacks.push(f);},
        onMagicUpdate: (f)=>{magicUpdateCallbacks.push(f);},
    };

})();
