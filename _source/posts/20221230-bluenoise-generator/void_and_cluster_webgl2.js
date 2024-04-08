import {
    AsyncBarrier,
    loadCommonShaderSource,
    addDPIResizeWatcher
} from '../../util.js';

import {
    createShader,
    createGraphicsProgram,
    getUniformLocation,
    createDummyVAO,
    deleteShaders
} from '../../webgl_util.js';


function loadShaderSource(name)
{
    return fetch("./shaders/compiled/" + name).then(src => src.text());
}


// Stripped back frame buffer object, using a texture (not a render buffer),
// a fixed size and repeating nearest neighbour interpolation.
class TextureFramebuffer
{
    // Will always be:
    //  GL.RG32F, GL.RG, GL.FLOAT, width, height
    constructor(GL, pixelType, format, type, width, height)
    {
        this.GL = GL;
        this.width = width;
        this.height = height;
        this.texture = GL.createTexture();
        this.framebuffer = GL.createFramebuffer();

        GL.bindTexture(GL.TEXTURE_2D, this.texture);
        GL.texImage2D(GL.TEXTURE_2D, 0, pixelType, width, height, 0, format, type, null);

        GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_S, GL.REPEAT);
        GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_T, GL.REPEAT);
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


function randomSeed()
{
    return Math.floor(Math.random() * 0x7fffffff);
}


const _SHADERS = new AsyncBarrier()
    .enqueue(loadCommonShaderSource("draw_full_screen.vert"), "DRAW_FULL_SCREEN_VS_SRC")
    .enqueue(loadCommonShaderSource("draw_full_screen_uvs.vert"), "DRAW_FULL_SCREEN_WITH_UVS_VS_SRC")
    .enqueue(loadShaderSource("void_and_cluster_init.frag"), "VOID_AND_CLUSTER_INIT_FS_SRC")
    .enqueue(loadShaderSource("void_and_cluster_reduce_init.frag"), "VOID_AND_CLUSTER_REDUCE_INIT_FS_SRC")
    .enqueue(loadShaderSource("void_and_cluster_reduce_iter.frag"), "VOID_AND_CLUSTER_REDUCE_ITER_FS_SRC")
    .enqueue(loadShaderSource("void_and_cluster_update.frag"), "VOID_AND_CLUSTER_UPDATE_FS_SRC")
    .enqueue(loadShaderSource("void_and_cluster_partial_update.vert"), "VOID_AND_CLUSTER_PARTIAL_UPDATE_VS_SRC")
    .enqueue(loadShaderSource("vis_bluenoise_tiled.frag"), "VIS_BLUENOISE_TILED_FS_SRC")
    .enqueue(loadShaderSource("vis_bluenoise_scaled.frag"), "VIS_BLUENOISE_SCALED_FS_SRC")
    .enqueue(loadShaderSource("export_first_channel.frag"), "EXPORT_FIRST_CHANNEL_FS_SRC")
    .enqueue(loadShaderSource("bc4_compress.frag"), "BC4_COMPRESS_FS_SRC")
    ;


