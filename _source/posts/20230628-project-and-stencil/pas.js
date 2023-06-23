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

// Resources needed for BVH1 demo
const _RESOURCES = new AsyncBarrier()
    .enqueue(loadF32Lines("/res/lines.f32").then((lines)=>{
        // Convert lines into NDC space
        for(let i=0; i<lines.length; ++i) {lines[i] = lines[i] * 2 - 1;}
        return lines;
    }), "DEFAULT_LINES")
    .enqueue(loadCommonShaderSource("draw_full_screen.vert"), "DRAW_FULL_SCREEN_VERT")
    .enqueue(loadCommonShaderSource("draw_full_screen_uvs.vert"), "DRAW_FULL_SCREEN_UVS_VERT")
    .enqueue(loadShaderSource("project_lines.vert"), "PROJECT_LINES_VERT_SRC")
    .enqueue(loadShaderSource("draw_lines.vert"), "DRAW_LINES_VERT_SRC")
    .enqueue(loadShaderSource("const_col.frag"), "CONST_COL_FRAG_SRC")
    .enqueue(loadShaderSource("draw_select_overlay.vert"), "DRAW_SELECT_OVERLAY_VERT_SRC")
    .enqueue(loadShaderSource("draw_select_overlay.frag"), "DRAW_SELECT_OVERLAY_FRAG_SRC")
    ;

