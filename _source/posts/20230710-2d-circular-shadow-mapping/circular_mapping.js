import {
    AsyncBarrier,
    loadCommonShaderSource,
    loadF32Lines
} from '../../util.js';

import {
    createShader,
    createGraphicsProgram,
    getUniformLocation,
    deleteShaders
} from '../../webgl_util.js';


function loadShaderSource(name)
{
    return fetch("./shaders/compiled/" + name).then(src => src.text());
}


const _LOAD_BVH1 = WebAssembly.instantiateStreaming(fetch("/res/bvh_v1.wasm")).then(o => o.instance.exports);
const _LOAD_SIMPLE_LINES = loadF32Lines("/res/lines_simple0.f32");
const _LOAD_MODERATE_LINES = loadF32Lines("/res/lines_moderate0.f32");
const _LOAD_COMPLEX_LINES = loadF32Lines("/res/lines.f32");


async function asyncBuildBVH(bvh_loader, lines_loader)
{
    const bvh_v1 = await bvh_loader;
    const lines_data = await lines_loader;

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
    const bvhWasmMemory = new Float32Array(bvh_v1.memory.buffer,
                                           bvh_v1.getBvhBuffer(),
                                           numOutputFloats);

    const result = new Float32Array(numOutputFloats);
    result.set(bvhWasmMemory);
    return result;
}


// Resources needed for BVH1 demo
const _RESOURCES = new AsyncBarrier()
    .enqueue(_LOAD_SIMPLE_LINES, "SIMPLE_LINES")
    .enqueue(_LOAD_MODERATE_LINES, "MODERATE_LINES")
    .enqueue(_LOAD_COMPLEX_LINES, "COMPLEX_LINES")
    .enqueue(asyncBuildBVH(_LOAD_BVH1, _LOAD_SIMPLE_LINES), "SIMPLE_LINES_BVH")
    .enqueue(asyncBuildBVH(_LOAD_BVH1, _LOAD_MODERATE_LINES), "MODERATE_LINES_BVH")
    .enqueue(asyncBuildBVH(_LOAD_BVH1, _LOAD_COMPLEX_LINES), "COMPLEX_LINES_BVH")
    .enqueue(WebAssembly.instantiateStreaming(fetch("/res/number_formats.wasm")).then(o => o.instance.exports), "NUMBER_FORMATS")
    .enqueue(loadCommonShaderSource("draw_rect.vert"), "DRAW_RECT_VERT_SRC")
    .enqueue(loadCommonShaderSource("draw_rect_uvs.vert"), "DRAW_RECT_UVS_VERT_SRC")
    .enqueue(loadCommonShaderSource("draw_col.frag"), "DRAW_COL_FRAG_SRC")
    .enqueue(loadCommonShaderSource("const_col.frag"), "CONST_COL_FRAG_SRC")
    .enqueue(loadShaderSource("draw_lines.vert"), "DRAW_LINES_VERT_SRC")
    .enqueue(loadShaderSource("draw_bbox.vert"), "DRAW_BBOX_VERT_SRC")
    .enqueue(loadShaderSource("draw_lights_binary.frag"), "DRAW_LIGHTS_BINARY_FRAG_SRC")
    .enqueue(loadShaderSource("draw_lights_pcf.frag"), "DRAW_LIGHTS_PCF_FRAG_SRC")
    .enqueue(loadShaderSource("draw_lights_bbox.vert"), "DRAW_LIGHTS_BBOX_VERT_SRC")
    .enqueue(loadShaderSource("draw_lights_obbox.vert"), "DRAW_LIGHTS_OBBOX_VERT_SRC")
    .enqueue(loadShaderSource("draw_obbox.vert"), "DRAW_OBBOX_VERT_SRC")
    .enqueue(loadShaderSource("gen_bbox.frag"), "GEN_BBOX_FRAG_SRC")
    .enqueue(loadShaderSource("gen_obbox.frag"), "GEN_OBBOX_FRAG_SRC")
    .enqueue(loadShaderSource("gen_plane_map.frag"), "GEN_PLANE_MAP_FRAG_SRC")
    ;



