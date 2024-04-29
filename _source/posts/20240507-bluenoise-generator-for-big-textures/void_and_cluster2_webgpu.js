import {
    AsyncBarrier,
    loadCommonShaderSource,
    resolveChildren,
    createCanvasDragHandler,
    loadF32Lines,
    addDPIResizeWatcher
} from '../../util.js';

import {
    WebGPUState,
    presentationFormat,
    ImmContext,
    makeGPUBuffer,
    createBuffer,
    asyncMakeGPUBuffer,
    createShaderModule,
    asyncCreateShaderModule,
    asyncCompleteDesc,
    asyncCreateBindGroupLayout,
    asyncCreatePipelineLayout,
    asyncCreateComputePipeline,
    asyncCreateRenderPipeline,
    queueSyncPoint,
} from '../../webgpu_util.js';


export const VAC2 = (()=>
{
    const TILE_SIZES = [8, 16, 32];

    function loadShaderSource(name)
    {
        return fetch("./shaders/compiled/" + name).then(src => src.text());
    }
    const loadCommonShaderSourceWebGPU = (x)=>loadCommonShaderSource(x, "webgpu");
    const loadCommonShaderModule = (x)=>asyncCreateShaderModule(loadCommonShaderSourceWebGPU(x));
    const loadShaderModule = (x)=>asyncCreateShaderModule(loadShaderSource(x));

    const _RESOURCES = (()=>
    {
        const getPickPipelines = ()=>
        {
            const genlabel = (label)=>`PICK__${label}`;
            const res = {};
            
            res.bg0Layout = asyncCreateBindGroupLayout(
            {
                entries: [
                {
                    binding: 0,
                    visibility: GPUShaderStage.COMPUTE,
                    buffer: { type: "uniform", },
                },
                {
                    binding: 1,
                    visibility: GPUShaderStage.COMPUTE,
                    buffer: { type: "read-only-storage", },
                },
                {
                    binding: 2,
                    visibility: GPUShaderStage.COMPUTE,
                    buffer: { type: "storage", },
                },
                {
                    binding: 3,
                    visibility: GPUShaderStage.COMPUTE,
                    buffer: { type: "storage", },
                },
              ],
              "label": genlabel("bg0Layout"),
            });

            res.pipeLayout = asyncCreatePipelineLayout(
            {
                bindGroupLayouts: [res.bg0Layout],
                "label": genlabel("pipeLayout"),
            });

            TILE_SIZES.forEach(tilesize=>
            {
                res[tilesize] = asyncCreateComputePipeline(
                {
                    layout: res.pipeLayout,
                    compute:
                    {
                        entryPoint: "main",
                        module: loadShaderModule(`pick_${tilesize}.comp.wgsl`)
                    }
                });
            });

            return resolveChildren(res);
        };


        const getUpdateEnergyPipelines = ()=>
        {
            const genlabel = (label)=>`UPDATE_ENERGY__${label}`;
            const res = {};
            
            res.bg0Layout = asyncCreateBindGroupLayout(
            {
                entries: [
                {
                    binding: 0,
                    visibility: GPUShaderStage.COMPUTE,
                    buffer: { type: "uniform", },
                },
                {
                    binding: 1,
                    visibility: GPUShaderStage.COMPUTE,
                    buffer: { type: "storage", },
                },
                {
                    binding: 2,
                    visibility: GPUShaderStage.COMPUTE,
                    buffer: { type: "read-only-storage", },
                }
              ],
              "label": genlabel("bg0Layout"),
            });

            res.pipeLayout = asyncCreatePipelineLayout(
            {
                bindGroupLayouts: [res.bg0Layout],
                "label": genlabel("pipeLayout"),
            });

            TILE_SIZES.forEach(tilesize=>
            {
                res[tilesize] = asyncCreateComputePipeline(
                {
                    layout: res.pipeLayout,
                    compute:
                    {
                        entryPoint: "main",
                        module: loadShaderModule(`update_energy_${tilesize}.comp.wgsl`)
                    }
                });
            });
            return resolveChildren(res);
        };

        const getBufferToImagePipelines = ()=>
        {
            const genlabel = (label)=>`BUFFER_TO_IMAGE__${label}`;
            const res = {};
            
            res.bg0Layout = asyncCreateBindGroupLayout(
            {
                entries: [
                {
                    binding: 0,
                    visibility: GPUShaderStage.FRAGMENT,
                    buffer: { type: "uniform", },
                },
                {
                    binding: 1,
                    visibility: GPUShaderStage.FRAGMENT,
                    buffer: { type: "read-only-storage", },
                }
              ],
              "label": genlabel("bg0Layout"),
            });

            res.pipeLayout = asyncCreatePipelineLayout(
            {
                bindGroupLayouts: [res.bg0Layout],
                "label": genlabel("pipeLayout"),
            });

            const vertexShader = {
                entryPoint: "main",
                module: loadCommonShaderModule("draw_full_screen.vert.wgsl")
            };

            TILE_SIZES.forEach(tilesize=>
            {
                res[tilesize] = {};
                ["r32float", "r16float", "r8unorm"].forEach(innerFormat=>
                {
                    res[tilesize][innerFormat] = asyncCreateRenderPipeline(
                    {
                        layout: res.pipeLayout,
                        vertex: vertexShader,
                        fragment:
                        {
                            entryPoint: "main",
                            module: loadShaderModule(`buffer_to_image_${tilesize}.frag.wgsl`),
                            targets: [
                                { format: innerFormat },
                            ],
                        },
                        primitive: { topology: "triangle-list" },
                    });
                });
            });
            return resolveChildren(res);
        };

        const getVisBlueNoisePipelines = ()=>
        {
            const genlabel = (label)=>`VIS_BLUENOISE__${label}`;
            const res = {};
            
            res.bg0Layout = asyncCreateBindGroupLayout(
            {
                entries: [
                {
                    binding: 0,
                    visibility: GPUShaderStage.FRAGMENT,
                    buffer: { type: "uniform", },
                },
                {
                    binding: 1,
                    visibility: GPUShaderStage.FRAGMENT,
                    texture: { sampleType: "unfilterable-float" }
                }
              ],
              "label": genlabel("bg0Layout"),
            });

            res.pipeLayout = asyncCreatePipelineLayout(
            {
                bindGroupLayouts: [res.bg0Layout],
                "label": genlabel("pipeLayout"),
            });

            const vertexShader = {
                entryPoint: "main",
                module: loadCommonShaderModule("draw_full_screen_uvs.vert.wgsl")
            };

            res.tiledPipeline = asyncCreateRenderPipeline(
            {
                layout: res.pipeLayout,
                vertex: vertexShader,
                fragment:
                {
                    entryPoint: "main",
                    module: loadShaderModule("vis_bluenoise_tiled.frag.wgsl"),
                    targets: [
                        { format: presentationFormat },
                    ],
                },
                primitive: { topology: "triangle-list" },
            });

            res.scaledPipeline = asyncCreateRenderPipeline(
                {
                    layout: res.pipeLayout,
                    vertex: vertexShader,
                    fragment:
                    {
                        entryPoint: "main",
                        module: loadShaderModule("vis_bluenoise_scaled.frag.wgsl"),
                        targets: [
                            { format: presentationFormat },
                        ],
                    },
                    primitive: { topology: "triangle-list" },
                });

            return resolveChildren(res);
        };


        const getBC4CompressPipeline = ()=>
        {
            const genlabel = (label)=>`BC4COMPRESS__${label}`;
            const res = {};
            
            res.bg0Layout = asyncCreateBindGroupLayout(
            {
                entries: [
                {
                    binding: 0,
                    visibility: GPUShaderStage.FRAGMENT,
                    texture: { sampleType: "unfilterable-float" }
                }
              ],
              "label": genlabel("bg0Layout"),
            });

            res.pipeLayout = asyncCreatePipelineLayout(
            {
                bindGroupLayouts: [res.bg0Layout],
                "label": genlabel("pipeLayout"),
            });

            res.pipeline = asyncCreateRenderPipeline(
                {
                    layout: res.pipeLayout,
                    vertex: {
                        entryPoint: "main",
                        module: loadCommonShaderModule("draw_full_screen.vert.wgsl")
                    },
                    fragment:
                    {
                        entryPoint: "main",
                        module: loadShaderModule("bc4_compress.frag.wgsl"),
                        targets: [
                            { format: "rg32uint" },
                        ],
                    },
                    primitive: { topology: "triangle-list" },
                });

            return resolveChildren(res);
        };


        const limits = WebGPUState.onready.then(state=>
        {
            const deviceLimits = WebGPUState.device.limits;
            const maxDim = deviceLimits.maxTextureDimension2D;
            const maxDispatchSizeLimit = deviceLimits.maxComputeWorkgroupsPerDimension;
            const maxBufferSize = Math.min(deviceLimits.maxBufferSize, deviceLimits.maxStorageBufferBindingSize);

            const calculatedLimits = {};
            TILE_SIZES.forEach(tilesize=>
            {
                // We force an alignment of 2 to simplify scheduling tiles to update.
                // Prefered max is the max we'd expose to the slider etc.
                const prefDimLimit = Math.floor(maxDim / (tilesize * 4)) * 2;
                const maxDimLimit = Math.floor(maxDim / (tilesize * 2)) * 2;
                const maxBufferLimit = Math.floor(Math.sqrt(maxBufferSize/4) / (2 * tilesize)) * 2;

                calculatedLimits[tilesize] = {
                    prefMax: Math.min(prefDimLimit, maxBufferLimit),
                    trueMax: Math.min(maxDimLimit, Math.min(maxDispatchSizeLimit, maxBufferLimit))
                };
            });

            return calculatedLimits;
        });


        return new AsyncBarrier()
            .enqueue(WebGPUState.onready)
            .enqueue(ImmContext.onready)
            .enqueue(getPickPipelines(), "pick")
            .enqueue(getUpdateEnergyPipelines(), "updateEnergy")
            .enqueue(getBufferToImagePipelines(), "bufferToImage")
            .enqueue(getVisBlueNoisePipelines(), "visBlueNoise")
            .enqueue(getBC4CompressPipeline(), "bc4Compress")
            .enqueue(limits, "limits")
            ;

    })();

    class VAC2CanvasContext
    {
        constructor(canvas)
        {
            const self = this;
            self.redraw = ()=>{};

            let signalError = null;
            let signalReady = null;
            self.onerror = new Promise((resolve)=>{signalError=resolve;});
            self.onready = new Promise((resolve)=>{signalReady=resolve;});

            self.hasErrors = false;
            let err = (s)=>
            {
                self.hasErrors = true;
                self.redraw = ()=>{};
                signalError(s);
            };

            const ctx = canvas.getContext("webgpu");
            if(!ctx)
            {
                err("Unable to create WebGPU context.");
                return;
            }

            addDPIResizeWatcher(canvas);

            const GPUState = WebGPUState;
            GPUState.onerror.then(()=>{err(GPUState.err)});

            _RESOURCES.then(()=> 
            {
                if(!GPUState.ok) { return; }
                
                const gpu = navigator.gpu;
                const device = GPUState.device;
                const adapter = GPUState.adapter;
                const imm = ImmContext;

                let numTilesX = 4;
                let numTilesY = 4;
                let tileSize = 16; 
                let sigma = 1.9;
                let expMultiplier = Math.pow(sigma, -2) * Math.LOG2E;
                let iteration = 0;
                let visTiled = true;

                self.getIteration = ()=>iteration;

                self.getInitialState = ()=>
                {
                    return {
                        numTilesX: numTilesX,
                        numTilesY: numTilesY,
                        tileSize: tileSize,
                        sigma: sigma
                    };
                };

                self.setNumTilesX = (x)=>
                {
                    if(x != numTilesX)
                    {
                        numTilesX = x;
                        iteration = 0;
                    }
                };

                self.setNumTilesY = (x)=>
                {
                    if(x != numTilesY)
                    {
                        numTilesY = x;
                        iteration = 0;
                    }
                };

                self.setTileSize = (x)=>
                {
                    if(x != tileSize)
                    {
                        tileSize = x;
                        iteration = 0;
                    }
                };

                self.setSigma = (x)=>
                {
                    if(x != sigma)
                    {
                        sigma = x;
                        expMultiplier = Math.pow(sigma, -2) * Math.LOG2E;
                        iteration = 0;
                    }
                };

                self.setVisTiled = (x)=>
                {
                    visTiled = x;
                };


                self.reset = ()=>
                {
                    iteration = 0;
                };

                self.getProgress = ()=>
                {
                    return iteration / (tileSize * tileSize * 4);
                };


                self.isDone = ()=>
                {
                    return iteration == (tileSize * tileSize * 4);
                };

                const restoreViewportState = ()=>
                {
                    ctx.configure(
                    {
                        device,
                        format: presentationFormat,
                        size: [canvas.width, canvas.height]
                    });
                };

                const handleResize = ()=>
                {
                    if(   canvas.width  !== canvas.dpiWidth
                       || canvas.height !== canvas.dpiHeight)
                    {
                        canvas.width  = canvas.dpiWidth;
                        canvas.height = canvas.dpiHeight;
                        restoreViewportState();
                    }
                };

                self.limits = _RESOURCES.limits;

                const pickPipelines = _RESOURCES.pick;
                const updateEnergyPipelines = _RESOURCES.updateEnergy;
                const bufferToImagePipelines = _RESOURCES.bufferToImage;
                const bc4Compress = _RESOURCES.bc4Compress;
                const visBlueNoisePipelines = _RESOURCES.visBlueNoise;

                // Currently WebGPU implementations don't have proper support
                // for GPU timestamp queries, so we're just going to use a CPU timer
                // until that becomes a thing.
                const numIterationsToDoHeuristic = (()=>
                {
                    let lastDrawTime = 0;
                    let drawAmount = 0;

                    return ()=>
                    {
                        const currentTime = performance.now();
                        const prevTime = lastDrawTime;
                        lastDrawTime = currentTime;
                        const delta = currentTime - prevTime;
                        
                        // Reset heuristics every refresh.
                        if(iteration == 0)
                        {
                            // Yolo heuristic.
                            drawAmount = Math.max(
                                1,
                                Math.min(
                                    1024,
                                    Math.floor(
                                        ((8 * 8) / (tileSize * tileSize))
                                        * 256
                                        * (16 * 16) / (numTilesX * numTilesY)
                                    ) - 3
                                )
                            );
                        }

                        // Target 30fps (with some leniency)
                        else if(delta >= 34.0)
                        {
                            drawAmount = Math.max(1, drawAmount - 1);
                        }
                        else
                        {
                            drawAmount = Math.min(1024, drawAmount + 1);
                        }

                        drawAmount = Math.min(tileSize * tileSize * 4 - iteration, drawAmount);
                        return drawAmount;
                    };
                })();

                let pickBuffer = null;
                let energyBuffer = null;
                let valueBuffer = null;
                let bufferToImageParams = null;
                let valueTexture = null;
                let visBlueNoiseParams = null;

                const randomSeed = ()=>Math.floor(Math.random() * 0x7fffffff);

                // Don't risk overloading the users GPU, wait
                // until the frame before last has atleast finished.
                const waitSyncPoints = [queueSyncPoint(), queueSyncPoint()];
                let waitSyncPointIndex = 0;

                const redrawLoop = ()=>
                {
                    // Regnerate everything
                    if(iteration == 0)
                    {
                        // Wait for all previous frames to be complete, don't allow
                        // previous memory allocations to cause a DRED (like when the user
                        // is playing around with the resolution slider).
                        if(!waitSyncPoints[0].ready() || !waitSyncPoints[1].ready())
                        {
                            return;
                        }

                        const tileTextureBufferSize = (
                            numTilesX * numTilesY
                             * 4 * 4
                        );
                        
                        const fullResTextureBufferSize = (
                            numTilesX * tileSize
                            * numTilesY * tileSize
                            * 4
                        );

                        if(pickBuffer != null)          { pickBuffer.destroy(); }
                        if(energyBuffer != null)        { energyBuffer.destroy(); }
                        if(valueBuffer != null)         { valueBuffer.destroy(); }
                        if(bufferToImageParams != null) { bufferToImageParams.destroy(); }
                        if(valueTexture != null)        { valueTexture.destroy(); }
                        if(visBlueNoiseParams != null)  { visBlueNoiseParams.destroy(); }

                        // WebGPU will blank these by default for security reasons
                        pickBuffer = createBuffer(GPUBufferUsage.STORAGE, tileTextureBufferSize);
                        energyBuffer = createBuffer(GPUBufferUsage.STORAGE, fullResTextureBufferSize);
                        valueBuffer = createBuffer(GPUBufferUsage.STORAGE, fullResTextureBufferSize);
                        bufferToImageParams = makeGPUBuffer(
                            GPUBufferUsage.UNIFORM,
                            new Int32Array([numTilesX, numTilesY, 0, 0])
                        );

                        valueTexture = WebGPUState.device.createTexture({
                            dimension: "2d",
                            format: "r8unorm",
                            size: [numTilesX * tileSize, numTilesY * tileSize],
                            usage: GPUTextureUsage.RENDER_ATTACHMENT | GPUTextureUsage.TEXTURE_BINDING
                        });

                        visBlueNoiseParams = makeGPUBuffer(
                            GPUBufferUsage.UNIFORM,
                            new Float32Array([numTilesX * tileSize,
                                              numTilesY * tileSize,
                                              1.0 / (numTilesX * tileSize),
                                              1.0 / (numTilesY * tileSize)])
                        );
                    }

                    const updateEnergyPipeline = updateEnergyPipelines[tileSize];
                    const pickPipeline = pickPipelines[tileSize];
                    const bufferToImagePipeline = bufferToImagePipelines[tileSize]["r8unorm"];

                    const dispatchUpdateSizes = [
                        Math.floor((numTilesX * tileSize) / 16),
                        Math.floor((numTilesY * tileSize) / 16)
                    ];
                    const dispatchPickSizes = [
                        Math.floor(numTilesX / 2),
                        Math.floor(numTilesY / 2)
                    ];

                    let numIterationsThisFrame = numIterationsToDoHeuristic();
                    const writeValueNorm = 1.0 / (tileSize * tileSize - 1);

                    // TODO, make big single uniform buffer for all the iterations
                    //       rather than individual ones.
                    //       (When trying with offset or dynamic offsets, it didn't seem to work).
                    const makeIterationUBO = (valueIteration, tileId) =>
                    {
                        const writeValue = 1 - (valueIteration) * writeValueNorm;
                        const f32 = new Float32Array([0, 0, 0, 0, 0, 0, 0, 0]);
                        const u32 = new Uint32Array(f32.buffer, f32.byteOffset);

                        u32[0] = [0, 1, 1, 0][tileId];  // tileIdOffset.x
                        u32[1] = [0, 1, 0, 1][tileId];  // tileIdOffset.y
                        u32[2] = numTilesX;
                        u32[3] = numTilesY;
                        f32[4] = expMultiplier;
                        f32[5] = writeValue;
                        u32[6] = randomSeed();

                        return makeGPUBuffer(GPUBufferUsage.UNIFORM, f32);
                    };
                    
                    const runPass = (UBO) =>
                    {
                        // Update
                        imm.computePass({}, (pass)=>
                        {
                            pass.setPipeline(updateEnergyPipeline);
                            pass.setBindGroup(0, updateEnergyPipelines.bg0Layout.createGroup(UBO,
                                                                                             energyBuffer,
                                                                                             pickBuffer));
                            pass.dispatchWorkgroups(dispatchUpdateSizes[0], dispatchUpdateSizes[1]);
                        });

                        // Pick
                        imm.computePass({}, (pass)=>
                        {
                            pass.setPipeline(pickPipeline);
                            pass.setBindGroup(0, pickPipelines.bg0Layout.createGroup(UBO,
                                                                                     energyBuffer,
                                                                                     valueBuffer,
                                                                                     pickBuffer));
                            pass.dispatchWorkgroups(dispatchPickSizes[0], dispatchPickSizes[1]);
                        });
                    };

                    const end = iteration + numIterationsThisFrame;
                    for(; iteration < end; ++iteration)
                    {
                        const valueIteration = iteration >> 2; // div 4
                        const tileId = iteration & 3;          // mod 4
                        runPass(makeIterationUBO(valueIteration, tileId));
                    }

                    // Render to texture
                    const bufferToImageRPDesc =
                    {
                        colorAttachments:
                        [
                            {
                                clearValue: { r: 0, g: 0, b: 0, a: 1 },
                                loadOp: "clear",
                                storeOp: "store",
                                view: valueTexture.createView(),
                            },
                        ],
                    };
                    
                    imm.renderPass(bufferToImageRPDesc, (pass)=>
                    {
                        pass.setPipeline(bufferToImagePipeline);
                        pass.setBindGroup(0, bufferToImagePipelines.bg0Layout.createGroup(bufferToImageParams,
                                                                                          valueBuffer
                                                                                          ));
                        pass.draw(3);
                    });
                };

                self.redraw = ()=>
                {
                    // Don't risk overloading the users GPU, wait atleast until
                    // the work frame before last has finished processing.
                    if(!waitSyncPoints[waitSyncPointIndex].ready())
                    {
                        return;
                    }

                    handleResize();

                    const back = ctx.getCurrentTexture().createView();
                    const backRPDesc =
                    {
                        colorAttachments:
                        [
                            {
                                clearValue: { r: 0, g: 0, b: 0, a: 1 },
                                loadOp: "clear",
                                storeOp: "store",
                                view: back,
                            },
                        ],
                    };

                    if(!self.isDone())
                    {
                        redrawLoop();
                    }

                    // Draw visualisation
                    imm.renderPass(backRPDesc, (pass)=>
                    {
                        let pipeline = null;
                        if(visTiled)
                        {
                            pipeline = visBlueNoisePipelines.tiledPipeline;
                        }
                        else
                        {
                            pipeline = visBlueNoisePipelines.scaledPipeline;
                        }
                        pass.setPipeline(pipeline);
                        pass.setBindGroup(0, visBlueNoisePipelines.bg0Layout.createGroup(visBlueNoiseParams,
                                                                                          valueTexture.createView()));
                        pass.draw(3);
                    });

                    imm.submit();

                    waitSyncPoints[waitSyncPointIndex] = queueSyncPoint();
                    waitSyncPointIndex ^= 1;
                };

                const renderToNewTexture = (format, flags)=>
                {
                    const size = [numTilesX * tileSize, numTilesY * tileSize];
                    const valueTextureTmp = WebGPUState.device.createTexture({
                        dimension: "2d",
                        format: format,
                        size: size,
                        usage: flags | GPUTextureUsage.RENDER_ATTACHMENT
                    });

                    // Render to texture
                    const bufferToImageRPDesc =
                    {
                        colorAttachments:
                        [
                            {
                                clearValue: { r: 0, g: 0, b: 0, a: 1 },
                                loadOp: "clear",
                                storeOp: "store",
                                view: valueTextureTmp.createView(),
                            },
                        ],
                    };
                    
                    imm.renderPass(bufferToImageRPDesc, (pass)=>
                    {
                        const bufferToImagePipeline = bufferToImagePipelines[tileSize][format];
                        pass.setPipeline(bufferToImagePipeline);
                        pass.setBindGroup(0, bufferToImagePipelines.bg0Layout.createGroup(bufferToImageParams,
                                                                                          valueBuffer
                                                                                          ));
                        pass.draw(3);
                    });

                    return valueTextureTmp;
                };

                self.getBlueNoiseRaw = (format)=>
                {
                    const valueTextureTmp = renderToNewTexture(format, GPUTextureUsage.COPY_SRC);

                    const size = [numTilesX * tileSize, numTilesY * tileSize];
                    const byteSize = {"r32float": 4, "r16float": 2, "r8unorm": 1}[format];
                    const rowAlignment = Math.floor(256 / byteSize);
                    const alignedSizeX = ((size[0] - 1) | (rowAlignment - 1)) + 1;
                    const needsRemapping = alignedSizeX != size[0];

                    const readBackBuffer = createBuffer(GPUBufferUsage.COPY_DST | GPUBufferUsage.MAP_READ,
                                                        alignedSizeX * size[1] * byteSize);

                    imm.copyTextureToBuffer({texture: valueTextureTmp},
                                            {buffer: readBackBuffer, bytesPerRow: byteSize * alignedSizeX},
                                            [size[0], size[1]]);
                    imm.submit();

                    return readBackBuffer.mapAsync(GPUMapMode.READ).then((x,y,z)=>
                    {
                        const readBackSrc = readBackBuffer.getMappedRange();
                        const arrayType = {"r32float": Float32Array, "r16float": Uint16Array, "r8unorm": Uint8Array}[format];
                        let outBuffer = new arrayType(alignedSizeX * size[1]);
                        outBuffer.set(new arrayType(readBackSrc));

                        readBackBuffer.unmap();
                        readBackBuffer.destroy();
                        valueTextureTmp.destroy();

                        if(needsRemapping)
                        {
                            const remappedOutBuffer = new arrayType(size[0] * size[1]);
                            const srcRowStride = alignedSizeX;
                            const dstRowStride = size[0];
                            for(let y=0; y<size[1]; ++y)
                            {
                                const rowSrc = srcRowStride * y;
                                const rowDst = dstRowStride * y;
                                remappedOutBuffer.set(outBuffer.slice(rowSrc, rowSrc + size[0]),
                                                      rowDst);
                            }
                            outBuffer = remappedOutBuffer;
                        }
                        return [outBuffer, size[0], size[1]];
                    });

                };

                self.getBc4Compressed = ()=>
                {
                    const valueTextureTmp = renderToNewTexture("r32float", GPUTextureUsage.TEXTURE_BINDING);
                    
                    const size = [Math.floor(numTilesX * tileSize / 4),
                                  Math.floor(numTilesY * tileSize / 4)];
                    
                    const bc4TextureTmp = WebGPUState.device.createTexture({
                        dimension: "2d",
                        format: "rg32uint",
                        size: size,
                        usage: GPUTextureUsage.RENDER_ATTACHMENT | GPUTextureUsage.COPY_SRC
                    });

                    const bc4CompressRPDesc =
                    {
                        colorAttachments:
                        [
                            {
                                clearValue: { r: 0, g: 0, b: 0, a: 1 },
                                loadOp: "clear",
                                storeOp: "store",
                                view: bc4TextureTmp.createView(),
                            },
                        ],
                    };
                    
                    imm.renderPass(bc4CompressRPDesc, (pass)=>
                    {
                        pass.setPipeline(bc4Compress.pipeline);
                        pass.setBindGroup(0, bc4Compress.bg0Layout.createGroup(valueTextureTmp.createView()));
                        pass.draw(3);
                    });

                    const byteSize = 8;
                    const rowAlignment = Math.floor(256 / byteSize);
                    const alignedSizeX = ((size[0] - 1) | (rowAlignment - 1)) + 1;
                    const needsRemapping = alignedSizeX != size[0];

                    const readBackBuffer = createBuffer(GPUBufferUsage.COPY_DST | GPUBufferUsage.MAP_READ,
                                                        alignedSizeX * size[1] * byteSize);

                    imm.copyTextureToBuffer({texture: bc4TextureTmp},
                                            {buffer: readBackBuffer, bytesPerRow: byteSize * alignedSizeX},
                                            [size[0], size[1]]);
                    imm.submit();

                    return readBackBuffer.mapAsync(GPUMapMode.READ).then((x,y,z)=>
                    {
                        const readBackSrc = readBackBuffer.getMappedRange();
                        let outBuffer = new Uint32Array(alignedSizeX * 2 * size[1]);
                        outBuffer.set(new Uint32Array(readBackSrc));

                        readBackBuffer.unmap();
                        readBackBuffer.destroy();
                        valueTextureTmp.destroy();
                        bc4TextureTmp.destroy();

                        if(needsRemapping)
                        {
                            const remappedOutBuffer = new Uint32Array(size[0] * size[1] * 2);
                            const srcRowStride = alignedSizeX * 2;
                            const dstRowStride = size[0] * 2;
                            for(let y=0; y<size[1]; ++y)
                            {
                                const rowSrc = srcRowStride * y;
                                const rowDst = dstRowStride * y;
                                remappedOutBuffer.set(outBuffer.slice(rowSrc, rowSrc + 2 * size[0]),
                                                      rowDst);
                            }
                            outBuffer = remappedOutBuffer;
                        }
                        return outBuffer;
                    });
                };
                restoreViewportState();
                signalReady(self);
            });

        }
    };


    function bindVAC2Context(canvas)
    {
        if(canvas.drawCtx == undefined)
        {
            canvas.drawCtx = new VAC2CanvasContext(canvas);
        }
        return canvas.drawCtx;
    };

    return {
        bindVAC2Context: bindVAC2Context,
        WebGPUState: WebGPUState,
        _RESOURCES: _RESOURCES
    };

})();