class GraphicsPSOs
{
    constructor(GL)
    {
        const drawFullScreenVS = createShader(GL, _SHADERS.DRAW_FULL_SCREEN_VS_SRC, GL.VERTEX_SHADER);
        const voidAndClusterInitFS = createShader(GL, _SHADERS.VOID_AND_CLUSTER_INIT_FS_SRC, GL.FRAGMENT_SHADER);
        const voidAndClusterReduceInitFS = createShader(GL, _SHADERS.VOID_AND_CLUSTER_REDUCE_INIT_FS_SRC, GL.FRAGMENT_SHADER);
        const voidAndClusterReduceIterFS = createShader(GL, _SHADERS.VOID_AND_CLUSTER_REDUCE_ITER_FS_SRC, GL.FRAGMENT_SHADER);
        const voidAndClusterUpdateFS = createShader(GL, _SHADERS.VOID_AND_CLUSTER_UPDATE_FS_SRC, GL.FRAGMENT_SHADER);
        const voidAndClusterPartialUpdateVS = createShader(GL, _SHADERS.VOID_AND_CLUSTER_PARTIAL_UPDATE_VS_SRC, GL.VERTEX_SHADER);
        const visBluenoiseTiledFS = createShader(GL, _SHADERS.VIS_BLUENOISE_TILED_FS_SRC, GL.FRAGMENT_SHADER);
        const drawFullScreenWithUvsVS = createShader(GL, _SHADERS.DRAW_FULL_SCREEN_WITH_UVS_VS_SRC, GL.VERTEX_SHADER);
        const visBluenoiseScaledFS = createShader(GL, _SHADERS.VIS_BLUENOISE_SCALED_FS_SRC, GL.FRAGMENT_SHADER);
        const exportFirstChannelFS = createShader(GL, _SHADERS.EXPORT_FIRST_CHANNEL_FS_SRC, GL.FRAGMENT_SHADER);
        const bc4CompressFS = createShader(GL, _SHADERS.BC4_COMPRESS_FS_SRC, GL.FRAGMENT_SHADER);

        this.dummyVao = createDummyVAO(GL);
        this.voidAndClusterInit = createGraphicsProgram(GL, drawFullScreenVS, voidAndClusterInitFS);
        this.voidAndClusterReduceInit = createGraphicsProgram(GL, drawFullScreenVS, voidAndClusterReduceInitFS);
        this.voidAndClusterReduceIter = createGraphicsProgram(GL, drawFullScreenVS, voidAndClusterReduceIterFS);
        this.voidAndClusterFullUpdate = createGraphicsProgram(GL, drawFullScreenVS, voidAndClusterUpdateFS);
        this.voidAndClusterPartialUpdate = createGraphicsProgram(GL, voidAndClusterPartialUpdateVS, voidAndClusterUpdateFS);
        this.visBluenoiseTiled = createGraphicsProgram(GL, drawFullScreenVS, visBluenoiseTiledFS);
        this.visBluenoiseScaled = createGraphicsProgram(GL, drawFullScreenWithUvsVS, visBluenoiseScaledFS);
        this.exportFirstChannel = createGraphicsProgram(GL, drawFullScreenVS, exportFirstChannelFS);
        this.bc4Compress = createGraphicsProgram(GL, drawFullScreenVS, bc4CompressFS);

        deleteShaders(GL,
                      drawFullScreenVS,
                      voidAndClusterInitFS,
                      voidAndClusterReduceInitFS,
                      voidAndClusterReduceIterFS,
                      voidAndClusterUpdateFS,
                      voidAndClusterPartialUpdateVS,
                      visBluenoiseTiledFS,
                      drawFullScreenWithUvsVS,
                      visBluenoiseScaledFS,
                      exportFirstChannelFS,
                      bc4CompressFS);

        this.voidAndClusterInitLoc = {
            backgroundEnergySeed: getUniformLocation(GL, this.voidAndClusterInit, "backgroundEnergySeed")
        };

        this.voidAndClusterReduceInitLoc = {
            maxSizeAndSeed: getUniformLocation(GL, this.voidAndClusterReduceInit, "maxSizeAndSeed"),
            noiseEnergyMap: getUniformLocation(GL, this.voidAndClusterReduceInit, "noiseEnergyMap")
        };

        this.voidAndClusterReduceIterLoc = {
            maxSizeAndSeed: getUniformLocation(GL, this.voidAndClusterReduceIter, "maxSizeAndSeed"),
            inVoidData: getUniformLocation(GL, this.voidAndClusterReduceIter, "inVoidData")
        };

        this.voidAndClusterFullUpdateLoc = {
            inVoidData: getUniformLocation(GL, this.voidAndClusterFullUpdate, "inVoidData"),
            value: getUniformLocation(GL, this.voidAndClusterFullUpdate, "value"),
            textureSizeAndInvSize: getUniformLocation(GL, this.voidAndClusterFullUpdate, "textureSizeAndInvSize"),
            expMultiplier: getUniformLocation(GL, this.voidAndClusterFullUpdate, "expMultiplier")
        };

        this.voidAndClusterPartialUpdateLoc = {
            inVoidData: getUniformLocation(GL, this.voidAndClusterPartialUpdate, "inVoidData"),
            value: getUniformLocation(GL, this.voidAndClusterPartialUpdate, "value"),
            textureSizeAndInvSize: getUniformLocation(GL, this.voidAndClusterPartialUpdate, "textureSizeAndInvSize"),
            expMultiplier: getUniformLocation(GL, this.voidAndClusterPartialUpdate, "expMultiplier"),
            updateSpan: getUniformLocation(GL, this.voidAndClusterPartialUpdate, "updateSpan")
        };

        this.visBluenoiseTiledLoc = {
            textureSizeAndInvSize: getUniformLocation(GL, this.visBluenoiseTiled, "textureSizeAndInvSize"),
            noiseEnergy: getUniformLocation(GL, this.visBluenoiseTiled, "noiseEnergy")
        };

        this.visBluenoiseScaledLoc = {
            textureSizeAndInvSize: getUniformLocation(GL, this.visBluenoiseScaled, "textureSizeAndInvSize"),
            noiseEnergy: getUniformLocation(GL, this.visBluenoiseScaled, "noiseEnergy")
        };

        this.exportFirstChannelLoc = {
            inTexture: getUniformLocation(GL, this.exportFirstChannel, "inTexture")
        };

        this.bc4CompressLoc = {
            inTexture: getUniformLocation(GL, this.bc4Compress, "inTexture")
        };
    }
};


