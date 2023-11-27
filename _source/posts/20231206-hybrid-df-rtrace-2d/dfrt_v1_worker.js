
import {
    loadF32Lines
} from '../../util.js';


((self)=>
{
    let onInit = [];
    let handleMessagePreLoad = function(event)
    {
        onInit.push(event.data);
    };

    self.addEventListener('message', handleMessagePreLoad);

    WebAssembly.instantiateStreaming(fetch("/res/dfrt_v1.wasm"))
               .then(obj => obj.instance.exports)
               .then(dfrt_v1 => {

        let loadedLinesPath = null;
        let loadedLinesData = null;

        const evaluate = (data)=>
        {
            const result = {"err": null};
            let depBarrier = null;

            const linesPath = data.linesPath;
            const res = data.res;

            if(linesPath != loadedLinesPath)
            {
                depBarrier = loadF32Lines(linesPath).then((linesData)=>{
                    const numLines = linesData.length / 4;
                    if(!dfrt_v1.setNumInputLines(numLines))
                    {
                        result.err = "Unable to set input lines (" + linesPath +")";
                        loadedLinesPath = null;
                        loadedLinesData = null;
                    }
                    else
                    {
                        // Upload lines to the modules memory
                        (new Float32Array(dfrt_v1.memory.buffer,
                                          dfrt_v1.getInputLinesBuffer(),
                                          linesData.length)).set(linesData);
                        dfrt_v1.prepareLines();
                        loadedLinesPath = linesPath;
                        loadedLinesData = linesData;
                    }
                });
            }
            else
            {
                 depBarrier = Promise.resolve();
            }

            depBarrier = depBarrier.then(()=>
            {
                if(result.err != null)
                {
                    return;
                }

                let t0 = performance.now();
                if(!dfrt_v1.render(res))
                {
                    result.err = "Unable to render lines at " + res + "x" + res;
                    return;
                }
                result.time = performance.now() - t0;

                const df = new Uint32Array(dfrt_v1.memory.buffer,
                                           dfrt_v1.getOutputDfTexture(),
                                           res*res);

                const linesBuffer = new Float32Array(dfrt_v1.memory.buffer,
                                                     dfrt_v1.getOutputLinesBuffer(),
                                                     dfrt_v1.getOutputLinesBufferCount()*4);

                result.res = res;
                result.df = df;
                result.linesBuffer = linesBuffer;
                result.lines = loadedLinesData;
            });

            depBarrier.then(()=>
            {
                self.postMessage(result);
            });
        };

        self.addEventListener('message', function(event)
        {
            evaluate(event.data);
        });

        self.removeEventListener('message', handleMessagePreLoad);

        onInit.forEach(evaluate);
        
    });
})(self);
