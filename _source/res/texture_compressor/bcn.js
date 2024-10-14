
const bcnCompressor = (compression, level, pixeldata, width, height, blocksize) =>
{

    const numWorkersToInitialize = Math.max(2, navigator.hardwareConcurrency || 2);
    const maxBlocksPerWorker = 10;
    let done = false;
    let errorMessage = "";
    let hasError = false;

    const onFinishCallbacks = [];
    const progressCallbacks = [];

    if (((width & 3) != 0) || ((height & 3) != 0))
    {
        hasError = true;
        errorMessage = "Width and/or height is not aligned to 4";
    }

    if(!hasError)
    {
        if(pixeldata.length < (height*width*4))
        {
            hasError = true;
            errorMessage = "Input pixel data is less than (height*width*4)";
        }
    }

    const processNextOrFinish = (worker)=>
    {
        if(done || hasError)
        {
            delete worker;
            return;
        }



        if(done || hasError)
        {
            delete worker;
        }
    };

    if(!hasError)
    {
        const setupWorker = (worker) =>
        {
            let waitForReady = null;
            waitForReady = ()=>
            {
                worker.removeEventListener("message", waitForReady);
                worker.addEventListener('message', function(event)
                {
                    const { taskGid, compressedBlocks, error } = event.data;
                    if(error)
                    {
                        hasError = true;
                        errorMessage = error;
                    }
                    processNextOrFinish(worker);
                });
                processNextOrFinish(worker);
            };
            worker.addEventListener('message', waitForReady);
        };
        
        for(let i=0; i<numWorkersToInitialize; ++i)
        {
            setupWorker(new Worker("bcn_worker.js"));
        }
    }


    return
    {
        isDone: ()=>{ return (done || hasError); },
        stop: ()=>{
            hasError = true;
            errorMessage = "User halted";
        }
        hasError: ()=>{ return hasError; },
        getError: ()=>{ return errorMessage; },
        getData: ()=>{ return data; }
    };


};

export const BC1_MIN = 0;
export const BC1_MAX = 18;
export const bc1Compressor = (level, pixeldata, width, height)=>{ bcnCompressor("bc1", level, pixeldata, width, height, 8); };

export const BC3_MIN = 0;
export const BC3_MAX = 18;
export const bc3Compressor = (level, pixeldata, width, height)=>{ bcnCompressor("bc3", level, pixeldata, width, height, 16); };

export const BC4_MIN = 0;
export const BC4_MAX = 1;
export const bc4Compressor = (level, pixeldata, width, height)=>{ bcnCompressor("bc4", level, pixeldata, width, height, 8); };

export const BC5_MIN = 0;
export const BC5_MAX = 1;
export const bc5Compressor = (level, pixeldata, width, height)=>{ bcnCompressor("bc5", level, pixeldata, width, height, 16); };

export const BC7_MIN = 0;
export const BC7_MAX = 5;
export const bc7Compressor = (level, pixeldata, width, height)=>{ bcnCompressor("bc7", level, pixeldata, width, height, 16); };