// Based upon:
//  A handy approximation for the error function and its inverse [7]
//  Sergei Winitzki, 2008
function ierf(x)
{
    // Using a = 0.147
    const twoOverPiA = 4.330746750799873082146;
    const y = Math.log(1 - x * x);
    const z = twoOverPiA + y * .5;
    return Math.sqrt(
        Math.sqrt(z * z - 6.80272108843537414966 * y)
        - y * .5
        - twoOverPiA
    );
}


// This is the main logic that deals with bluenoise generation, the rest
// is really just bootstrap and wrapper logic.
class BluenoiseRenderContext
{

    constructor(GL, PSOs, width, height, sigma, updateAccuracy)
    {
        const textureSizeAndInvSize = [width, height, 1.0/width, 1.0/height];
        // We don't bother filling the last value as it would be 0.
        const numIterations = width * height - 1;
        const valueMultiplier = 1.0 / numIterations;
        // We use exp2 rather than exp in our shaders as (atleast on AMD) results in cheaper instructions.
        const expMultiplier = Math.pow(sigma, -2) * Math.LOG2E;

        // Figure out if we can get away with doing partial updates to the blue noise texture
        // or if we have to a fullscreen pass.
        var updateSpan = Math.max(width, height);
        if((updateAccuracy > 0) && (updateAccuracy < 0.99999999))
        {
            const useCorrectAccuracy = false;
            if(useCorrectAccuracy)
            {
                // uu
                // ∫∫ e^-(xx + yy) 1/σ² dx dy = 4/π σ² erf(u/σ)
                // 00
                //
                // ∞∞
                // ∫∫ e^-(xx + yy) 1/σ² dx dy = 4/π σ²
                // 00
                //
                // Where u represents our span, we simply need to solve
                // (4/π σ² erf(u/σ)) / (4/π σ²) = accuracy
                //
                //
                // Simplifying shows:
                // accuracy = erf(span/σ)²
                // span = σ erfinv(√accuracy) 
                //
                updateSpan = Math.ceil(ierf(Math.sqrt(updateAccuracy)) * sigma);                
            }
            else
            {

                // More intuitive accuracy, big number found by solving:
                // e^(-u / σ²) = δ
                //
                // Where δ = FLT_MIN (2^-149)
                // u = √(-ln(2^-149)) δ
                // u = 10.16262416423198497411 δ
                //
                updateSpan = Math.round(10.16262416423198497411 * sigma * updateAccuracy);
            }
        }
        else if(updateAccuracy <= 0)
        {
            updateSpan = 0;
        }

        const partialUpdateBias = 0.01;
        const doPartialUpdate = (updateSpan * 2 + partialUpdateBias)
                < Math.min(width, height)
                ;


        // Create our framebuffers / textures
        var noiseEnergyFb = new TextureFramebuffer(GL, GL.RG32F, GL.RG, GL.FLOAT, width, height);

        // We always collapse 8x8 pixels into a tile at a time
        var voidAndClusterDims = [(width + 7) >> 3, (height + 7) >> 3]
        var voidAndClusterData = [];

        while(1)
        {
            var voidAndClusterLevelFB = new TextureFramebuffer(GL,
                                                               GL.RG32F,
                                                               GL.RG,
                                                               GL.FLOAT,
                                                               voidAndClusterDims[0],
                                                               voidAndClusterDims[1]);

            var newEntry = {
                fb: voidAndClusterLevelFB,
                dim: [voidAndClusterDims[0], voidAndClusterDims[1]]
            };
            voidAndClusterData.push(newEntry);

            if((voidAndClusterDims[0] == 1) && (voidAndClusterDims[1] == 1))
            {
                break;
            }

            voidAndClusterDims[0] = (voidAndClusterDims[0] + 7) >> 3;
            voidAndClusterDims[1] = (voidAndClusterDims[1] + 7) >> 3;
            if(voidAndClusterDims[0] == 0) { voidAndClusterDims[0] = 1; }
            if(voidAndClusterDims[1] == 0) { voidAndClusterDims[1] = 1; }
        }

        // Seed our initial background energy
        GL.disable(GL.BLEND);

        noiseEnergyFb.bind(function(){
            GL.useProgram(PSOs.voidAndClusterInit);
            GL.uniform1ui(PSOs.voidAndClusterInitLoc.backgroundEnergySeed, randomSeed());
            GL.bindVertexArray(PSOs.dummyVao);
            GL.drawArrays(GL.TRIANGLES, 0, 3);
        });

        this.GL = GL;
        this.PSOs = PSOs;
        this.iteration = 0;
        this.numIterations = numIterations;
        this.textureSizeAndInvSize = textureSizeAndInvSize;
        this.valueMultiplier = valueMultiplier;
        this.expMultiplier = expMultiplier;
        this.updateSpan = updateSpan;
        this.doPartialUpdate = doPartialUpdate;
        this.noiseEnergyFb = noiseEnergyFb;
        this.voidAndClusterData = voidAndClusterData;
    }