class PASCanvasContext
{
    constructor(canvas)
    {
        // https://registry.khronos.org/webgl/specs/latest/1.0/#5.2
        // stencil by default will be off
        const GL = canvas.getContext("webgl2", {"alpha": false, "depth": true, "stencil": true});
        this.canvas = canvas;
        this.valid = !!GL;
        this.redraw = ()=>{};

        if(!this.valid)
        {
            return;
        }

        let self = this;
        const drawSelectOverlayRad = 0.1;
        const drawSelectOverlayRadSq = drawSelectOverlayRad * drawSelectOverlayRad;

        this.resourceLoaded = _RESOURCES.then(()=>{

            // Compile shaders
            const drawFullScreenVert = createShader(GL, _RESOURCES.DRAW_FULL_SCREEN_VERT, GL.VERTEX_SHADER);
            const projectLinesVert = createShader(GL, _RESOURCES.PROJECT_LINES_VERT_SRC, GL.VERTEX_SHADER);
            const drawLinesVert = createShader(GL, _RESOURCES.DRAW_LINES_VERT_SRC, GL.VERTEX_SHADER);
            const constColFrag = createShader(GL, _RESOURCES.CONST_COL_FRAG_SRC, GL.FRAGMENT_SHADER);
            const drawSelectOverlayVert = createShader(GL, _RESOURCES.DRAW_SELECT_OVERLAY_VERT_SRC, GL.VERTEX_SHADER);
            const drawSelectOverlayFrag = createShader(GL, _RESOURCES.DRAW_SELECT_OVERLAY_FRAG_SRC, GL.FRAGMENT_SHADER);

            const projectLinesPipeline = createGraphicsProgram(GL, projectLinesVert);
            const drawLinesPipeline = createGraphicsProgram(GL, drawLinesVert, constColFrag);
            const drawFullScreenColPipeline = createGraphicsProgram(GL, drawFullScreenVert, constColFrag);
            const drawSelectOverlayPipeline = createGraphicsProgram(GL, drawSelectOverlayVert, drawSelectOverlayFrag);

            projectLinesPipeline.loc = {
                "lines": getUniformLocation(GL, projectLinesPipeline, "lines"),
                "playerPosition": getUniformLocation(GL, projectLinesPipeline, "playerPosition")
            };
            drawLinesPipeline.loc = {
                "lines": getUniformLocation(GL, drawLinesPipeline, "lines"),
                "constCol": getUniformLocation(GL, drawLinesPipeline, "constCol")
            };
            drawFullScreenColPipeline.loc = {
                "constCol": getUniformLocation(GL, drawFullScreenColPipeline, "constCol")
            };
            drawSelectOverlayPipeline.loc = {
                "bbox": getUniformLocation(GL, drawSelectOverlayPipeline, "bbox")
            };

            deleteShaders(GL,
                          drawFullScreenVert,
                          projectLinesVert,
                          drawLinesVert,
                          constColFrag,
                          drawSelectOverlayVert,
                          drawSelectOverlayFrag);

            const linesData = _RESOURCES.DEFAULT_LINES;
            const numLines = linesData.length / 4;
            const numTriangleElements = numLines * 9;
            const linesTexture = GL.createTexture();
            GL.bindTexture(GL.TEXTURE_2D, linesTexture);
            GL.texImage2D(GL.TEXTURE_2D, 0, GL.RGBA32F, numLines, 1, 0, GL.RGBA, GL.FLOAT, linesData);
            GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_S, GL.CLAMP_TO_EDGE);
            GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_T, GL.CLAMP_TO_EDGE);
            GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.NEAREST);
            GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.NEAREST);

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
                GL.clear(GL.COLOR_BUFFER_BIT | GL.DEPTH_BUFFER_BIT | GL.STENCIL_BUFFER_BIT);

                const relevantPlayers = [];
                this.players.forEach(player=>{
                    if(player.enabled)
                    {
                        relevantPlayers.push(player);
                    }
                })

                if(relevantPlayers.length > 0)
                {
                    // All codepaths will start by needing to use the projection pipeline
                    // in a state where depth is ignored and stencil is enabled, with no
                    // writing to colour.
                    GL.useProgram(projectLinesPipeline);
                    GL.activeTexture(GL.TEXTURE0);
                    GL.bindTexture(GL.TEXTURE_2D, linesTexture);
                    GL.uniform1i(projectLinesPipeline.loc.lines, 0);

                    GL.disable(GL.DEPTH_TEST);
                    GL.enable(GL.STENCIL_TEST);
                    GL.colorMask(false, false, false, false);

                    // Combined visibility
                    if(this.displayType == 0)
                    {
                        // Don't enable depth testing / writing
                        GL.stencilMask(0xff);
                        GL.stencilOp(GL.KEEP, GL.KEEP, GL.INCR);

                        for(let i=0; i<relevantPlayers.length; ++i)
                        {
                            // Enable writing to depth on the final player
                            if(i == (relevantPlayers.length - 1))
                            {
                                GL.depthFunc(GL.ALWAYS);
                                GL.enable(GL.DEPTH_TEST);
                            }

                            // Only accept pixels which were previously covered, but also don't
                            // accept pixels a previous triangle may have covered.
                            GL.stencilFunc(GL.EQUAL, i, 0xFF);
                            GL.uniform2f(projectLinesPipeline.loc.playerPosition,
                                         relevantPlayers[i].p[0],
                                         relevantPlayers[i].p[1]);
                            GL.drawArrays(GL.TRIANGLES, 0, numTriangleElements);
                        }

                        GL.disable(GL.STENCIL_TEST);
                        GL.depthFunc(GL.LESS);
                        GL.enable(GL.DEPTH_TEST);
                        GL.colorMask(true, true, true, true);

                        GL.useProgram(drawFullScreenColPipeline);
                        GL.uniform4f(drawFullScreenColPipeline.loc.constCol, 1.0, 1.0, 1.0, 1.0);
                        GL.drawArrays(GL.TRIANGLES, 0, 3);
                    }

                    // Seperated (using the 1bit per player method)
                    else
                    {
                        GL.stencilOp(GL.REPLACE, GL.REPLACE, GL.REPLACE);
                        relevantPlayers.forEach(player=>{
                            const mask = 1 << player.i;
                            GL.stencilFunc(GL.ALWAYS, mask, mask);
                            GL.stencilMask(mask);
                            GL.uniform2f(projectLinesPipeline.loc.playerPosition,
                                         player.p[0],
                                         player.p[1]);
                            GL.drawArrays(GL.TRIANGLES, 0, numTriangleElements);
                        })

                        GL.enable(GL.BLEND);
                        GL.blendFunc(GL.ONE, GL.ONE);
                        GL.stencilOp(GL.KEEP, GL.KEEP, GL.KEEP);
                        GL.stencilMask(0xff);
                        GL.colorMask(true, true, true, true);
                        GL.useProgram(drawFullScreenColPipeline);

                        relevantPlayers.forEach(player=>{
                            const mask = 1 << player.i;
                            GL.stencilFunc(GL.NOTEQUAL, mask, mask);
                            GL.uniform4f(drawFullScreenColPipeline.loc.constCol,
                                         player.c[0],
                                         player.c[1],
                                         player.c[2],
                                         player.c[3]);
                            GL.drawArrays(GL.TRIANGLES, 0, 3);
                        })
                     }

                     GL.disable(GL.STENCIL_TEST);
                     GL.disable(GL.BLEND);
                }

                // Overlap components
                GL.disable(GL.DEPTH_TEST);

                if(this.drawLinesOverlay)
                {
                    GL.useProgram(drawLinesPipeline);
                    GL.activeTexture(GL.TEXTURE0);
                    GL.bindTexture(GL.TEXTURE_2D, linesTexture);
                    GL.uniform1i(drawLinesPipeline.loc.lines, 0);
                    GL.uniform4f(drawLinesPipeline.loc.constCol, 0.3, 0.86, 0.8, 1.0);
                    GL.drawArrays(GL.LINES, 0, 2 * numLines);
                }

                if(this.drawSelectOverlay)
                {
                    GL.enable(GL.BLEND);
                    GL.blendFunc(GL.ONE_MINUS_DST_COLOR, GL.ONE_MINUS_SRC_ALPHA);
                    GL.useProgram(drawSelectOverlayPipeline);
                    relevantPlayers.forEach((player)=>{
                        GL.uniform4f(drawSelectOverlayPipeline.loc.bbox,
                                     player.p[0] - drawSelectOverlayRad,
                                     player.p[1] - drawSelectOverlayRad,
                                     player.p[0] + drawSelectOverlayRad,
                                     player.p[1] + drawSelectOverlayRad);
                        GL.drawArrays(GL.TRIANGLES, 0, 6);
                    });
                    GL.disable(GL.BLEND);
                }
            };

            this.displayType = 0;
            this.drawSelectOverlay = true;
            this.drawLinesOverlay = true;

            this.players = [
                {"enabled": true, "i": 0, "c": [1.0, 0.0, 0.0, 0.0], "p": [-0.704384548584, 0.8338315304911]},
                {"enabled": true, "i": 1, "c": [0.0, 1.0, 0.0, 0.0], "p": [-0.2814942390868, 0.135869236065]},
                {"enabled": true, "i": 2, "c": [0.0, 0.0, 1.0, 0.0], "p": [0.3361222420398, -0.7242188225105]},
                {"enabled": true, "i": 3, "c": [0.7, 0.0, 0.7, 0.0], "p": [0.7372218132636, 0.3643838825913]}
            ];
            
            restoreViewportState();
            redraw();

            const eventPosToNDC = eventPos=>{
                const bbox = canvas.getBoundingClientRect();
                return [((eventPos[0] - bbox.x) / bbox.width) * 2 - 1,
                       (1.0 - (eventPos[1] - bbox.y) / bbox.height) * 2 - 1];
            };

            const handleDragEvent = (event, player, initialMouseNDC, initialP, touch)=>
            {
                event.preventDefault();
                const ref = touch
                            ? [event.touches[0].clientX, event.touches[0].clientY]
                            : [event.clientX, event.clientY]
                            ;
                const ndc = eventPosToNDC(ref);
                player.p = [
                    initialP[0] + (ndc[0] - initialMouseNDC[0]),
                    initialP[1] + (ndc[1] - initialMouseNDC[1])
                ];
                redraw();
            };

            const initDrag = event=>{

                const mouseNDC = eventPosToNDC((event.type == "mousedown")
                                              ? [event.clientX, event.clientY]
                                              : [event.touches[0].clientX, event.touches[0].clientY]);

                let found = null;
                for(let i=0; i<this.players.length; ++i)
                {
                    const player = this.players[i];
                    if(player.enabled)
                    {
                        const dP = [player.p[0] - mouseNDC[0], player.p[1] - mouseNDC[1]];
                        const distSq = (dP[0] * dP[0] + dP[1] * dP[1]);
                        if(distSq <= drawSelectOverlayRadSq)
                        {
                            found = player;
                            break;
                        }
                    }
                }

                // Failed to find a candidate
                if(found === null)
                {
                    return;
                }

                const initialP = [found.p[0], found.p[1]];

               if(event.type == "mousedown")
               {
                    const onMove = (event)=>{
                        handleDragEvent(event, found, mouseNDC, initialP, false);
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
                        handleDragEvent(event, found, mouseNDC, initialP, true);
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


export function bindPasContext(canvas)
{
    if(canvas.drawCtx == undefined)
    {
        canvas.drawCtx = new PASCanvasContext(canvas);
    }
    return canvas.drawCtx;
}
