import {
    AsyncBarrier,
    loadCommonShaderSource,
    createShader,
    createGraphicsProgram,
    getUniformLocation,
    deleteShaders,
    loadF32Lines
} from '../../util.js';



function loadShaderSource(name)
{
    return fetch("./shaders/compiled/" + name).then(src => src.text());
}


const _BVH1_DATA = new AsyncBarrier()
    .enqueue(loadF32Lines("/res/lines.f32"), "DEFAULT_LINES")
    .enqueue(WebAssembly.instantiateStreaming(fetch("/res/bvh_v1.wasm")).then(o => o.instance.exports), "BVH_V1")
    ;

const _GLOBAL_SHADERS_DATA = new AsyncBarrier()
    .enqueue(loadCommonShaderSource("draw_full_screen_uvs.vert"), "DRAW_FULL_SCREEN_UVS_VERT")
    ;

// Resources needed for BVH1 demo
const _RESOURCES = new AsyncBarrier()
    .enqueue(_BVH1_DATA.selfBarrier(), null, ["DEFAULT_LINES", "BVH_V1"])
    .enqueue(_GLOBAL_SHADERS_DATA.selfBarrier(), null, ["DRAW_FULL_SCREEN_UVS_VERT"])
    .enqueue(loadShaderSource("v1_draw_bvh.frag"), "V1_DRAW_BVH_FRAG_SRC")
    .enqueue(loadShaderSource("v1_draw_bvh_all.vert"), "V1_DRAW_BVH_ALL_VERT_SRC")
    .enqueue(loadShaderSource("v1_draw_bvh_bbox.vert"), "V1_DRAW_BVH_BBOX_VERT_SRC")
    .enqueue(loadShaderSource("v1_draw_bvh_lines.vert"), "V1_DRAW_BVH_LINES_VERT_SRC")
    .enqueue(loadShaderSource("v1_tracing_test_composite.frag"), "V1_TRACING_TEST_COMPOSITE_FRAG_SRC")
    .enqueue(loadShaderSource("v1_tracing_test_line_id.frag"), "V1_TRACING_TEST_LINE_ID_FRAG_SRC")
    .enqueue(loadShaderSource("v1_tracing_test_num_intersections.frag"), "V1_TRACING_TEST_NUM_INTERSECTIONS_FRAG_SRC")
    .enqueue(loadShaderSource("v1_tracing_test_num_visits.frag"), "V1_TRACING_TEST_NUM_VISITS_FRAG_SRC")
    .enqueue(loadShaderSource("v1_tracing_test_visibility.frag"), "V1_TRACING_TEST_VISIBILITY_FRAG_SRC")
    .enqueue(loadShaderSource("v1_tracing_test_pointlight.frag"), "V1_TRACING_TEST_POINTLIGHT_FRAG_SRC")
    ;


// Generates a BVH give an input amount of lines, the memory
// returned back is stored directly in the BVH wasm module
// as such, subsequent calls are liable to invalidate the
// data.
//
// The input `lines_data` is expected to be a flat array of floats
// e.g:
// [
//     A_x0, A_y0, A_x1, A_y1,
//     B_x0, B_y0, B_x1, B_y1,
//     C_x0, C_y0, C_x1, C_y1,
//     D_x0, D_y0, D_x1, D_y1,
//     ...
// ]
//
export function generateBVH(lines_data)
{
    const bvh_v1 = _BVH1_DATA.BVH_V1; 
    const numLines = lines_data.length / 4;
    if(!bvh_v1.allocateLines(numLines))
    {
        var msg = `Failed to allocate lines (num: ${numLines}).`;
        console.log(msg);
        debugger;
        alert(msg);
        throw new Error(msg);
    }

    // Upload lines to the modules memory
    (new Float32Array(bvh_v1.memory.buffer,
                      bvh_v1.getLinesBuffer(),
                      lines_data.length)).set(lines_data);


    const numEntries = bvh_v1.buildBvh(numLines);

    if(!numEntries)
    {
        var msg = `Failed to build BVH!`;
        console.log(msg);
        debugger;
        alert(msg);
        throw new Error(msg);
    }

    const numOutputFloats = numEntries * 12; // 12 float stride per bvh node
    return new Float32Array(bvh_v1.memory.buffer,
                            bvh_v1.getBvhBuffer(),
                            numOutputFloats);
}