    iterate(numIterations)
    {
        // This routine finds the biggest void within the noise-energy texture,
        // by reducing 8x8 pixels at a time until we hit 1x1, which will be our
        // void.
        // The chosen pixel is then filled with the next value that descends from
        // 1 to 0.
        // This is all done on the GPU and at no point do we read this coordinate
        // back to CPU.

        if(this.done())
        {
            return;
        }

        const GL = this.GL;
        const PSOs = this.PSOs;
        const doPartialUpdate = this.doPartialUpdate;
        const updateSpan = this.updateSpan;
        const textureSizeAndInvSize = this.textureSizeAndInvSize;
        const valueMultiplier = this.valueMultiplier;
        const expMultiplier = this.expMultiplier;
        var noiseEnergyFb = this.noiseEnergyFb;
        var voidAndClusterData = this.voidAndClusterData;

        const updateProgram = doPartialUpdate ? PSOs.voidAndClusterPartialUpdate : PSOs.voidAndClusterFullUpdate;
        const updateLoc = doPartialUpdate ? PSOs.voidAndClusterPartialUpdateLoc : PSOs.voidAndClusterFullUpdateLoc;
        const updateDrawSize = doPartialUpdate ? (3 * 8) : 3;

        GL.blendEquation(GL.FUNC_ADD);
        GL.blendFunc(GL.ONE, GL.ONE);
        GL.bindVertexArray(this.PSOs.dummyVao);
        GL.disable(GL.DEPTH_TEST);

        while(!this.done() && (--numIterations >= 0))
        {
            GL.disable(GL.BLEND);
            
            voidAndClusterData[0].fb.bind(function()
            {
                GL.useProgram(PSOs.voidAndClusterReduceInit);
                GL.uniform3ui(PSOs.voidAndClusterReduceInitLoc.maxSizeAndSeed,
                              noiseEnergyFb.width,
                              noiseEnergyFb.height,
                              randomSeed()); 

                GL.activeTexture(GL.TEXTURE0);
                GL.bindTexture(GL.TEXTURE_2D, noiseEnergyFb.texture);
                GL.uniform1i(PSOs.voidAndClusterReduceInitLoc.noiseEnergyMap, 0);
                GL.drawArrays(GL.TRIANGLES, 0, 3);
            });

            for(var i=1; i < voidAndClusterData.length; ++i)
            {
                voidAndClusterData[i].fb.bind(function()
                {
                    GL.useProgram(PSOs.voidAndClusterReduceIter);
                    GL.uniform3ui(PSOs.voidAndClusterReduceIterLoc.maxSizeAndSeed,
                                  voidAndClusterData[i-1].fb.width,
                                  voidAndClusterData[i-1].fb.height,
                                  randomSeed()); 

                    GL.activeTexture(GL.TEXTURE0);
                    GL.bindTexture(GL.TEXTURE_2D, voidAndClusterData[i-1].fb.texture);
                    GL.uniform1i(PSOs.voidAndClusterReduceIterLoc.inVoidData, 0);
                    GL.drawArrays(GL.TRIANGLES, 0, 3);
                });
            }
            
            GL.enable(GL.BLEND);
            const currentIteration = this.iteration;
            noiseEnergyFb.bind(function()
            {
                GL.useProgram(updateProgram);

                if(doPartialUpdate)
                {
                    GL.uniform1i(updateLoc.updateSpan, updateSpan);
                }

                GL.activeTexture(GL.TEXTURE0);
                GL.bindTexture(GL.TEXTURE_2D, voidAndClusterData[voidAndClusterData.length - 1].fb.texture);
                GL.uniform1i(updateLoc.inVoidData, 0);
                GL.uniform4f(updateLoc.textureSizeAndInvSize,
                             textureSizeAndInvSize[0],
                             textureSizeAndInvSize[1],
                             textureSizeAndInvSize[2],
                             textureSizeAndInvSize[3]);
                GL.uniform1f(updateLoc.value, 1.0 - (currentIteration * valueMultiplier));
                GL.uniform1f(updateLoc.expMultiplier, expMultiplier);
                GL.drawArrays(GL.TRIANGLES, 0, updateDrawSize);
            });

            this.iteration += 1;        
        }

        GL.blendFunc(GL.ONE, GL.ZERO);
    }

