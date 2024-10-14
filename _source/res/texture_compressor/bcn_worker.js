// Worker thread, evaluate bc1, bc3, bc4, bc5 or bc7 blocks

((self)=>
{
    WebAssembly.instantiateStreaming(fetch("bcn.wasm"))
               .then(obj => obj.instance.exports)
               .then(bcn => {
        
        bcn.init();

        // 4x4 rgba8
        const inputPixelsBCN = new Uint8Array(bcn.memory.buffer,
                                              bcn.input_pixel_addr(),
                                              64);

        self.addEventListener('message', function(event)
        {
            const { gid, inputBlocks, compression, level } = event.data;

            const compressedBlocks = [];
            const compressedBlockSize = ((compression === "bc1")
                                        || (compression == "bc4")) 
                                      ? 8
                                      : 16
                                    ;
            const outputPixelsBCN = new Uint8Array(bcn.memory.buffer,
                                                   bcn.output_pixel_addr(),
                                                   compressedBlockSize);

            let compressFunc = null;
            let error = null;
            switch(compression)
            {
                case "bc1": compressFunc = bcn.bc1; /* level = [0, 18] */ break;
                case "bc3": compressFunc = bcn.bc3; /* level = [0, 18] */ break;
                case "bc4": compressFunc = bcn.bc4; /* level = [0, 1]  */ break;
                case "bc5": compressFunc = bcn.bc5; /* level = [0, 1]  */ break;
                case "bc7": compressFunc = bcn.bc7; /* level = [0, 4]  */ break;
            }

            if(compressFunc == null)
            {
                error = "Invalid compression!";
            }
            else
            {
                // Expected to be array of Uint8Array(64).
                // [Uint8Array(64), Uint8Array(64), ... ]
                for(let i=0; i<inputBlocks.length; ++i)
                {
                    const block = inputBlocks[i];
                    if(block.length != 64)
                    {
                        error = "Invalid block size";
                        break;
                    }
                    inputPixelsBCN.set(block);
                    compressFunc(level);
                    const compressedBlock = new Uint8Array(compressedBlockSize);
                    compressedBlock.set(outputPixelsBCN);
                    compressedBlocks.push(compressedBlock);
                }
            }

            self.postMessage(
            {
                taskGid: gid,
                compressedBlocks: compressedBlocks,
                error: error
            });
        });

        // Mark this worker as available!
        self.postMessage(null);
    });

})(self);