class TextureFramebuffer
{
    constructor(GL, pixelType, format, type, width, height, wrapS, wrapT)
    {
        this.GL = GL;
        this.width = width;
        this.height = height;
        this.texture = GL.createTexture();
        this.framebuffer = GL.createFramebuffer();

        GL.bindTexture(GL.TEXTURE_2D, this.texture);
        GL.texImage2D(GL.TEXTURE_2D, 0, pixelType, width, height, 0, format, type, null);

        GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_S, wrapS);
        GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_T, wrapT);
        GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.NEAREST);
        GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.NEAREST);

        GL.bindFramebuffer(GL.FRAMEBUFFER, this.framebuffer);
        GL.framebufferTexture2D(GL.FRAMEBUFFER, GL.COLOR_ATTACHMENT0, GL.TEXTURE_2D, this.texture, 0);

        const status = GL.checkFramebufferStatus(GL.FRAMEBUFFER);
        if(status != GL.FRAMEBUFFER_COMPLETE)
        {
            var msg = "Framebuffer marked as incomplete!";
            console.log(msg);
            debugger;
            alert(msg);
            throw new Error(msg);
        }

        GL.bindFramebuffer(GL.FRAMEBUFFER, null);

    }

    bind(f)
    {
        const GL = this.GL;
        GL.viewport(0, 0, this.width, this.height);
        GL.bindFramebuffer(GL.FRAMEBUFFER, this.framebuffer)
        GL.drawBuffers([GL.COLOR_ATTACHMENT0])
        f();
    }

    destroy()
    {
        const GL = this.GL;
        if(this.framebuffer != null)
        {
            GL.deleteFramebuffer(this.framebuffer);
            this.framebuffer = null;
        }
        if(this.texture != null)
        {
            GL.deleteTexture(this.texture);
            this.texture = null;
        }
    }
};