    progress()
    {
        if(this.iteration == this.numIterations) { return 1.0; }
        return this.iteration / this.numIterations;
    }

    done()
    {
        return this.iteration >= this.numIterations;
    }

    destroy()
    {
        this.noiseEnergyFb.destroy();
        for(var i=0; i < this.voidAndClusterData.length; ++i)
        {
            this.voidAndClusterData[i].fb.destroy();
        }
    }

};



// Timer based logic is here in an attempt to prevent locking up the users machine,
// we aim to do enough queries per refresh to hit 30 frames a second, without exceeding
// that.
class GPUQueryTimer
{
    constructor(GL, ext)
    {
        this.GL = GL;
        this.ext = ext;
        this.query = GL.createQuery();
        this._result = null;
    }

    capture(f)
    {
        this._result = null;
        const GL = this.GL;
        const ext = this.ext;
        GL.beginQuery(ext.TIME_ELAPSED_EXT, this.query);
        f();
        GL.endQuery(ext.TIME_ELAPSED_EXT);
    }

    // Returns null if query is not ready
    getResult()
    {
        if(this._result == null)
        {
            const GL = this.GL;
            if(GL.getQueryParameter(this.query, GL.QUERY_RESULT_AVAILABLE))
            {
                this._result = GL.getQueryParameter(this.query, GL.QUERY_RESULT) * 1e-6;
            }
        }
        return this._result;
    }

