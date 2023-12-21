import {
    AsyncBarrier,
    loadCommonShaderSource,
    resolveChildren,
    createCanvasDragHandler,
    loadF32Lines
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


export const RTV2 = (()=>
{
    function loadShaderSource(name)
    {
        return fetch("./shaders/compiled/" + name).then(src => src.text());
    }
    const loadCommonShaderSourceWebGPU = (x)=>loadCommonShaderSource(x, "webgpu");
    const loadCommonShaderModule = (x)=>asyncCreateShaderModule(loadCommonShaderSourceWebGPU(x));
    const loadShaderModule = (x)=>asyncCreateShaderModule(loadShaderSource(x));

    const tracingVisTypes = ["pointlight", "visibility", "num_visits", "num_intersections", "composite"];

    const _RESOURCES = (()=>
    {
        const drawColFragment = {
            entryPoint: "main",
            module: loadCommonShaderModule("draw_col.frag.wgsl"),
            targets: [
                { format: presentationFormat },
            ],
        };

        const getV2GenResources = ()=>
        {
            const res = {};
            const genlabel = (label)=>`V2_TRACING_BVHGEN__${label}`;

            res.bg0Layout = asyncCreateBindGroupLayout(
            {
                entries: [
                {
                    binding: 0,
                    visibility: GPUShaderStage.COMPUTE,
                    buffer: { type: "read-only-storage", },
                },
                {
                    binding: 1,
                    visibility: GPUShaderStage.COMPUTE,
                    buffer: { type: "storage", },
                },
                {
                    binding: 2,
                    visibility: GPUShaderStage.COMPUTE,
                    buffer: { type: "uniform", },
                },
              ],
              "label": genlabel("bg0Layout"),
            });

            res.pipeLayout = asyncCreatePipelineLayout(
            {
                bindGroupLayouts: [res.bg0Layout],
                "label": genlabel("pipeLayout"),
            });

            // permutations
            for(let i=1; i<5; ++i)
            {
                res[`pipelineL${i}`] = asyncCreateComputePipeline(
                {
                    layout: res.pipeLayout,
                    compute:
                    {
                        entryPoint: "main",
                        module: loadCommonShaderModule(`v2_tracing_generate_bvh_L${i}.comp.wgsl`)
                    }
                });
            }

            return resolveChildren(res);
        };

        const getDrawLinesResources = ()=>
        {
            const res = {};
            const genlabel = (label)=>`DRAWLINES__${label}`;

            res.bg0Layout = asyncCreateBindGroupLayout(
            {
                entries: [
                {
                    binding: 0,
                    visibility: GPUShaderStage.VERTEX,
                    buffer: { type: "read-only-storage", },
                },
                {
                    binding: 1,
                    visibility: GPUShaderStage.VERTEX,
                    buffer: { type: "uniform", },
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
                vertex:
                {
                    entryPoint: "main",
                    module: loadShaderModule("draw_lines.vert.wgsl")
                },
                fragment: drawColFragment,
                primitive: { topology: "line-list" },
            });

            return resolveChildren(res);
        };

        const getV2TracingResources = ()=>
        {
            const res = {};
            const genlabel = (label)=>`V2TRACING__${label}`;

            res.bg0Layout = asyncCreateBindGroupLayout(
            {
                entries: [
                {
                    binding: 0,
                    visibility: GPUShaderStage.FRAGMENT,
                    buffer: { type: "read-only-storage", },
                },
                {
                    binding: 1,
                    visibility: GPUShaderStage.FRAGMENT,
                    buffer: { type: "uniform", },
                },
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

            tracingVisTypes.forEach((pipeType)=>
            {
                res[`pipeline_${pipeType}`] = asyncCreateRenderPipeline(
                {
                    layout: res.pipeLayout,
                    vertex: vertexShader,
                    fragment:
                    {
                        entryPoint: "main",
                        module: loadShaderModule(`v2_tracing_test_${pipeType}.frag.wgsl`),
                        targets: [
                            { format: presentationFormat },
                        ],
                    },
                    primitive: { topology: "triangle-list" },
                });
            });

            return resolveChildren(res);
        };

        const getPickLineToEditResources = ()=>
        {
            const res = {};
            const genlabel = (label)=>`PICK_LINE_TO_EDIT__${label}`;

            res.bg0Layout = asyncCreateBindGroupLayout(
            {
                entries: [
                {
                    binding: 0,
                    visibility: GPUShaderStage.COMPUTE,
                    buffer: { type: "read-only-storage", },
                },
                {
                    binding: 1,
                    visibility: GPUShaderStage.COMPUTE,
                    buffer: { type: "storage", },
                },
                {
                    binding: 2,
                    visibility: GPUShaderStage.COMPUTE,
                    buffer: { type: "uniform", },
                },
                {
                    binding: 3,
                    visibility: GPUShaderStage.COMPUTE,
                    buffer: { type: "uniform", },
                },
              ],
              "label": genlabel("bg0Layout"),
            });

            res.pipeLayout = asyncCreatePipelineLayout(
            {
                bindGroupLayouts: [res.bg0Layout],
                "label": genlabel("pipeLayout"),
            });

            res.pipeline = asyncCreateComputePipeline(
            {
                layout: res.pipeLayout,
                compute:
                {
                    entryPoint: "main",
                    module: loadShaderModule("pick_line_to_edit.comp.wgsl")
                }
            });

            return resolveChildren(res);
        };

        const getApplySnappingResources = ()=>
        {
            const res = {};
            const genlabel = (label)=>`APPLY_SNAPPING__${label}`;

            res.bg0Layout = asyncCreateBindGroupLayout(
            {
                entries: [
                {
                    binding: 0,
                    visibility: GPUShaderStage.COMPUTE,
                    buffer: { type: "read-only-storage", },
                },
                {
                    binding: 1,
                    visibility: GPUShaderStage.COMPUTE,
                    buffer: { type: "uniform", },
                },
                {
                    binding: 2,
                    visibility: GPUShaderStage.COMPUTE,
                    buffer: { type: "uniform", },
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

            res.pipeline = asyncCreateComputePipeline(
            {
                layout: res.pipeLayout,
                compute:
                {
                    entryPoint: "main",
                    module: loadShaderModule("apply_snapping.comp.wgsl")
                }
            });

            return resolveChildren(res);
        };

        const getApplyLineEditResources = ()=>
        {
            const res = {};
            const genlabel = (label)=>`APPLY_LINE_EDIT__${label}`;

            res.bg0Layout = asyncCreateBindGroupLayout(
            {
                entries: [
                {
                    binding: 0,
                    visibility: GPUShaderStage.COMPUTE,
                    buffer: { type: "storage", },
                },
                {
                    binding: 1,
                    visibility: GPUShaderStage.COMPUTE,
                    buffer: { type: "uniform", },
                },
                {
                    binding: 2,
                    visibility: GPUShaderStage.COMPUTE,
                    buffer: { type: "uniform", },
                },
              ],
              "label": genlabel("bg0Layout"),
            });

            res.pipeLayout = asyncCreatePipelineLayout(
            {
                bindGroupLayouts: [res.bg0Layout],
                "label": genlabel("pipeLayout"),
            });

            res.pipeline = asyncCreateComputePipeline(
            {
                layout: res.pipeLayout,
                compute:
                {
                    entryPoint: "main",
                    module: loadShaderModule("apply_line_edit.comp.wgsl")
                }
            });

            return resolveChildren(res);
        };

        const getDrawEditablePointsResources = ()=>
        {
            const res = {};
            const genlabel = (label)=>`DRAWEDPTS__${label}`;

            res.bg0Layout = asyncCreateBindGroupLayout(
            {
                entries: [
                {
                    binding: 0,
                    visibility: GPUShaderStage.VERTEX,
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

            res.pipeline = asyncCreateRenderPipeline(
            {
                layout: res.pipeLayout,
                vertex:
                {
                    entryPoint: "main",
                    module: loadShaderModule("draw_editable_points.vert.wgsl")
                },
                fragment:
                {
                    entryPoint: "main",
                    module: loadShaderModule("draw_editable_points.frag.wgsl"),
                    targets: [
                        {
                            format: presentationFormat,
                            blend:
                            {
                                color: { srcFactor: "src-alpha", dstFactor: "one-minus-src-alpha"},
                                alpha: { srcFactor: "src-alpha", dstFactor: "one-minus-src-alpha"}
                            }
                        },
                    ],
                },
                primitive: { topology: "triangle-list" },
            });

            return resolveChildren(res);
        };

        const getDrawPickedPointResources = ()=>
        {
            const res = {};
            const genlabel = (label)=>`DRAWPICKED__${label}`;

            res.bg0Layout = asyncCreateBindGroupLayout(
            {
                entries: [
                {
                    binding: 0,
                    visibility: GPUShaderStage.VERTEX,
                    buffer: { type: "read-only-storage", },
                },
                {
                    binding: 1,
                    visibility: GPUShaderStage.VERTEX,
                    buffer: { type: "uniform", },
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
                vertex:
                {
                    entryPoint: "main",
                    module: loadShaderModule("draw_picked_point.vert.wgsl")
                },
                fragment:
                {
                    entryPoint: "main",
                    module: loadShaderModule("draw_picked_point.frag.wgsl"),
                    targets: [
                        {
                            format: presentationFormat,
                            blend:
                            {
                                color: { srcFactor: "src-alpha", dstFactor: "one-minus-src-alpha"},
                                alpha: { srcFactor: "src-alpha", dstFactor: "one-minus-src-alpha"}
                            }
                        },
                    ],
                },
                primitive: { topology: "triangle-list" },
            });

            return resolveChildren(res);
        };

        const getDrawTreeResources = ()=>
        {
            const res = {};
            const genlabel = (label)=>`DRAWTREE__${label}`;

            res.bg0Layout = asyncCreateBindGroupLayout(
            {
                entries: [
                {
                    binding: 0,
                    visibility: GPUShaderStage.VERTEX,
                    buffer: { type: "read-only-storage", },
                },
                {
                    binding: 1,
                    visibility: GPUShaderStage.VERTEX,
                    buffer: { type: "uniform", },
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
                vertex:
                {
                    entryPoint: "main",
                    module: loadShaderModule("draw_tree.vert.wgsl")
                },
                fragment:
                {
                    entryPoint: "main",
                    module: loadShaderModule("draw_tree.frag.wgsl"),
                    targets: [
                        {
                            format: presentationFormat,
                            blend:
                            {
                                color: { srcFactor: "src-alpha", dstFactor: "one-minus-src-alpha"},
                                alpha: { srcFactor: "src-alpha", dstFactor: "one-minus-src-alpha"}
                            }
                        },
                    ],
                },
                primitive: { topology: "triangle-list" },
            });

            return resolveChildren(res);
        };

        const getLinesResources = ()=>
        {
            const res = new AsyncBarrier();
            const makeLinesEntry = (linesData)=>
            {
                const refBuffer = asyncMakeGPUBuffer(GPUBufferUsage.COPY_SRC, linesData);
                const buffer = asyncMakeGPUBuffer(GPUBufferUsage.STORAGE | GPUBufferUsage.COPY_DST, linesData);
                const numLines = linesData.then((x)=>x.length/4);
                const numLinesUBO = numLines.then((x)=>asyncMakeGPUBuffer(GPUBufferUsage.UNIFORM, new Uint32Array([x])))
                const reset = Promise.all([refBuffer, buffer, linesData.then(x=>x.byteLength)]).then(
                    ([refBuffer, buffer, numBytes])=>
                    {
                        return (cmdBuf)=>
                        {
                            cmdBuf.copyBufferToBuffer(refBuffer, 0, buffer, 0, numBytes);
                        };
                    }
                );
                return {
                    data: linesData,
                    refBuffer: refBuffer,
                    buffer: buffer,
                    numLines: numLines,
                    numLinesUBO: numLinesUBO,
                    reset: reset
                };
            };

            const makeLinesEntryFromPath = (path)=>
            {
                return makeLinesEntry(loadF32Lines(path));
            };

            const simple = makeLinesEntryFromPath("/res/lines_simple0.f32");
            const moderate = makeLinesEntryFromPath("/res/lines_moderate0.f32");
            const complex = makeLinesEntryFromPath("/res/lines.f32");
            const veryComplex = makeLinesEntry(complex.data.then((lines)=>
            {
                const linesData = new Float32Array(lines.length * 4);
                for(let i=0; i<lines.length; (i += 4))
                {
                    const x0 = 0.5 * lines[i];
                    const y0 = 0.5 * lines[i+1];
                    const x1 = 0.5 * lines[i+2];
                    const y1 = 0.5 * lines[i+3];

                    linesData[i*4 + 0] = x0;
                    linesData[i*4 + 1] = y0;
                    linesData[i*4 + 2] = x1;
                    linesData[i*4 + 3] = y1;

                    linesData[(i+1)*4 + 0] = x0 + 0.5;
                    linesData[(i+1)*4 + 1] = y0;
                    linesData[(i+1)*4 + 2] = x1 + 0.5;
                    linesData[(i+1)*4 + 3] = y1;

                    linesData[(i+2)*4 + 0] = x0 + 0.5;
                    linesData[(i+2)*4 + 1] = y0 + 0.5;
                    linesData[(i+2)*4 + 2] = x1 + 0.5;
                    linesData[(i+2)*4 + 3] = y1 + 0.5;

                    linesData[(i+3)*4 + 0] = x0;
                    linesData[(i+3)*4 + 1] = y0  + 0.5;
                    linesData[(i+3)*4 + 2] = x1;
                    linesData[(i+3)*4 + 3] = y1  + 0.5;
                }

                return linesData;
            }));


            return resolveChildren({
                simple: simple,
                moderate: moderate,
                complex: complex,
                veryComplex: veryComplex
            });
        };

        return new AsyncBarrier()
                    .enqueue(WebGPUState.onready)
                    .enqueue(ImmContext.onready)
                    .enqueue(getV2GenResources(), "v2GenBVH")
                    .enqueue(getV2TracingResources(), "v2Tracing")
                    .enqueue(getPickLineToEditResources(), "pickLineToEdit")
                    .enqueue(getApplySnappingResources(), "applyLineSnapping")
                    .enqueue(getApplyLineEditResources(), "applyLineEdit")
                    .enqueue(getDrawLinesResources(), "drawLines")
                    .enqueue(getDrawEditablePointsResources(), "drawEditablePoints")
                    .enqueue(getDrawPickedPointResources(), "drawPickedPoint")
                    .enqueue(getDrawTreeResources(), "drawTree")
                    .enqueue(getLinesResources(), "lines")
                    ;
    })();


    class RTV2CanvasContext
    {
        constructor(canvas)
        {
            const self = this;
            self.redraw = ()=>{};
            const GPUState = WebGPUState;

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
            }

            const ctx = canvas.getContext("webgpu");
            if(!ctx)
            {
                err("Unable to create WebGPU context.");
                return;
            }

            GPUState.onerror.then(()=>{err(GPUState.err)});
            _RESOURCES.then(()=> // includes WebGPUState.onready
            {
                if(!GPUState.ok) { return; }

                const gpu = navigator.gpu;
                const device = GPUState.device;
                const adapter = GPUState.adapter;
                const imm = ImmContext;
                const v2GenBVH = _RESOURCES.v2GenBVH;
                const v2Tracing = _RESOURCES.v2Tracing;
                const pickLineToEdit = _RESOURCES.pickLineToEdit;
                const applyLineSnapping = _RESOURCES.applyLineSnapping;
                const applyLineEdit = _RESOURCES.applyLineEdit;
                const linesResources = _RESOURCES.lines;
                const drawLines = _RESOURCES.drawLines;
                const drawEditablePoints = _RESOURCES.drawEditablePoints;
                const drawPickedPoint = _RESOURCES.drawPickedPoint;
                const drawTree = _RESOURCES.drawTree;

                const blackUBO = makeGPUBuffer(GPUBufferUsage.UNIFORM, new Float32Array([0, 0, 0, 0]));
                const whiteUBO = makeGPUBuffer(GPUBufferUsage.UNIFORM, new Float32Array([1, 1, 1, 1]));

                let dirtyBVH = true;
                let bvhLevel = 3;
                let bvh = null;
                let currentLines = linesResources.complex;
                let dummyPickedUBO = makeGPUBuffer(GPUBufferUsage.UNIFORM, new Uint32Array([0xffffffff, 0]));
                let draggedThisFrame = false;
                let pickedUBO = null;
                let editingMode = false;
                let snapWhileEditing = true;

                let currentTracingVisType = 1;

                let shouldDrawTree = false;
                let drawTreeLevel = 2 * bvhLevel - 1;
                let drawTreeLevelStart = 0;
                let drawTreeSkip = 0;
                let drawTreeSkipUBO = makeGPUBuffer(GPUBufferUsage.UNIFORM, new Int32Array([drawTreeSkip]));

                const lastClickedUV = [0.4, 0.6];
                let lastClickedUBO = makeGPUBuffer(GPUBufferUsage.UNIFORM, new Float32Array(lastClickedUV));
                let raySourceUBO = lastClickedUBO;

                const setLastClickedUV = (uv)=>
                {
                    if((lastClickedUV[0] != uv[0]) || (lastClickedUV[1] != uv[1]))
                    {
                        lastClickedUV[0] = uv[0];
                        lastClickedUV[1] = uv[1];
                        lastClickedUBO = makeGPUBuffer(GPUBufferUsage.UNIFORM,
                                                       new Float32Array(lastClickedUV));
                        
                        draggedThisFrame = true;
                        if(!editingMode)
                        {
                            raySourceUBO = lastClickedUBO;
                        }
                    }
                };

                const haltEditing = ()=>
                {
                    pickedUBO = null;
                };

                const startDragging = (uv)=>
                {
                    draggedThisFrame = true;
                    setLastClickedUV(uv);
                    if(editingMode)
                    {
                        pickedUBO = device.createBuffer({
                            size: 4 * 2,
                            usage: GPUBufferUsage.UNIFORM | GPUBufferUsage.STORAGE,
                        });
                        imm.computePass({}, (pass)=>
                        {
                            pass.setPipeline(pickLineToEdit.pipeline);
                            pass.setBindGroup(0, pickLineToEdit.bg0Layout.createGroup(currentLines.buffer,
                                                                                      pickedUBO,
                                                                                      currentLines.numLinesUBO,
                                                                                      lastClickedUBO));
                            pass.dispatchWorkgroups(1);
                        });
                    }
                    self.redraw();
                };

                const drag = (uv)=>
                {
                    setLastClickedUV(uv);
                    self.redraw();
                };

                const stopDragging = ()=>
                {
                    haltEditing();
                    self.redraw();
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
                    if(   canvas.width  !== canvas.clientWidth
                       || canvas.height !== canvas.clientHeight)
                    {
                        canvas.width  = canvas.clientWidth;
                        canvas.height = canvas.clientHeight;
                        restoreViewportState();
                    }
                };

                const draw = ()=>
                {
                    handleResize();
                    const doDragUpdates = draggedThisFrame;
                    draggedThisFrame = false;

                    if(doDragUpdates && editingMode && pickedUBO)
                    {
                        imm.computePass({}, (pass)=>
                        {
                            let referenceUV = lastClickedUBO;

                            if(snapWhileEditing)
                            {
                                referenceUV = makeGPUBuffer(GPUBufferUsage.UNIFORM | GPUBufferUsage.STORAGE,
                                                            new Float32Array(lastClickedUV));

                                pass.setPipeline(applyLineSnapping.pipeline);
                                pass.setBindGroup(0, applyLineSnapping.bg0Layout.createGroup(currentLines.buffer,
                                                                                             pickedUBO,
                                                                                             currentLines.numLinesUBO,
                                                                                             referenceUV));
                                pass.dispatchWorkgroups(1);
                            }

                            pass.setPipeline(applyLineEdit.pipeline);
                            pass.setBindGroup(0, applyLineEdit.bg0Layout.createGroup(currentLines.buffer,
                                                                                     pickedUBO,
                                                                                     referenceUV));
                            pass.dispatchWorkgroups(1);
                        });
                        dirtyBVH = true;
                    }

                    if(dirtyBVH)
                    {
                        dirtyBVH = false;
                        const gridSize = 1 << bvhLevel;
                        const nodeNumFloat4 = 3;
                        const bvhFloat4Size = (gridSize * gridSize - 1) * nodeNumFloat4
                                            + currentLines.numLines
                                            ;

                        const float4Bytes = 16;
                        bvh = device.createBuffer({
                            size: bvhFloat4Size * float4Bytes,
                            usage: GPUBufferUsage.STORAGE
                        });

                        imm.computePass({}, (pass)=>
                        {
                            pass.setPipeline(v2GenBVH[`pipelineL${bvhLevel}`]);
                            pass.setBindGroup(0, v2GenBVH.bg0Layout.createGroup(currentLines.buffer,
                                                                                bvh,
                                                                                currentLines.numLinesUBO));
                            pass.dispatchWorkgroups(1);
                        });
                    }

                    const back = ctx.getCurrentTexture().createView();
                    const backRPDesc =
                    {
                        colorAttachments:
                        [
                            {
                                clearValue: shouldDrawTree
                                            ? { r: 1, g: 1, b: 1, a: 1 }
                                            : { r: 0, g: 0, b: 0, a: 1 },
                                loadOp: "clear",
                                storeOp: "store",
                                view: back,
                            },
                        ],
                    };

                    imm.renderPass(backRPDesc, (pass)=>
                    {

                        if(shouldDrawTree)
                        {
                            const maxLevel = 2 * bvhLevel - 1;
                            const endLevel = (drawTreeLevel < maxLevel ? drawTreeLevel : maxLevel);
                            const startLevel = (drawTreeLevelStart < endLevel ? drawTreeLevelStart : endLevel);

                            const numNodes = ((2 << endLevel)-1)<<1;
                            const numSkipNodes = ((1 << startLevel)-1)<<1;

                            const numNodesToDraw = numNodes - numSkipNodes;

                            if(drawTreeSkip != numSkipNodes)
                            {
                                drawTreeSkip = numSkipNodes;
                                drawTreeSkipUBO = makeGPUBuffer(GPUBufferUsage.UNIFORM, new Int32Array([drawTreeSkip]));
                            }

                            pass.setPipeline(drawTree.pipeline);
                            pass.setBindGroup(0, drawTree.bg0Layout.createGroup(bvh,
                                                                                drawTreeSkipUBO));
                            pass.draw(numNodesToDraw * 6);

                        }
                        else
                        {
                            pass.setPipeline(v2Tracing[`pipeline_${tracingVisTypes[currentTracingVisType]}`]);
                            pass.setBindGroup(0, v2Tracing.bg0Layout.createGroup(bvh, raySourceUBO));
                            pass.draw(3);                            
                        }

                        pass.setPipeline(drawLines.pipeline);
                        pass.setBindGroup(0, drawLines.bg0Layout.createGroup(currentLines.buffer,
                                                                             shouldDrawTree ? blackUBO : whiteUBO));
                        pass.draw(currentLines.numLines * 2);

                        if(editingMode)
                        {
                            pass.setPipeline(drawEditablePoints.pipeline);
                            pass.setBindGroup(0, drawEditablePoints.bg0Layout.createGroup(currentLines.buffer));
                            pass.draw(currentLines.numLines * 12);

                            if(pickedUBO)
                            {
                                pass.setPipeline(drawPickedPoint.pipeline);
                                pass.setBindGroup(0, drawPickedPoint.bg0Layout.createGroup(currentLines.buffer,
                                                                                           pickedUBO));
                                pass.draw(12);                                
                            }
                        }

                    });

                    imm.submit();
                };

                draw();
                createCanvasDragHandler(canvas,
                                        startDragging,
                                        drag,
                                        stopDragging);
                
                self.redraw = ()=>{ requestAnimationFrame(draw); }

                self.setCurrentLines = (idx)=>
                {
                    const picked = [
                        linesResources.simple,
                        linesResources.moderate,
                        linesResources.complex,
                        linesResources.veryComplex
                    ][idx % 4];

                    if(picked != currentLines)
                    {
                        haltEditing();
                        currentLines = picked;
                        dirtyBVH = true;
                        self.redraw();
                    }
                };

                self.resetLines = ()=>
                {
                    haltEditing();
                    currentLines.reset(imm);
                    dirtyBVH = true;
                    self.redraw();
                };
                
                self.setBVHLevel = (level)=>
                {
                    if(level != bvhLevel)
                    {
                        bvhLevel = level;
                        dirtyBVH = true;
                        self.redraw();
                    }
                };

                self.setCurrentTracingVisType = (mode)=>
                {
                    if(currentTracingVisType != mode)
                    {
                        currentTracingVisType = mode;
                        if(!shouldDrawTree)
                        {
                            self.redraw();
                        }
                    }
                };

                self.setEditing = (inEditingMode)=>
                {
                    if(editingMode != inEditingMode)
                    {
                        editingMode = inEditingMode;
                        self.redraw();
                    }
                };

                self.setSnapWhileEditing = (flag)=>
                {
                    snapWhileEditing = flag;
                };

                self.setDrawTree = (flag)=>
                {
                    if(flag != shouldDrawTree)
                    {
                        shouldDrawTree = flag;
                        self.redraw();
                    }
                };

                self.setDrawTreeLevel = (level)=>
                {
                    if(level != drawTreeLevel)
                    {
                        drawTreeLevel = level;
                        if(shouldDrawTree)
                        {
                            self.redraw();
                        }
                    }
                };

                self.setDrawTreeLevelStart = (level)=>
                {
                    if(level != drawTreeLevelStart)
                    {
                        drawTreeLevelStart = level;
                        if(shouldDrawTree)
                        {
                            self.redraw();
                        }
                    }
                };

                signalReady(self);

            });
        }
    };

    function bindRTV2Context(canvas)
    {
        if(canvas.drawCtx == undefined)
        {
            canvas.drawCtx = new RTV2CanvasContext(canvas);
        }
        return canvas.drawCtx;
    }

    return {
        bindRTV2Context: bindRTV2Context,
    }
})();