class BvhV1CanvasContext
{
    constructor(canvas)
    {
        // https://registry.khronos.org/webgl/specs/latest/1.0/#5.2
        const GL = canvas.getContext("webgl2", {"alpha": false, "depth": false});
        this.canvas = canvas;
        this.valid = !!GL;
        this.redraw = ()=>{};

        if(!this.valid)
        {
            return;
        }

        let self = this;
        this.resourceLoaded = _RESOURCES.then(()=>{

            // Compile shaders
            const drawFullScreenUvsVert = createShader(GL, _RESOURCES.DRAW_FULL_SCREEN_UVS_VERT, GL.VERTEX_SHADER);
            const v1DrawBvhFrag = createShader(GL, _RESOURCES.V1_DRAW_BVH_FRAG_SRC, GL.FRAGMENT_SHADER);
            const v1DrawBvhAllVert = createShader(GL, _RESOURCES.V1_DRAW_BVH_ALL_VERT_SRC, GL.VERTEX_SHADER);
            const v1DrawBvhBboxVert = createShader(GL, _RESOURCES.V1_DRAW_BVH_BBOX_VERT_SRC, GL.VERTEX_SHADER);
            const v1DrawBvhLinesVert = createShader(GL, _RESOURCES.V1_DRAW_BVH_LINES_VERT_SRC, GL.VERTEX_SHADER);
            const v1TracingTestCompositeFrag = createShader(GL, _RESOURCES.V1_TRACING_TEST_COMPOSITE_FRAG_SRC, GL.FRAGMENT_SHADER);
            const v1TracingTestLineIdFrag = createShader(GL, _RESOURCES.V1_TRACING_TEST_LINE_ID_FRAG_SRC, GL.FRAGMENT_SHADER);
            const v1TracingTestNumIntersectionsFrag = createShader(GL, _RESOURCES.V1_TRACING_TEST_NUM_INTERSECTIONS_FRAG_SRC, GL.FRAGMENT_SHADER);
            const v1TracingTestNumVisitsFrag = createShader(GL, _RESOURCES.V1_TRACING_TEST_NUM_VISITS_FRAG_SRC, GL.FRAGMENT_SHADER);
            const v1TracingTestVisibilityFrag = createShader(GL, _RESOURCES.V1_TRACING_TEST_VISIBILITY_FRAG_SRC, GL.FRAGMENT_SHADER);
            const v1TracingTestPointLightFrag = createShader(GL, _RESOURCES.V1_TRACING_TEST_POINTLIGHT_FRAG_SRC, GL.FRAGMENT_SHADER);

            const v1DrawBvhAllPipeline = createGraphicsProgram(GL, v1DrawBvhAllVert, v1DrawBvhFrag);
            const v1DrawBvhBboxPipeline = createGraphicsProgram(GL, v1DrawBvhBboxVert, v1DrawBvhFrag);
            const v1DrawBvhLinesPipeline = createGraphicsProgram(GL, v1DrawBvhLinesVert, v1DrawBvhFrag);

            const v1TracingTestLineCompositePipeline = createGraphicsProgram(GL, drawFullScreenUvsVert, v1TracingTestCompositeFrag);
            const v1TracingTestLineIdPipeline = createGraphicsProgram(GL, drawFullScreenUvsVert, v1TracingTestLineIdFrag);
            const v1TracingTestNumIntersectionsPipeline = createGraphicsProgram(GL, drawFullScreenUvsVert, v1TracingTestNumIntersectionsFrag);
            const v1TracingTestNumVisitsPipeline = createGraphicsProgram(GL, drawFullScreenUvsVert, v1TracingTestNumVisitsFrag);
            const v1TracingTestVisibilityPipeline = createGraphicsProgram(GL, drawFullScreenUvsVert, v1TracingTestVisibilityFrag);
            const v1TracingTestPointLightPipeline = createGraphicsProgram(GL, drawFullScreenUvsVert, v1TracingTestPointLightFrag);

            [v1DrawBvhAllPipeline,
             v1DrawBvhBboxPipeline,
             v1DrawBvhLinesPipeline,
             v1TracingTestLineCompositePipeline,
             v1TracingTestLineIdPipeline,
             v1TracingTestNumIntersectionsPipeline,
             v1TracingTestNumVisitsPipeline,
             v1TracingTestVisibilityPipeline,
             v1TracingTestPointLightPipeline].forEach(pipeline=>{pipeline.loc = {};});

            [v1DrawBvhAllPipeline,
             v1DrawBvhBboxPipeline,
             v1DrawBvhLinesPipeline,
             v1TracingTestLineCompositePipeline,
             v1TracingTestLineIdPipeline,
             v1TracingTestNumIntersectionsPipeline,
             v1TracingTestNumVisitsPipeline,
             v1TracingTestVisibilityPipeline,
             v1TracingTestPointLightPipeline].forEach(pipeline=>{
                pipeline.loc.v1LinesBvh = getUniformLocation(GL, pipeline, "v1LinesBvh");
            });

             [v1TracingTestLineCompositePipeline,
              v1TracingTestLineIdPipeline,
              v1TracingTestNumIntersectionsPipeline,
              v1TracingTestNumVisitsPipeline,
              v1TracingTestVisibilityPipeline,
              v1TracingTestPointLightPipeline].forEach(pipeline=>{
                pipeline.loc.targetUV = getUniformLocation(GL, pipeline, "targetUV");
            });

            deleteShaders(GL,
                          drawFullScreenUvsVert,
                          v1DrawBvhFrag,
                          v1DrawBvhAllVert,
                          v1DrawBvhBboxVert,
                          v1DrawBvhLinesVert,
                          v1TracingTestCompositeFrag,
                          v1TracingTestLineIdFrag,
                          v1TracingTestNumIntersectionsFrag,
                          v1TracingTestNumVisitsFrag,
                          v1TracingTestVisibilityFrag,
                          v1TracingTestPointLightFrag);

            const updateGpuBvhTexture = lines_data => {

                if(self.bvhData != undefined)
                {
                    if(self.bvhData.texture != null)
                    {
                        GL.deleteTexture(self.bvhData.texture);
                        self.bvhData.texture = null;
                    }
                }

                // Fallback to an invalid line just to ensure a texture
                // can be created.
                if((lines_data == undefined) || (!lines_data.length))
                {
                    lines_data = new Float32Array([Infinity, Infinity, Infinity, Infinity]);
                }
                const numLines = lines_data.length / 4;
                const bvh = generateBVH(lines_data);
                const numFloat4 = bvh.length / 4;
                const numEntries = numFloat4 / 3;

                const texture = GL.createTexture();
                GL.bindTexture(GL.TEXTURE_2D, texture);

                GL.texImage2D(GL.TEXTURE_2D, 0, GL.RGBA32F, numFloat4, 1, 0, GL.RGBA, GL.FLOAT, bvh);
                GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_S, GL.CLAMP_TO_EDGE);
                GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_T, GL.CLAMP_TO_EDGE);
                GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.NEAREST);
                GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.NEAREST);