    destroy()
    {
        if(this.query != null)
        {
            this.GL.deleteQuery(this.query);
            this.query = null;
        }
    }
};


class GPUTimerPool
{
    constructor(GL, ext)
    {
        this.GL = GL;
        this.ext = ext;
        this.freeQueries = [];
        this.waitingQueries = [];
        this.history = []
    }

    reset()
    {
        // Repool all queries
        for(var i=0; i<this.waitingQueries.length; ++i)
        {
            this.freeQueries.push(this.waitingQueries[i].query);
        }

        this.history = []
        this.waitingQueries = [];

    }

    destroy()
    {
        for(var i=0; i<this.freeQueries.length; ++i)
        {
            this.freeQueries[i].destroy();
        }
        
        for(var i=0; i<this.waitingQueries.length; ++i)
        {
            this.waitingQueries[i].query.destroy();
        }

        this.freeQueries = [];
        this.waitingQueries = [];
        this.history = [];
    }

    capture(numIterations, f)
    {
        var query = null;
        if(this.freeQueries.length == 0)
        {
            query = new GPUQueryTimer(this.GL, this.ext);
        }
        else
        {
            query = this.freeQueries.pop();
        }
        this.waitingQueries.push({query: query, numIterations: numIterations});
        query.capture(f);
    }

    getNumberOfIterations()
    {

        for(var i=0; i<this.waitingQueries.length; ++i)
        {
            const result = this.waitingQueries[i].query.getResult();
            if(result != null)
            {
                this.history.push([this.waitingQueries[i].numIterations,
                                   result]);
                this.freeQueries.push(this.waitingQueries[i].query);
                this.waitingQueries.pop(i);
            }
        }

        // Keep a maximum of 8 frames for reference
        while(this.history.length > 8)
        {
            this.history.pop(0);
        }

        var resolvedIterations = 0;
        var resolvedTimeTaken = 0;

        for(var i=0; i<this.history.length; ++i)
        {
            resolvedIterations += this.history[i][0];
            resolvedTimeTaken += this.history[i][1];
        }

        if(resolvedIterations == 0)
        {
            return 16;
        }

        // Leaving a teeny weeny bit of wiggle room for other things
        const targetMs = 33.;
        return Math.max(1, Math.round(resolvedIterations / resolvedTimeTaken * targetMs));
    }
};


// CPU fallback, for when we don't have GPU timers
// We increment and decrement the num iterations, based upon CPU time taken.
class CPUTimerPool
{
    constructor()
    {
        this.lastCount = 0;
        this.startTime = null;
    }

    reset()
    {
        this.lastCount = 0;
        this.startTime = null;
    }

    destroy()
    {
    }

    capture(numIterations, f)
    {

        this.startTime = Date.now();
        this.lastCount = numIterations;
        f();
    }

    getNumberOfIterations()
    {
        // Start with 16 samples as a reasonable base
        if(this.startTime == null)
        {
            return 16;
        }

        const timeDelta = Date.now() - this.startTime;
        return Math.max(1, timeDelta > 33.4 ? this.lastCount - 1 : this.lastCount + 1);
    }
};