class CircularMappingCanvasContext
{
    constructor(canvas)
    {
        // https://registry.khronos.org/webgl/specs/latest/1.0/#5.2
        // stencil by default will be off
        const GL = canvas.getContext("webgl2", {"alpha": false, "depth": false, "stencil": false});
        // NB: the act of calling "getExtension" activates them, without these calls they simply
        // won't be usable.
        this.hasFloatRenderTargets = GL && GL.getExtension("EXT_color_buffer_float") != null;
        this.hasFloatBlending = GL && GL.getExtension("EXT_float_blend") != null;
        this.canvas = canvas;
        this.valid = GL
                     && this.hasFloatRenderTargets
                     && this.hasFloatBlending
                     ;

        this.redraw = ()=>{};

        if(!this.valid)
        {
            return;
        }

        GL.disable(GL.CULL_FACE);
        GL.disable(GL.STENCIL_TEST);
        GL.disable(GL.DEPTH_TEST);

        const self = this;
        this.resourceLoaded = _RESOURCES.then(()=>
        {

            const drawRectVert = createShader(GL, _RESOURCES.DRAW_RECT_VERT_SRC, GL.VERTEX_SHADER);
            const drawRectUvsVert = createShader(GL, _RESOURCES.DRAW_RECT_UVS_VERT_SRC, GL.VERTEX_SHADER);
            const drawColFrag = createShader(GL, _RESOURCES.DRAW_COL_FRAG_SRC, GL.FRAGMENT_SHADER);
            const constColFrag = createShader(GL, _RESOURCES.CONST_COL_FRAG_SRC, GL.FRAGMENT_SHADER);
            const drawLinesVert = createShader(GL, _RESOURCES.DRAW_LINES_VERT_SRC, GL.VERTEX_SHADER);
            const drawBboxVert = createShader(GL, _RESOURCES.DRAW_BBOX_VERT_SRC, GL.VERTEX_SHADER);
            const drawLightsBinaryFrag = createShader(GL, _RESOURCES.DRAW_LIGHTS_BINARY_FRAG_SRC, GL.FRAGMENT_SHADER);
            const drawLightsPcfFrag = createShader(GL, _RESOURCES.DRAW_LIGHTS_PCF_FRAG_SRC, GL.FRAGMENT_SHADER);
            const drawLightsBboxVert = createShader(GL, _RESOURCES.DRAW_LIGHTS_BBOX_VERT_SRC, GL.VERTEX_SHADER);
            const drawLightsObboxVert = createShader(GL, _RESOURCES.DRAW_LIGHTS_OBBOX_VERT_SRC, GL.VERTEX_SHADER);
            const drawObboxVert = createShader(GL, _RESOURCES.DRAW_OBBOX_VERT_SRC, GL.VERTEX_SHADER);
            const genBboxFrag = createShader(GL, _RESOURCES.GEN_BBOX_FRAG_SRC, GL.FRAGMENT_SHADER);
            const genObboxFrag = createShader(GL, _RESOURCES.GEN_OBBOX_FRAG_SRC, GL.FRAGMENT_SHADER);
            const genPlaneMapFrag = createShader(GL, _RESOURCES.GEN_PLANE_MAP_FRAG_SRC, GL.FRAGMENT_SHADER);

            const drawLinesPipeline = createGraphicsProgram(GL, drawLinesVert, constColFrag);
            const genPlaneMapPipeline = createGraphicsProgram(GL, drawRectUvsVert, genPlaneMapFrag);
            const genBboxPipeline = createGraphicsProgram(GL, drawRectVert, genBboxFrag);
            const genObboxPipeline = createGraphicsProgram(GL, drawRectVert, genObboxFrag);
            const drawLightsBinaryBboxPipeline = createGraphicsProgram(GL, drawLightsBboxVert, drawLightsBinaryFrag);
            const drawLightsBinaryObboxPipeline = createGraphicsProgram(GL, drawLightsObboxVert, drawLightsBinaryFrag);
            const drawLightsPcfBboxPipeline = createGraphicsProgram(GL, drawLightsBboxVert, drawLightsPcfFrag);
            const drawLightsPcfObboxPipeline = createGraphicsProgram(GL, drawLightsObboxVert, drawLightsPcfFrag);
            const drawBboxPipeline = createGraphicsProgram(GL, drawBboxVert, drawColFrag);
            const drawObboxPipeline = createGraphicsProgram(GL, drawObboxVert, drawColFrag);

            drawLinesPipeline.loc = {
                "lines": getUniformLocation(GL, drawLinesPipeline, "lines"),
                "constCol": getUniformLocation(GL, drawLinesPipeline, "constCol")
            };

            genPlaneMapPipeline.loc = {
                "inRectBounds": getUniformLocation(GL, genPlaneMapPipeline, "inRectBounds"),
                "v1LinesBvh": getUniformLocation(GL, genPlaneMapPipeline, "v1LinesBvh"),
                "lightingData": getUniformLocation(GL, genPlaneMapPipeline, "lightingData")
            };

            [genBboxPipeline, genObboxPipeline].forEach(pipeline=>
            {
                pipeline.loc = {
                    "inRectBounds": getUniformLocation(GL, pipeline, "inRectBounds"),
                    "lightPlaneMap": getUniformLocation(GL, pipeline, "lightPlaneMap"),
                    "lightingData": getUniformLocation(GL, pipeline, "lightingData")
                };
            });

            [drawLightsBinaryBboxPipeline, drawLightsBinaryObboxPipeline, drawLightsPcfBboxPipeline, drawLightsPcfObboxPipeline].forEach(pipeline=>
            {
                pipeline.loc = {
                    "invNumLights": getUniformLocation(GL, pipeline, "invNumLights"),
                    "lightPlaneMap": getUniformLocation(GL, pipeline, "lightPlaneMap"),
                    "lightingData": getUniformLocation(GL, pipeline, "lightingData")
                };
            });

            [drawLightsBinaryBboxPipeline, drawLightsPcfBboxPipeline].forEach(pipeline=>
            {
                pipeline.loc.lightBounds = getUniformLocation(GL, pipeline, "lightBBox");
            });

            [drawLightsBinaryObboxPipeline, drawLightsPcfObboxPipeline].forEach(pipeline=>
            {
                pipeline.loc.lightBounds = getUniformLocation(GL, pipeline, "lightOBBox");
            });

            drawBboxPipeline.loc = {
                "lightBounds": getUniformLocation(GL, drawBboxPipeline, "lightBBox")
            };

            drawObboxPipeline.loc = {
                "lightBounds": getUniformLocation(GL, drawObboxPipeline, "lightOBBox")
            };

            deleteShaders(GL,
                          drawRectVert,
                          drawRectUvsVert,
                          drawColFrag,
                          constColFrag,
                          drawLinesVert,
                          drawBboxVert,
                          drawLightsBinaryFrag,
                          drawLightsPcfFrag,
                          drawLightsBboxVert,
                          drawLightsObboxVert,
                          drawObboxVert,
                          genBboxFrag,
                          genObboxFrag,
                          genPlaneMapFrag);



            const r11g11b10 = _RESOURCES.NUMBER_FORMATS.r11g11b10;
            const maxLights = 128;

            const packPointLightData = (position, decayRate, intensity, colour)=>
            {
                const udata = new Uint32Array(4);
                const fdata = new Float32Array(udata.buffer);
                fdata[0] = position[0];
                fdata[1] = position[1];
                fdata[2] = decayRate;
                udata[3] = r11g11b10(colour[0] * intensity, colour[1] * intensity, colour[2] * intensity);
                return udata;
            };

            const packPointLightDataStream = (items)=>
            {
                const udata = new Uint32Array(4 * items.length);
                const fdata = new Float32Array(udata.buffer);
                for(let i=0; i<items.length; ++i)
                {
                    const item = items[i];
                    fdata[4 * i + 0] = item.position[0];
                    fdata[4 * i + 1] = item.position[1];
                    fdata[4 * i + 2] = item.decayRate;
                    const colour = item.colour;
                    const intensity = item.intensity;
                    udata[4 * i + 3] = r11g11b10(colour[0] * intensity, colour[1] * intensity, colour[2] * intensity);
                }
                return udata;
            };

            // Init lights with random values
            const startingLightsVisible = 10;
            const lights = []
            const random01 = Math.random;
            const maxRandIntensity = Math.min(1, 10 / startingLightsVisible);
            for(let i=0; i<maxLights; ++i)
            {
                lights.push({
                    position: [random01() * 0.5 + 0.25, random01() * 0.5 + 0.25],
                    decayRate: 1.0 + random01() * 10,
                    intensity: maxRandIntensity * random01(),
                    colour: [random01(), random01(), random01()]
                });
            }

            // Ensure light #0 is max intensity, so its obvious you can move it
            lights[0].intensity = maxRandIntensity;

            const makeLinesData = (linesData, bvhData)=>
            {
                const numLines = linesData.length / 4;
                const numBvhFloat4 = bvhData.length / 4;
                const numBvhEntries = numBvhFloat4 / 3;

                const bvhTexture = GL.createTexture();
                GL.bindTexture(GL.TEXTURE_2D, bvhTexture);
                GL.texImage2D(GL.TEXTURE_2D, 0, GL.RGBA32F, numBvhFloat4, 1, 0, GL.RGBA, GL.FLOAT, bvhData);
                GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_S, GL.CLAMP_TO_EDGE);
                GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_T, GL.CLAMP_TO_EDGE);
                GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.NEAREST);
                GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.NEAREST);

