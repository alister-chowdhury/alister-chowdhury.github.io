import {
    resolveChildren
} from './util.js';


// Ensure these have some value, so on browsers that don't support WebGPU
// there isn't just an immediate failure.
if(!window.GPUBufferUsage)     { window.GPUBufferUsage = {}; }
if(!window.GPUTextureUsage)    { window.GPUTextureUsage = {}; }
if(!window.GPUShaderStage)     { window.GPUShaderStage = {}; }

export const presentationFormat = (navigator.gpu && navigator.gpu.getPreferredCanvasFormat)
                                ? navigator.gpu.getPreferredCanvasFormat()
                                : null;

export const WebGPUState = (()=>
{
    let resolveOnReady = null;
    let resolveOnError = null;

    const state = {
        ok: false,
        err: null,
        device: null,
        adapter: null,
        onready: new Promise((resolve,) => {resolveOnReady = resolve;}),
        onerror: new Promise((resolve,) => {resolveOnError = resolve;})
    };

    const err = (msg)=>
    {
        state.err = msg;
        state.ok = false;
        state.adapter = null;
        state.device = null;
        resolveOnError(state);
    };

    if(!navigator.gpu) { err("WebGPU not supported."); }
    else
    {
        navigator.gpu.requestAdapter().then(
            adapter=>
            {
                if(!adapter)
                {
                    err("WebGPU adapter not found.");
                    return;
                }
                adapter.requestDevice().then(
                    device =>
                    {
                        state.ok = true;
                        state.adapter = adapter;
                        state.device = device;
                        device.lost.then(()=>{ err("WebGPU device lost!");});
                        // Unlikely, but possible that the device was lost straight
                        // after being acquired.
                        if(state.ok)
                        {
                            resolveOnReady(state);
                        }
                    });
            });
    }

    return state;
})();


export const createCmdBuffer = ()=>
{
    if(!WebGPUState.ok)
    {
        return null;
    }

    const device = WebGPUState.device;
    let currentCmdBuffer = null;
    let finishedCmdBuffer = null;
    let cmdbuf = null;

    const get = ()=>
    {
        return currentCmdBuffer;
    };

    const create = ()=>
    {
        currentCmdBuffer = device.createCommandEncoder();
        finishedCmdBuffer = null;
        cmdbuf = get;
        return currentCmdBuffer;
    };

    cmdbuf = create;

    const beginComputePass = (...args)=>{ return cmdbuf().beginComputePass(...args); }
    const beginRenderPass = (...args)=>{ return cmdbuf().beginRenderPass(...args); }
    const clearBuffer = (...args)=>{ return cmdbuf().clearBuffer(...args); }
    const copyBufferToBuffer = (...args)=>{ return cmdbuf().copyBufferToBuffer(...args); }
    const copyBufferToTexture = (...args)=>{ return cmdbuf().copyBufferToTexture(...args); }
    const copyTextureToBuffer = (...args)=>{ return cmdbuf().copyTextureToBuffer(...args); }
    const copyTextureToTexture = (...args)=>{ return cmdbuf().copyTextureToTexture(...args); }
    const insertDebugMarker = (...args)=>{ return cmdbuf().insertDebugMarker(...args); }
    const popDebugGroup = (...args)=>{ return cmdbuf().popDebugGroup(...args); }
    const pushDebugGroup = (...args)=>{ return cmdbuf().pushDebugGroup(...args); }
    const resolveQuerySet = (...args)=>{ return cmdbuf().resolveQuerySet(...args); }
    const writeTimestamp = (...args)=>{ return cmdbuf().writeTimestamp(...args); }
    const finish = ()=>
    {
        if(finishedCmdBuffer == null)
        {
            if(currentCmdBuffer != null)
            {
                cmdbuf = create;
                finishedCmdBuffer = currentCmdBuffer.finish();
                currentCmdBuffer = null;
            }
        }
        return finishedCmdBuffer;
    };

    const submit = (clear=true)=>
    {
        finish();
        if(finishedCmdBuffer)
        {
            device.queue.submit([finishedCmdBuffer]);
            if(clear)
            {
                finishedCmdBuffer = null;
            }
        }
    };

    const computePass = (desc, f)=>
    {
        const cmd = cmdbuf();
        const pass = cmd.beginComputePass(desc);
        f(pass);
        pass.end();
    };

    const renderPass = (desc, f)=>
    {
        const cmd = cmdbuf();
        const pass = cmd.beginRenderPass(desc);
        f(pass);
        pass.end();
    };

    const copyToGPUBuffer = (buf,
                             data,
                             dstOffset=0,
                             srcOffset=0,
                             size=null)=>
    {
        if(size == null)
        {
            size = (data.byteLength - srcOffset);
        }
        
        const byteBuffer = new Uint8Array(
            data.buffer,
            data.byteOffset + srcOffset,
            size
        );
        
        const stage = device.createBuffer({
            size: size,
            usage: GPUBufferUsage.COPY_SRC,
            mappedAtCreation: true
        });
        new Uint8Array(stage.getMappedRange()).set(byteBuffer);
        stage.unmap();

        copyBufferToBuffer(stage, 0, buf, dstOffset, size);
    }

    const ctx = {
        beginRenderPass: beginRenderPass,
        beginComputePass: beginComputePass,
        clearBuffer: clearBuffer,
        copyBufferToBuffer: copyBufferToBuffer,
        copyBufferToTexture: copyBufferToTexture,
        copyTextureToBuffer: copyTextureToBuffer,
        copyTextureToTexture: copyTextureToTexture,
        insertDebugMarker: insertDebugMarker,
        popDebugGroup: popDebugGroup,
        pushDebugGroup: pushDebugGroup,
        resolveQuerySet: resolveQuerySet,
        writeTimestamp: writeTimestamp,
        finish: finish,
        submit: submit,

        computePass: computePass,
        renderPass: renderPass,
        copyToGPUBuffer: copyToGPUBuffer,
    };

    return ctx;
};