class BluenoiseGeneratorCanvasContext
{
    constructor(canvas)
    {
        // https://registry.khronos.org/webgl/specs/latest/1.0/#5.2
        const GL = canvas.getContext("webgl2", {"alpha": false, "antialias": false, "depth": false, "stencil": false});
        this.renderContext = null;
        this.canvas = canvas;
        this.GL = GL;
        // NB: the act of calling "getExtension" activates them, without these calls they simply
        // won't be usable.
        this.hasFloatRenderTargets = GL && GL.getExtension("EXT_color_buffer_float") != null;
        this.hasFloatBlending = GL && GL.getExtension("EXT_float_blend") != null;
        this.gpuQueryExt = GL && GL.getExtension("EXT_disjoint_timer_query_webgl2");
        this.hasGpuQuery = this.gpuQueryExt != null;
        this.webBrowserSupported = GL
                                   && this.hasFloatRenderTargets
                                   && this.hasFloatBlending
                                   ;

        if(!this.webBrowserSupported)
        {
            if(!GL)
            {
                this.noSupportReason = "Could not create WebGL2 context.";
            }
            else
            {
                this.noSupportReason = "Does not have the required extensions "
                                     + "`EXT_color_buffer_float` "
                                     + "and `EXT_float_blend`.";
            }
            return;
        }

        addDPIResizeWatcher(canvas);

        this.settings = {
            width: 64,
            height: 64,
            visTiled: 1,
            sigma: 1.9,
            updateAccuracy: 0.9,
            pause: false
        };

        this.timerPool = this.hasGpuQuery ? new GPUTimerPool(GL, this.gpuQueryExt) : new CPUTimerPool();
        this.PSOs = new GraphicsPSOs(GL);
        this.forceRefresh = false;
    }

    handleCanvasResize()
    {
        const dirty = this.canvas.width  !== this.canvas.dpiWidth
                    || this.canvas.height !== this.canvas.dpiHeight;

        if(dirty)
        {
            this.canvas.width = this.canvas.dpiWidth;
            this.canvas.height = this.canvas.dpiHeight;
            this.restoreViewportState();
        }

        return dirty;
    }

    restoreViewportState()
    {
        const GL = this.GL;
        const canvas = this.canvas;
        GL.bindFramebuffer(GL.FRAMEBUFFER, null)
        GL.drawBuffers([GL.BACK])
        GL.viewport(0, 0, canvas.width, canvas.height);
    }

    newRenderingContext()
    {
        if(this.renderContext != null)
        {
            this.renderContext.destroy();
        }

        this.timerPool.reset();
        this.renderContext = new BluenoiseRenderContext(this.GL,
                                                        this.PSOs,
                                                        this.settings.width,
                                                        this.settings.height,
                                                        this.settings.sigma,
                                                        this.settings.updateAccuracy);
        this.restoreViewportState();
    }


    progress()
    {
        if(this.renderContext != null)
        {
            return this.renderContext.progress();
        }
        return 0;
    }


    done()
    {
        if(this.renderContext != null)
        {
            return this.renderContext.done();
        }
        return false;
    }


    activeDimensions()
    {
        if(this.renderContext != null)
        {
            const textureSizeAndInvSize = this.renderContext.textureSizeAndInvSize;
            return [textureSizeAndInvSize[0], textureSizeAndInvSize[1]];
        }
        return [0, 0];
    }


    update()
    {
        if(this.renderContext == null)
        {
            return;
        }

        var renderContext = this.renderContext;
        const updateBluenoise = !this.settings.pause && !renderContext.done()
        const refresh = this.handleCanvasResize() || updateBluenoise || this.forceRefresh;

        if(updateBluenoise)
        {
            const numIterations = this.timerPool.getNumberOfIterations();
            // console.log(`Running ${numIterations} iterations`);
            this.timerPool.capture(numIterations,
                                   function()
                                   {
                                       renderContext.iterate(numIterations);
                                   });
            this.restoreViewportState();
        }

        if(refresh)
        {
            this.forceRefresh = false;
            this.refreshVisualisation();
        }
    }


    refreshVisualisation()
    {
        if(this.renderContext == null)
        {
            return;
        }

        const GL = this.GL;
        const tiled = this.settings.visTiled;
        const textureSizeAndInvSize = this.renderContext.textureSizeAndInvSize;
        var noiseEnergyFb = this.renderContext.noiseEnergyFb;

        const program = tiled ? this.PSOs.visBluenoiseTiled : this.PSOs.visBluenoiseScaled;
        const loc = tiled ? this.PSOs.visBluenoiseTiledLoc : this.PSOs.visBluenoiseScaledLoc;

        GL.useProgram(program);
        GL.activeTexture(GL.TEXTURE0);
        GL.bindTexture(GL.TEXTURE_2D, noiseEnergyFb.texture);
        GL.uniform1i(loc.noiseEnergy, 0);
        GL.uniform4f(loc.textureSizeAndInvSize,
                         textureSizeAndInvSize[0],
                         textureSizeAndInvSize[1],
                         textureSizeAndInvSize[2],
                         textureSizeAndInvSize[3]);
        GL.drawArrays(GL.TRIANGLES, 0, 3);
    }