                const linesTexture = GL.createTexture();
                GL.bindTexture(GL.TEXTURE_2D, linesTexture);
                GL.texImage2D(GL.TEXTURE_2D, 0, GL.RGBA32F, numLines, 1, 0, GL.RGBA, GL.FLOAT, linesData);
                GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_S, GL.CLAMP_TO_EDGE);
                GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_T, GL.CLAMP_TO_EDGE);
                GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.NEAREST);
                GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.NEAREST);

                return {
                    numLines: numLines,
                    numBvhFloat4: numBvhFloat4,
                    numBvhEntries: numBvhEntries,
                    bvhTexture: bvhTexture,
                    linesTexture: linesTexture
                };
            };

            // Bootstrap the various scenes we have set up
            const scenesData = [
                makeLinesData(_RESOURCES.SIMPLE_LINES, _RESOURCES.SIMPLE_LINES_BVH),
                makeLinesData(_RESOURCES.MODERATE_LINES, _RESOURCES.MODERATE_LINES_BVH),
                makeLinesData(_RESOURCES.COMPLEX_LINES, _RESOURCES.COMPLEX_LINES_BVH)
            ];

            const lightDataTexture = GL.createTexture();
            GL.bindTexture(GL.TEXTURE_2D, lightDataTexture);
            GL.texImage2D(GL.TEXTURE_2D, 0, GL.RGBA32UI, maxLights, 1, 0, GL.RGBA_INTEGER, GL.UNSIGNED_INT, packPointLightDataStream(lights));
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

            const concatRanges = (arr)=>
            {
                // Sort by the start value
                arr.sort((x, y) => x[0]-y[0]);
                let j = arr.length - 1;

                // Merge backwards
                for(; j > 0; --j)
                {
                    let current = arr[j];
                    let prev = arr[j-1];
                    if(prev[1] >= current[0])
                    {
                        prev[1] = Math.max(prev[1], current[1]);
                        arr.pop(j);
                    }
                }
            };

            const handleResize = ()=>
            {
                if(   canvas.width  !== canvas.clientWidth
                   || canvas.height !== canvas.clientHeight)
                {
                    canvas.width  = canvas.clientWidth;
                    canvas.height = canvas.clientHeight;
                    return true;
                }

                return false;
            };

            const redraw = ()=>
            {
                self.redrawRequested = false;
                const invalidPlaneMapTexture = (self.currentPlaneMapResolution != self.newPlaneMapResolution);
                const invalidPlaneMap = invalidPlaneMapTexture || (self.currentScene != self.newScene);
                const invalidBounds = (self.currentlyUsingOBbox != self.newUsingOBbox);

                const recalculatePlaneMapRanges = [];
                const recalculateBoundsRanges = [];

                if(invalidPlaneMapTexture)
                {
                    if(self.planeMapFb != null)
                    {
                        self.planeMapFb.destroy();
                        self.planeMapFb = null;
                    }

                    self.planeMapFb = new TextureFramebuffer(
                        GL,
                        GL.RGB10_A2,
                        GL.RGBA,
                        GL.UNSIGNED_INT_2_10_10_10_REV,
                        self.newPlaneMapResolution,
                        maxLights,
                        GL.REPEAT,
                        GL.CLAMP_TO_EDGE
                    );

                    self.currentPlaneMapResolution = self.newPlaneMapResolution;
                }

                if(invalidBounds)
                {
                    if(self.boundsFb != null)
                    {
                        self.boundsFb.destroy();
                        self.boundsFb = null;
                    }

                    self.boundsFb = new TextureFramebuffer(
                        GL,
                        self.newUsingOBbox ? GL.RGBA32UI : GL.RGBA32F,
                        self.newUsingOBbox ? GL.RGBA_INTEGER : GL.RGBA,
                        self.newUsingOBbox ? GL.UNSIGNED_INT : GL.FLOAT,
                        maxLights,
                        1,
                        GL.CLAMP_TO_EDGE,
                        GL.CLAMP_TO_EDGE
                    );

                    self.currentlyUsingOBbox = self.newUsingOBbox;
                }

                if(invalidPlaneMap)
                {
                    self.currentScene = self.newScene;
                    recalculatePlaneMapRanges.push([0, self.currentNumLightsToRender]);
                }
                else if(invalidBounds)
                {
                    recalculateBoundsRanges.push([0, self.currentNumLightsToRender]);
                }
                
                // Figure out which plane maps are invalid and/or need their bounds updated.
                if(self.currentNumLightsToRender != self.newNumLightsToRender)
                {
                    // If we've been told to handle more lights, we'll need to update them.
                    if(self.newNumLightsToRender > self.currentNumLightsToRender)
                    {
                        recalculatePlaneMapRanges.push([self.currentNumLightsToRender, self.newNumLightsToRender]);
                    }
                    self.currentNumLightsToRender = self.newNumLightsToRender;
                }

                // Manually update individual lights values, and enqueue them for update
                if(self.dirtyLights.length > 0)
                {
                    const unique = new Set(self.dirtyLights);
                    // Update the pixel data on a per light basis
                    GL.bindTexture(GL.TEXTURE_2D, lightDataTexture);
                    unique.forEach(index => {
                        const item = lights[index];
                        const data = packPointLightData(item.position, item.decayRate, item.intensity, item.colour);
                        GL.texSubImage2D(GL.TEXTURE_2D, 0, index, 0, 1, 1, GL.RGBA_INTEGER, GL.UNSIGNED_INT, data);
                        recalculatePlaneMapRanges.push([index, index + 1]);
                    });
                    
                    self.dirtyLights = [];
                }

                // Make sure we don't ever have overlapping ranges
                concatRanges(recalculatePlaneMapRanges);
                // Any invalid plane ranges are also going to be invalid bound ranges
                recalculatePlaneMapRanges.forEach(x=>{recalculateBoundsRanges.push(x);});
                concatRanges(recalculateBoundsRanges);

                if(recalculatePlaneMapRanges.length > 0)
                {
                    GL.disable(GL.BLEND);
                    self.planeMapFb.bind(()=>
                    {
                        GL.useProgram(genPlaneMapPipeline);

                        GL.activeTexture(GL.TEXTURE0);
                        GL.bindTexture(GL.TEXTURE_2D, scenesData[self.currentScene].bvhTexture);
                        GL.uniform1i(genPlaneMapPipeline.loc.v1LinesBvh, 0);

                        GL.activeTexture(GL.TEXTURE1);
                        GL.bindTexture(GL.TEXTURE_2D, lightDataTexture);
                        GL.uniform1i(genPlaneMapPipeline.loc.lightingData, 1);

                        const invHeight = 1.0 / self.planeMapFb.height;
                        
                        recalculatePlaneMapRanges.forEach(range=>
                        {
                            GL.uniform4f(genPlaneMapPipeline.loc.inRectBounds,
                                         0.0,
                                         range[0] * invHeight,
                                         1.0,
                                         range[1] * invHeight);
                            GL.drawArrays(GL.TRIANGLES, 0, 6);
                        });
                    });
                }

                if(recalculateBoundsRanges.length > 0)
                {
                    GL.disable(GL.BLEND);
                    self.boundsFb.bind(()=>
                    {

                        const pipeline = self.newUsingOBbox ? genObboxPipeline : genBboxPipeline;
                        
                        GL.useProgram(pipeline);

                        GL.activeTexture(GL.TEXTURE0);
                        GL.bindTexture(GL.TEXTURE_2D, self.planeMapFb.texture);
                        GL.uniform1i(pipeline.loc.lightPlaneMap, 0);

                        GL.activeTexture(GL.TEXTURE1);
                        GL.bindTexture(GL.TEXTURE_2D, lightDataTexture);
                        GL.uniform1i(pipeline.loc.lightingData, 1);

                        const invWidth = 1.0 / self.boundsFb.width;

                        recalculateBoundsRanges.forEach(range=>
                        {
                            GL.uniform4f(pipeline.loc.inRectBounds,
                                         range[0] * invWidth,
                                         0.0,
                                         range[1] * invWidth,
                                         1.0);
                            GL.drawArrays(GL.TRIANGLES, 0, 6);
                        });
                    });
                }

                if(handleResize()
                    || (recalculatePlaneMapRanges.length > 0)
                    || (recalculateBoundsRanges.length > 0))
                {
                    restoreViewportState();
                }

                // Render lights
                GL.clear(GL.COLOR_BUFFER_BIT);
                GL.enable(GL.BLEND);
                GL.blendEquation(GL.FUNC_ADD);
                GL.blendFunc(GL.ONE, GL.ONE);

                {
                    const pipeline = self.currentlyUsingOBbox
                    ? (self.usePCF ? drawLightsPcfObboxPipeline : drawLightsBinaryObboxPipeline)
                    : (self.usePCF ? drawLightsPcfBboxPipeline : drawLightsBinaryBboxPipeline)
                    ;

                    GL.useProgram(pipeline);

                    GL.activeTexture(GL.TEXTURE0);
                    GL.bindTexture(GL.TEXTURE_2D, self.planeMapFb.texture);
                    GL.uniform1i(pipeline.loc.lightPlaneMap, 0);

                    GL.activeTexture(GL.TEXTURE1);
                    GL.bindTexture(GL.TEXTURE_2D, lightDataTexture);
                    GL.uniform1i(pipeline.loc.lightingData, 1);

                    GL.activeTexture(GL.TEXTURE2);
                    GL.bindTexture(GL.TEXTURE_2D, self.boundsFb.texture);
                    GL.uniform1i(pipeline.loc.lightBounds, 2);

                    GL.uniform1f(pipeline.loc.invNumLights, 1.0 / maxLights);
                    GL.drawArrays(GL.TRIANGLES, 0, 6 * self.currentNumLightsToRender);
                }

                if(self.drawLines)
                {
                    GL.blendFunc(GL.ONE_MINUS_DST_COLOR, GL.ONE_MINUS_SRC_ALPHA);
                    GL.useProgram(drawLinesPipeline);
                    GL.activeTexture(GL.TEXTURE0);
                    GL.bindTexture(GL.TEXTURE_2D, scenesData[self.currentScene].linesTexture);
                    GL.uniform1i(drawLinesPipeline.loc.lines, 0);
                    GL.uniform4f(drawLinesPipeline.loc.constCol, 1.0, 1.0, 1.0, 1.0);
                    GL.drawArrays(GL.LINES, 0, 2 * scenesData[self.currentScene].numLines);
                }

                if(self.drawBounds)
                {
                    const pipeline = self.currentlyUsingOBbox
                        ? drawObboxPipeline
                        : drawBboxPipeline
                    ;
                    GL.enable(GL.BLEND);
                    GL.blendFunc(GL.ONE_MINUS_DST_COLOR, GL.ONE_MINUS_SRC_ALPHA);
                    GL.useProgram(pipeline);
                    GL.activeTexture(GL.TEXTURE0);
                    GL.bindTexture(GL.TEXTURE_2D, self.boundsFb.texture);
                    GL.uniform1i(pipeline.loc.lightingData, 0);
                    GL.drawArrays(GL.LINES, 0, 8 * self.currentNumLightsToRender);
                }
            };

            const redrawRequest = ()=>
            {
                if(!self.redrawRequested)
                {
                    self.redrawRequested = true;
                    window.requestAnimationFrame(redraw);
                }
            };

            self.maxLights = maxLights;
            self.lights = lights;
            self.dirtyLights = [];
            self.currentNumLightsToRender = startingLightsVisible;
            self.newNumLightsToRender = startingLightsVisible;
            self.currentPlaneMapResolution = 0;
            self.newPlaneMapResolution = 512;
            self.planeMapFb = null;
            self.boundsFb = null;
            self.currentScene = -1;
            self.newScene = 0;
            self.currentlyUsingOBbox = false;
            self.newUsingOBbox = true;
            self.usePCF = true;
            self.drawLines = true;
            self.drawBounds = false;
            self.drawRequested = false;
            self.drawing = false;
            self.redrawRequested = false;
            self.redraw = redrawRequest;

            redraw();
        });
    }
};


export function bindCircularMappingContext(canvas)
{
    if(canvas.drawCtx == undefined)
    {
        canvas.drawCtx = new CircularMappingCanvasContext(canvas);
    }
    return canvas.drawCtx;
}
