import {
    AsyncBarrier,
    loadCommonShaderSource
} from '../../util.js';

import {
    createShader,
    createGraphicsProgram,
    getUniformLocation,
    deleteShaders
} from '../../webgl_util.js';


export const DfrtV1 = (()=>{
    
    function loadShaderSource(name)
    {
        return fetch("./shaders/compiled/" + name).then(src => src.text());
    }

    const _GLOBAL_SHADERS_DATA = new AsyncBarrier()
        .enqueue(loadCommonShaderSource("draw_full_screen_uvs.vert"), "DRAW_FULL_SCREEN_UVS_VERT_SRC")
        .enqueue(loadCommonShaderSource("const_col.frag"), "CONST_COL_FRAG_SRC")
        ;
    
    const _RESOURCES = new AsyncBarrier()
        .enqueue(_GLOBAL_SHADERS_DATA.selfBarrier(), null, ["DRAW_FULL_SCREEN_UVS_VERT_SRC", "CONST_COL_FRAG_SRC"])
        .enqueue(loadCommonShaderSource("draw_col.frag"), "V1_DRAW_BVH_FRAG_SRC")
        .enqueue(loadShaderSource("dfrt_v1_tracing_test_composite.frag"), "V1_TRACING_TEST_COMPOSITE_FRAG_SRC")
        .enqueue(loadShaderSource("dfrt_v1_tracing_test_num_intersections.frag"), "V1_TRACING_TEST_NUM_INTERSECTIONS_FRAG_SRC")
        .enqueue(loadShaderSource("dfrt_v1_tracing_test_num_iterations.frag"), "V1_TRACING_TEST_NUM_ITERATIONS_FRAG_SRC")
        .enqueue(loadShaderSource("dfrt_v1_tracing_test_visibility.frag"), "V1_TRACING_TEST_VISIBILITY_FRAG_SRC")
        .enqueue(loadShaderSource("dfrt_v1_tracing_test_pointlight.frag"), "V1_TRACING_TEST_POINTLIGHT_FRAG_SRC")
        .enqueue(loadShaderSource("dfrt_v1_vis_df_dist.frag"), "V1_VIS_DF_DIST_FRAG_SRC")
        .enqueue(loadShaderSource("dfrt_v1_vis_df_numlines.frag"), "V1_VIS_DF_NUMLINES_FRAG_SRC")
        .enqueue(loadShaderSource("dfrt_v1_vis_df_composite.frag"), "V1_VIS_DF_COMPOSITE_FRAG_SRC")
        .enqueue(loadShaderSource("draw_lines.vert"), "DRAW_LINES_VERT_SRC")
        ;

    class DFRTV1CanvasContext
    {
        constructor(canvas)
        {
            // https://registry.khronos.org/webgl/specs/latest/1.0/#5.2
            const GL = canvas.getContext("webgl2", {"alpha": false, "depth": false, "stencil": false});
            this.canvas = canvas;
            this.valid = GL;

            this.redraw = ()=>{};
            if(!this.valid)
            {
                return;
            }

            this.drawLines = true;
            this.dfRes = 128;
            this.visMode = 0;
            this.linesPath = "/res/lines.f32";

            const worker = new Worker("dfrt_v1_worker.js", {type: "module"});
            const self = this;

            // State containing the current textures etc
            let DFRTState = null;

            const setDFRTState = (textureRes, dfTextureData, linesBufferData, linesData)=>
            {
                if(DFRTState != null)
                {
                    GL.deleteTexture(DFRTState.lines);
                    GL.deleteTexture(DFRTState.linesBuffer);
                    GL.deleteTexture(DFRTState.dfTexture);
                    DFRTState = null;
                }

                const lines = GL.createTexture();
                GL.bindTexture(GL.TEXTURE_2D, lines);
                GL.texImage2D(GL.TEXTURE_2D, 0, GL.RGBA32F, linesData.length/4, 1, 0, GL.RGBA, GL.FLOAT, linesData);
                GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_S, GL.CLAMP_TO_EDGE);
                GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_T, GL.CLAMP_TO_EDGE);
                GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.NEAREST);
                GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.NEAREST);

                const linesBuffer = GL.createTexture();
                GL.bindTexture(GL.TEXTURE_2D, linesBuffer);
                GL.texImage2D(GL.TEXTURE_2D, 0, GL.RGBA32F, linesBufferData.length/4, 1, 0, GL.RGBA, GL.FLOAT, linesBufferData);
                GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_S, GL.CLAMP_TO_EDGE);
                GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_T, GL.CLAMP_TO_EDGE);
                GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.NEAREST);
                GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.NEAREST);

                const dfTexture = GL.createTexture();
                GL.bindTexture(GL.TEXTURE_2D, dfTexture);
                GL.texImage2D(GL.TEXTURE_2D, 0, GL.R32UI, textureRes, textureRes, 0, GL.RED_INTEGER, GL.UNSIGNED_INT, dfTextureData);
                GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_S, GL.CLAMP_TO_EDGE);
                GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_T, GL.CLAMP_TO_EDGE);
                GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.NEAREST);
                GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.NEAREST);

                DFRTState = {
                    dfTexture: dfTexture,
                    linesBuffer: linesBuffer,
                    lines: lines,
                    numInputLines: linesData.length/4,
                    params: [textureRes, 0, 0, 0],
                };

                self.redraw();
            };

            // Set an initial state of dummy data, max distance no line counts in both
            // little and big endian..
            setDFRTState(1,
                         new Uint32Array([0xff0000ff]),
                         new Float32Array([0, 0, 0, 0]),
                         new Float32Array([0, 0, 0, 0]));

            worker.addEventListener('message', function(event)
            {
                const data = event.data;
                if(data.err != null)
                {
                    var msg = `Failed to render data!`;
                    console.log(msg);
                    debugger;
                    alert(msg);
                    throw new Error(msg);
                    return;
                }

                console.log(`Time taken: ${data.time}ms`);

                setDFRTState(data.res,
                             data.df,
                             data.linesBuffer,
                             data.lines);

            });

            this.updateDFRTState = ()=>
            {
                worker.postMessage({res: self.dfRes, linesPath: self.linesPath});
            };
            
            this.updateDFRTState();

            this.resourceLoaded = _RESOURCES.then(()=>
            {
                // Compile shaders
                const drawFullScreenUvsVert = createShader(GL, _RESOURCES.DRAW_FULL_SCREEN_UVS_VERT_SRC, GL.VERTEX_SHADER);
                const v1TracingTestCompositeFrag = createShader(GL, _RESOURCES.V1_TRACING_TEST_COMPOSITE_FRAG_SRC, GL.FRAGMENT_SHADER);
                const v1TracingTestNumIntersectionsFrag = createShader(GL, _RESOURCES.V1_TRACING_TEST_NUM_INTERSECTIONS_FRAG_SRC, GL.FRAGMENT_SHADER);
                const v1TracingTestNumIterationsFrag = createShader(GL, _RESOURCES.V1_TRACING_TEST_NUM_ITERATIONS_FRAG_SRC, GL.FRAGMENT_SHADER);
                const v1TracingTestVisibilityFrag = createShader(GL, _RESOURCES.V1_TRACING_TEST_VISIBILITY_FRAG_SRC, GL.FRAGMENT_SHADER);
                const v1TracingTestPointLightFrag = createShader(GL, _RESOURCES.V1_TRACING_TEST_POINTLIGHT_FRAG_SRC, GL.FRAGMENT_SHADER);
                const drawLinesVert = createShader(GL, _RESOURCES.DRAW_LINES_VERT_SRC, GL.VERTEX_SHADER);
                const v1VisDfDistFrag = createShader(GL, _RESOURCES.V1_VIS_DF_DIST_FRAG_SRC, GL.FRAGMENT_SHADER);
                const v1VisDfNumLinesFrag = createShader(GL, _RESOURCES.V1_VIS_DF_NUMLINES_FRAG_SRC, GL.FRAGMENT_SHADER);
                const v1VisDfCompositeFrag = createShader(GL, _RESOURCES.V1_VIS_DF_COMPOSITE_FRAG_SRC, GL.FRAGMENT_SHADER);
                const constColFrag = createShader(GL, _RESOURCES.CONST_COL_FRAG_SRC, GL.FRAGMENT_SHADER);


                const v1TracingTestLineCompositePipeline = createGraphicsProgram(GL, drawFullScreenUvsVert, v1TracingTestCompositeFrag);
                const v1TracingTestNumIntersectionsPipeline = createGraphicsProgram(GL, drawFullScreenUvsVert, v1TracingTestNumIntersectionsFrag);
                const v1TracingTestNumIterationsPipeline = createGraphicsProgram(GL, drawFullScreenUvsVert, v1TracingTestNumIterationsFrag);
                const v1TracingTestVisibilityPipeline = createGraphicsProgram(GL, drawFullScreenUvsVert, v1TracingTestVisibilityFrag);
                const v1TracingTestPointLightPipeline = createGraphicsProgram(GL, drawFullScreenUvsVert, v1TracingTestPointLightFrag);
                const v1VisDfDistPipeline = createGraphicsProgram(GL, drawFullScreenUvsVert, v1VisDfDistFrag);
                const v1VisDfNumLinesPipeline = createGraphicsProgram(GL, drawFullScreenUvsVert, v1VisDfNumLinesFrag);
                const v1VisDfCompositePipeline = createGraphicsProgram(GL, drawFullScreenUvsVert, v1VisDfCompositeFrag);
                const drawLinesPipeline = createGraphicsProgram(GL, drawLinesVert, constColFrag);


                [v1TracingTestLineCompositePipeline,
                 v1TracingTestNumIntersectionsPipeline,
                 v1TracingTestNumIterationsPipeline,
                 v1TracingTestVisibilityPipeline,
                 v1TracingTestPointLightPipeline].forEach(pipeline=>{
                    pipeline.loc = {
                        targetUV: getUniformLocation(GL, pipeline, "targetUV"),
                        v1HybridParams: getUniformLocation(GL, pipeline, "v1HybridParams"),
                        v1DfTexture: getUniformLocation(GL, pipeline, "v1DfTexture"),
                        v1LinesBuffer: getUniformLocation(GL, pipeline, "v1LinesBuffer")
                    }
                });

                 [v1VisDfDistPipeline,
                 v1VisDfNumLinesPipeline,
                 v1VisDfCompositePipeline].forEach(pipeline=>{
                    pipeline.loc = {
                        v1HybridParams: getUniformLocation(GL, pipeline, "v1HybridParams"),
                        v1DfTexture: getUniformLocation(GL, pipeline, "v1DfTexture")
                    }
                });

                drawLinesPipeline.loc = {
                    "lines": getUniformLocation(GL, drawLinesPipeline, "lines"),
                    "constCol": getUniformLocation(GL, drawLinesPipeline, "constCol")
                };

                deleteShaders(GL,
                              drawFullScreenUvsVert,
                              v1TracingTestCompositeFrag,
                              v1TracingTestNumIntersectionsFrag,
                              v1TracingTestNumIterationsFrag,
                              v1TracingTestVisibilityFrag,
                              v1TracingTestPointLightFrag,
                              v1VisDfDistFrag,
                              v1VisDfNumLinesFrag,
                              v1VisDfCompositeFrag,
                              drawLinesVert,
                              constColFrag
                              );

                const restoreViewportState = ()=>
                {
                    GL.bindFramebuffer(GL.FRAMEBUFFER, null)
                    GL.drawBuffers([GL.BACK])
                    GL.viewport(0, 0, canvas.width, canvas.height);
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

                const redraw = ()=>
                {
                    handleResize();

                    // draw stuff
                    {
                        let pipeline = null;
                        switch(self.visMode)
                        {
                            case 0: { pipeline = v1TracingTestPointLightPipeline; break; }
                            case 1: { pipeline = v1TracingTestVisibilityPipeline; break; }
                            case 2: { pipeline = v1TracingTestNumIntersectionsPipeline; break; }
                            case 3: { pipeline = v1TracingTestNumIterationsPipeline; break; }
                            case 4: { pipeline = v1TracingTestLineCompositePipeline; break; }
                            case 5: { pipeline = v1VisDfDistPipeline; break; }
                            case 6: { pipeline = v1VisDfNumLinesPipeline; break; }
                            default: { pipeline = v1VisDfCompositePipeline; break; }
                        }

                        GL.useProgram(pipeline);

                        GL.activeTexture(GL.TEXTURE0);
                        GL.bindTexture(GL.TEXTURE_2D, DFRTState.dfTexture);
                        GL.uniform1i(pipeline.loc.v1DfTexture, 0);

                        if(pipeline.loc.v1LinesBuffer)
                        {
                            GL.activeTexture(GL.TEXTURE1);
                            GL.bindTexture(GL.TEXTURE_2D, DFRTState.linesBuffer);
                            GL.uniform1i(pipeline.loc.v1LinesBuffer, 1);                            
                        }

                        if(pipeline.loc.targetUV)
                        {
                            GL.uniform2f(pipeline.loc.targetUV,
                                         self.visTargetUV[0],
                                         self.visTargetUV[1]);
                        }
                        
                        GL.uniform4f(pipeline.loc.v1HybridParams,
                                     DFRTState.params[0],
                                     DFRTState.params[1],
                                     DFRTState.params[2],
                                     DFRTState.params[3]);

                        GL.drawArrays(GL.TRIANGLES, 0, 3);
                    }

                    if(self.drawLines)
                    {
                        GL.useProgram(drawLinesPipeline);
                        GL.activeTexture(GL.TEXTURE0);
                        GL.bindTexture(GL.TEXTURE_2D, DFRTState.lines);
                        GL.uniform1i(drawLinesPipeline.loc.lines, 0);
                        GL.uniform4f(drawLinesPipeline.loc.constCol, 1.0, 1.0, 1.0, 1.0);
                        GL.drawArrays(GL.LINES, 0, 2 * DFRTState.numInputLines);
                    }
                };
                canvas.width  = canvas.clientWidth;
                canvas.height = canvas.clientHeight;
                self.visTargetUV = [0.4, 0.6];
                restoreViewportState();
                redraw();

                const handleDragEvent = (event, touch)=>
                {
                    event.preventDefault();
                    const bbox = canvas.getBoundingClientRect();

                    const ref = touch ?
                                [event.touches[0].clientX, event.touches[0].clientY]
                                : [event.clientX, event.clientY]
                                ;

                    let newVisTargetUV = [(ref[0] - bbox.x) / bbox.width,
                                        1.0 - (ref[1] - bbox.y) / bbox.height];

                    self.visTargetUV = newVisTargetUV;
                    redraw();
                };

                const initDrag = event=>{

                   if(event.type == "mousedown")
                   {
                        const onMove = (event)=>{
                            handleDragEvent(event, false);
                        };
                        const onEnd = (event)=>{
                            event.preventDefault();
                            canvas.removeEventListener("mousemove", onMove, false);
                            canvas.removeEventListener("mouseup", onEnd, false);
                        };
                        canvas.addEventListener("mousemove", onMove, false);
                        canvas.addEventListener("mouseup", onEnd, false);
                        onMove(event);
                   }
                   else
                   {
                        const onMove = (event)=>{
                            handleDragEvent(event, true);
                        };
                        const onEnd = (event)=>{
                            event.preventDefault();
                            canvas.removeEventListener("touchmove", onMove, false);
                            canvas.removeEventListener("touchend", onEnd, false);
                        };
                        canvas.addEventListener("touchmove", onMove, false);
                        canvas.addEventListener("touchend", onEnd, false);
                        onMove(event);
                   }
                };
                
                canvas.addEventListener("mousedown", initDrag, false);
                canvas.addEventListener("touchstart", initDrag, false);
                self.redraw = redraw;

            });
        }
    };

    function bindDFRTV1Context(canvas)
    {
        if(canvas.drawCtx == undefined)
        {
            canvas.drawCtx = new DFRTV1CanvasContext(canvas);
        }
        return canvas.drawCtx;
    }
    
    return {
        bindDFRTV1Context: bindDFRTV1Context,
    }

})();