    readBlueNoiseRaw(formatType)
    {
        if(this.renderContext == null)
        {
            return null;
        }

        const GL = this.GL;
        const PSOs = this.PSOs;
        const dimensons = this.activeDimensions();
        var noiseEnergyFb = this.renderContext.noiseEnergyFb;
        const width = dimensons[0];
        const height = dimensons[1];

        var nativeType = null;
        var arrayType = null;

        switch(formatType)
        {
            case GL.UNSIGNED_BYTE:
            {
                nativeType = GL.R8;
                arrayType = Uint8Array;
                break;
            }
            case GL.HALF_FLOAT:
            {
                nativeType = GL.R16F;
                arrayType = Uint16Array;
                break;
            }
            case GL.FLOAT:
            {
                nativeType = GL.R32F;
                arrayType = Float32Array;
                break;
            }
            default:
            {
                var msg = "Unsupported format!";
                console.log(msg);
                debugger;
                alert(msg);
                throw new Error(msg);
            }
        }


        var captureFB = new TextureFramebuffer(GL, nativeType, GL.RED, formatType, width, height);
        captureFB.bind(function()
        {
            GL.disable(GL.BLEND);
            GL.useProgram(PSOs.exportFirstChannel);
            GL.activeTexture(GL.TEXTURE0);
            GL.bindTexture(GL.TEXTURE_2D, noiseEnergyFb.texture);
            GL.uniform1i(PSOs.exportFirstChannelLoc.inTexture, 0);
            GL.bindVertexArray(PSOs.dummyVao);
            GL.drawArrays(GL.TRIANGLES, 0, 3);
        });


        const pixels = new arrayType(width * height);
        GL.bindTexture(GL.TEXTURE_2D, captureFB.texture);
        GL.readPixels(0, 0, width, height, GL.RED, formatType, pixels);
        captureFB.destroy();

        this.restoreViewportState();
        return pixels;
    }

    readBlueNoiseBC4()
    {
        if(this.renderContext == null)
        {
            return null;
        }

        const GL = this.GL;
        const PSOs = this.PSOs;
        const dimensons = this.activeDimensions();
        var noiseEnergyFb = this.renderContext.noiseEnergyFb;
        const width = dimensons[0] >> 2;
        const height = dimensons[1] >> 2;

        var captureFB = new TextureFramebuffer(GL, GL.RG32UI, GL.RG_INTEGER, GL.UNSIGNED_INT, width, height);
        captureFB.bind(function()
        {
            GL.disable(GL.BLEND);
            GL.useProgram(PSOs.bc4Compress);
            GL.activeTexture(GL.TEXTURE0);
            GL.bindTexture(GL.TEXTURE_2D, noiseEnergyFb.texture);
            GL.uniform1i(PSOs.bc4CompressLoc.inTexture, 0);
            GL.bindVertexArray(PSOs.dummyVao);
            GL.drawArrays(GL.TRIANGLES, 0, 3);
        });


        const pixels = new Uint32Array(width * height * 2);
        GL.bindTexture(GL.TEXTURE_2D, captureFB.texture);
        GL.readPixels(0, 0, width, height, GL.RG_INTEGER, GL.UNSIGNED_INT, pixels);
        captureFB.destroy();

        this.restoreViewportState();
        return pixels;
    }
};



export function bindBluenoiseContext(canvas)
{
    if(canvas.bnCtx == undefined)
    {
        canvas.bnCtx = new BluenoiseGeneratorCanvasContext(canvas);
    }
    return canvas.bnCtx;
}


export function onResourcesLoaded(f)
{
    return _SHADERS.then(f);
}
