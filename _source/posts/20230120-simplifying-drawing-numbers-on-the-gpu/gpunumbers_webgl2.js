import {
    AsyncBarrier,
    loadCommonShaderSource,
    createShader,
    createGraphicsProgram,
    getUniformLocation,
    createDummyVAO,
    deleteShaders
} from '../../util.js';


function loadShaderSource(name)
{
    return fetch("./shaders/compiled/" + name).then(src => src.text());
}


export const paddedHexify = u32 => u32.toString(16).padStart(8, "0");

export function decodeToString(u32)
{
    let s = "";
    for(let i=0; i<8; ++i, u32>>=4)
    {
        s+="0123456789e.+-# "[u32&15];
    }
    return s;
}

export let encodeNumber = undefined;


const _RESOURCES = new AsyncBarrier()
    .enqueue(loadCommonShaderSource("draw_full_screen_uvs.vert"), "DRAW_NUMBER_VS_SRC")
    .enqueue(loadShaderSource("draw_number.frag"), "DRAW_NUMBER_FS_SRC")
    .enqueue(
        WebAssembly.instantiateStreaming(fetch("/res/encode_number_web.wasm")).then(
            obj => {
            const funcs = obj.instance.exports;
            funcs.init();
            // The direct result of encodeNumber will be a i32, this is just a wrapper
            // around that to coerce it to be a u32
            encodeNumber = num => {
                return funcs.encodeNumber(num) >>>0;
            };
        }),
        "encodeNumber")
    ;


class DrawNumbersCanvasContext
{
    constructor(canvas)
    {
        const GL = canvas.getContext("webgl2"); 
        this.valid = !!GL;

        if(!this.valid)
        {
            return;
        }

        // We don't handle any sort of resizing and aren't rendering to
        // a texture, as a result, we can setup our rendering states just once
        // and just use a lambda for the actual rendering.
        const drawNumberVS = createShader(GL, _RESOURCES.DRAW_NUMBER_VS_SRC, GL.VERTEX_SHADER);
        const drawNumberFS = createShader(GL, _RESOURCES.DRAW_NUMBER_FS_SRC, GL.FRAGMENT_SHADER);
        const drawNumberPipeline = createGraphicsProgram(GL, drawNumberVS, drawNumberFS);
        const drawNumberPipelineLoc = {
            encodedNumber: getUniformLocation(GL, drawNumberPipeline, "encodedNumber"),
            bgCol: getUniformLocation(GL, drawNumberPipeline, "bgCol"),
            fgCol: getUniformLocation(GL, drawNumberPipeline, "fgCol")
        };
        deleteShaders(GL, drawNumberVS, drawNumberFS);

        // GL.bindFramebuffer(GL.FRAMEBUFFER, null)
        // GL.drawBuffers([GL.BACK])
        GL.viewport(0, 0, canvas.clientWidth, canvas.clientHeight);        
        GL.disable(GL.DEPTH_TEST);
        GL.disable(GL.BLEND);

        GL.useProgram(drawNumberPipeline);
        GL.bindVertexArray(createDummyVAO(GL));

        this.render = (encodedNumber, bgCol, fgCol)=>
        {
            GL.uniform1ui(drawNumberPipelineLoc.encodedNumber, encodedNumber);
            GL.uniform3f(drawNumberPipelineLoc.bgCol, bgCol[0], bgCol[1], bgCol[2]);
            GL.uniform3f(drawNumberPipelineLoc.fgCol, fgCol[0], fgCol[1], fgCol[2]);
            GL.drawArrays(GL.TRIANGLES, 0, 3);
        };
    }
};


export function bindDrawNumbersContext(canvas)
{
    if(canvas.drawCtx == undefined)
    {
        canvas.drawCtx = new DrawNumbersCanvasContext(canvas);
    }
    return canvas.drawCtx;
}


export function onResourcesLoaded(f)
{
    return _RESOURCES.then(f);
}
