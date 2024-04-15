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
    asyncMakeGPUBuffer,
    createShaderModule,
    asyncCreateShaderModule,
    asyncCompleteDesc,
    asyncCreateBindGroupLayout,
    asyncCreatePipelineLayout,
    asyncCreateComputePipeline,
    asyncCreateRenderPipeline,
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
                res[tilesize] = asyncCreateRenderPipeline(
                {
                    layout: res.pipeLayout,
                    vertex: vertexShader,
                    fragment:
                    {
                        entryPoint: "main",
                        module: loadShaderModule(`buffer_to_image_${tilesize}.frag.wgsl`),
                        targets: [
                            { format: "r32float" },
                        ],
                    },
                    primitive: { topology: "triangle-list" },
                });
            });
            return resolveChildren(res);
        };

        return new AsyncBarrier()
            .enqueue(WebGPUState.onready)
            .enqueue(ImmContext.onready)
            .enqueue(getPickPipelines(), "pick")
            .enqueue(getUpdateEnergyPipelines(), "updateEnergy")
            .enqueue(getBufferToImagePipelines(), "bufferToImage")
            ;

    })();

    class VAC2CanvasContext
    {
        constructor(canvas)
        {
            const self = this;
            self.redraw = ()=>{};
            const GPUState = WebGPUState;

            // _RESOURCES.then(()=> // includes WebGPUState.onready
            // {
            //     if(!GPUState.ok) { return; }
            //     debugger;
            // });

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