                self.bvhData = {
                    numLines: numLines,
                    numFloat4: numFloat4,
                    numEntries: numEntries,
                    texture: texture
                };
            };

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
                // Enable if we make this tick every frame
                // if(!isElementVisible(canvas)) { return; }

                handleResize();

                // draw stuff
                {
                    let pipeline = null;

                    switch(self.rayVisMode)
                    {
                        case 0: { pipeline = v1TracingTestPointLightPipeline; break; }
                        case 1: { pipeline = v1TracingTestVisibilityPipeline; break; }
                        case 2: { pipeline = v1TracingTestNumIntersectionsPipeline; break; }
                        case 3: { pipeline = v1TracingTestNumVisitsPipeline; break; }
                        case 4: { pipeline = v1TracingTestLineCompositePipeline; break; }
                        default: { pipeline = v1TracingTestLineIdPipeline; break; }
                    }

                    GL.useProgram(pipeline);
                    GL.activeTexture(GL.TEXTURE0);
                    GL.bindTexture(GL.TEXTURE_2D, self.bvhData.texture);
                    GL.uniform1i(pipeline.loc.v1LinesBvh, 0);
                    GL.uniform2f(pipeline.loc.targetUV,
                                 self.visTargetUV[0],
                                 self.visTargetUV[1]);
                    GL.drawArrays(GL.TRIANGLES, 0, 3);
                }

                // overlay thingy
                if(self.drawBvhOverlayMode > 0)
                {
                    let pipeline = null;
                    switch(self.drawBvhOverlayMode)
                    {
                        case 1: { pipeline = v1DrawBvhLinesPipeline; break; }
                        case 2: { pipeline = v1DrawBvhBboxPipeline; break; }
                        default: { pipeline = v1DrawBvhAllPipeline; break; }
                    }
                    GL.useProgram(pipeline);
                    GL.activeTexture(GL.TEXTURE0);
                    GL.bindTexture(GL.TEXTURE_2D, self.bvhData.texture);
                    GL.uniform1i(pipeline.loc.v1LinesBvh, 0);
                    GL.drawArrays(GL.LINES, 0, 16 * self.bvhData.numEntries);
                }
            };

            self.drawBvhOverlayMode = 1; // lines
            self.rayVisMode = 0; // pointlight
            self.visTargetUV = [0.4, 0.6];
            self.allowWallClipping = true;
            canvas.width  = canvas.clientWidth;
            canvas.height = canvas.clientHeight;

            const bvh_v1 = _RESOURCES.BVH_V1;
            const numCpuTraceDataEntries = (
                1       // hitLineId            [0]
                + 1     // hitDistSq            [1]
                + 4     // line                 [2]
                + 1     // hitLineInterval      [6]
                + 2     // dUV                  [7]
                //                              [9]
            );

            restoreViewportState();
            updateGpuBvhTexture(_RESOURCES.DEFAULT_LINES);
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

                if(!self.allowWallClipping)
                {

                    if(bvh_v1.traceBvh(self.visTargetUV[0],
                                       self.visTargetUV[1],
                                       newVisTargetUV[0] - self.visTargetUV[0],
                                       newVisTargetUV[1] - self.visTargetUV[1],
                                       1.0,
                                       0))
                    {
                        // Would be nice to go as far forward rather than not move at all.
                        newVisTargetUV = self.visTargetUV;
                    }
                }

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
            self.updateGpuBvhTexture = updateGpuBvhTexture;
            self.redraw = redraw;
        });
    }
};


export function getDefaultLines()
{
    return _BVH1_DATA.DEFAULT_LINES;
}


export function bindBvh1Context(canvas)
{
    if(canvas.drawCtx == undefined)
    {
        canvas.drawCtx = new BvhV1CanvasContext(canvas);
    }
    return canvas.drawCtx;
}


export function onResourcesLoaded(f)
{
    return _RESOURCES.then(f);
}


export function onBvh1DataLoaded(f)
{
    return _BVH1_DATA.then(f);
}