export const ImmContext = (()=>
{
    let ctxCmdsReady = null;
    const ctxCmds =
    {
        onready: new Promise((resolve)=>{ctxCmdsReady = resolve;})
    };

    WebGPUState.onready.then(()=>
    {
        Object.assign(ctxCmds, createCmdBuffer());
        // Force submits to always clear
        ctxCmds.submit = ((submit)=>()=>submit(true))(ctxCmds.submit);
        ctxCmdsReady(ctxCmds);
    });

    return ctxCmds;
})();


export const makeGPUBuffer = (usage, data, offset=0, size=null)=>
{
    if(!WebGPUState.ok)
    {
        return;
    }

    if(size == null)
    {
        size = (data.byteLength - offset);
    }
    
    const byteBuffer = new Uint8Array(
        data.buffer,
        data.byteOffset + offset,
        size
    );
    const buf = WebGPUState.device.createBuffer({
        size: size,
        usage: usage,
        mappedAtCreation: true
    });
    new Uint8Array(buf.getMappedRange()).set(byteBuffer);
    buf.unmap();

    return buf;
};

export const createShaderModule = (source)=>
{
    if(WebGPUState.ok)
    {
        return WebGPUState.device.createShaderModule({code: source});
    }
    return null;
};

export const createBindGroupLayout = (desc)=>
{
    if(WebGPUState.ok)
    {
        const result = WebGPUState.device.createBindGroupLayout(desc);

        // cheeky helper to create a group inline, without needing
        // to manually setup the mapping each time.
        // may or may not be a reasonable idea ro LRU this?
        result.createGroup = (...entries)=>
        {
            const entriesDesc = [];
            for(let i=0; i<entries.length; ++i)
            {
                if(entries[i])
                {
                    entriesDesc.push(
                    {
                        binding: i,
                        resource: (entries[i].constructor == GPUBuffer)
                                    ? { buffer: entries[i], }
                                    : entries[i],
                    });
                }
            }
            return WebGPUState.device.createBindGroup({
                layout: result,
                entries: entriesDesc
            });
        };
        return result;
    }
    return null;
};

export const createPipelineLayout = (desc)=>
{
    if(WebGPUState.ok)
    {
        return WebGPUState.device.createPipelineLayout(desc);
    }
    return null;
};

export const createComputePipeline = (desc)=>
{
    if(WebGPUState.ok)
    {
        return WebGPUState.device.createComputePipeline(desc);
    }
    return null;
};

export const createRenderPipeline = (desc)=>
{
    if(WebGPUState.ok)
    {
        return WebGPUState.device.createRenderPipeline(desc);
    }
    return null;
};

export const createComputePipelineAsync = (desc)=>
{
    if(WebGPUState.ok)
    {
        return WebGPUState.device.createComputePipelineAsync(desc);
    }
    return null;
};

export const createRenderPipelineAsync = (desc)=>
{
    if(WebGPUState.ok)
    {
        return WebGPUState.device.createRenderPipelineAsync(desc);
    }
    return null;
};


export const asyncCompleteDesc = (desc)=>
{
    return WebGPUState.onready.then(()=>
    {
        return resolveChildren(desc);
    });
};


const makeSimpleAsyncCreateFunc = (underlying)=>{return (desc)=>WebGPUState.onready.then(()=>underlying(desc)); };
const makeAsyncCreateFunc       = (underlying)=>{return (desc)=>asyncCompleteDesc(desc).then(async (desc)=>underlying(desc)); };

export const asyncMakeGPUBuffer = (usage, data, offset=0, size=null)=>
{
    return Promise.all([data, WebGPUState.onready]).then((values) =>
    {
        return makeGPUBuffer(usage, values[0], offset, size);
    });
};

export const asyncCreateShaderModule = (source)=>
{
    return Promise.all([source, WebGPUState.onready]).then((values) =>
    {
        return createShaderModule(values[0]);
    });
};

export const asyncCreateBindGroupLayout = makeSimpleAsyncCreateFunc(createBindGroupLayout);
export const asyncCreatePipelineLayout = makeAsyncCreateFunc(createPipelineLayout);
export const asyncCreateComputePipeline = makeAsyncCreateFunc(createComputePipelineAsync);
export const asyncCreateRenderPipeline = makeAsyncCreateFunc(createRenderPipelineAsync);
