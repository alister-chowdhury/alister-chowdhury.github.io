
class AsyncBarrier
{
    constructor()
    {
        this.num = 0;
        this.p = null; // promise lock
        this.r = null; // resolve promise
    }

    ready()
    {
        return this.num == 0;
    }

    enqueue(task, name=null, copyAttrs=null)
    {
        const s = this;
        if(s.p == null)
        {
            s.p = new Promise((resolve)=>{s.r = resolve;});
        }

        ++s.num;
        task.then(
            result =>
            {
                if(name != null)
                {
                    s[name] = result;
                }
                if(copyAttrs != null)
                {
                    copyAttrs.forEach(x=>{
                        s[x] = result[x];
                    });
                }
                if(--s.num == 0)
                {
                    s.r();
                }
            }
        );
        return s;
    }

    async selfBarrier()
    {
        let s = this;
        await s.then(()=>{});
        // Not sure why, but returning this will returned `undefined`
        // when returned directly, but when part of another object, it's
        // fine, so we are making a spread copy of itself to combat this.
        return {...s};
    }

    async then(f)
    {
        let s = this;
        while(s.num != 0)
        {
            await s.p;
        }
        const c = f();
        return c;
    }
};



export function loadCommonShaderSource(name, type="webgl")
{
    return fetch("/res/shaders/compiled_" + type + "/" + name).then(src => src.text());
}

export function createShader(GL, source, shaderType)
{
    if(!GL)
    {
        return null;
    }

    const shaderId = GL.createShader(shaderType);
    GL.shaderSource(shaderId, source, 0);
    GL.compileShader(shaderId);
    if(!GL.getShaderParameter(shaderId, GL.COMPILE_STATUS))
    {
        // Should probbaly bubble this up a bit better
        const errorLog = GL.getShaderInfoLog(shaderId);
        var msg = `Failed to compile shader (type: ${shaderType}):\n${errorLog}.`;
        console.log(msg);
        debugger;
        alert(msg);
        throw new Error(msg);
    }
    return shaderId;
}


export function createGraphicsProgram(GL, vertexShader, fragmentShader=null)
{
    if(!GL)
    {
        return null;
    }

    const program = GL.createProgram();
    GL.attachShader(program, vertexShader);

    // WebGL2 cannot support proper vertex only shaders for whatever weird design
    // reasons, so we're basically going to create a dummy one.
    //
    // "The program must contain objects to form both a vertex and fragment shader."
    if(fragmentShader == null)
    {
        if(GL.dummyFragmentShader == undefined)
        {
            GL.dummyFragmentShader = createShader(
                GL,
                "#version 300 es\nvoid main(){}",
                GL.FRAGMENT_SHADER
            );
        }
        fragmentShader = GL.dummyFragmentShader;
    }

    GL.attachShader(program, fragmentShader);
    GL.linkProgram(program);

    if(!GL.getProgramParameter(program, GL.LINK_STATUS))
    {
        // Should probbaly bubble this up a bit better
        const errorLog = GL.getProgramInfoLog(program);
        var msg = `Failed to link graphics program:\n${errorLog}.`;
        console.log(msg);
        debugger;
        alert(msg);
        throw new Error(msg);
    }

    GL.detachShader(program, vertexShader);
    GL.detachShader(program, fragmentShader);

    return program
}

export function getUniformLocation(GL, program, name)
{
    if(!GL)
    {
        return null;
    }

    return GL.getUniformLocation(program, name);
}


export function createDummyVAO(GL)
{
    if(!GL)
    {
        return null;
    }

    return GL.createVertexArray();
}


export function deleteShaders(GL, ...shaders)
{
    if(!GL)
    {
        return;
    }

    for(const shader of shaders)
    {
        if(shader)
        {
            GL.deleteShader(shader);
        }
    }
}


export function isElementVisible(element)
{
    const bbox = element.getBoundingClientRect();
    return bbox.bottom >= 0
        && bbox.right >= 0
        && bbox.top < (window.innerHeight || document.documentElement.clientHeight)
        && bbox.left < (window.innerWidth || document.documentElement.clientWidth)
        ;
}


export const IS_LITTLE_ENDIAN = new DataView(new Uint32Array([902392147]).buffer).getUint32(0, true) == 902392147;


export const loadF32Lines = IS_LITTLE_ENDIAN ?
    async filepath =>
        fetch(filepath).then(x =>
            x.blob().then(y =>
                y.arrayBuffer().then(z =>
                    new Float32Array(z)
                )
            )
        )
    :
    async filepath =>
        fetch(filepath).then(x =>
            x.blob().then(y =>
                y.arrayBuffer().then(z => {
                    const num = Math.floor(z.byteLength / 4);
                    const dv = new DataView(z);
                    let r = new Float32Array(num);
                    for (let i = 0; i < num; ++i) {
                        r[i] = dv.getFloat32(i * 4, true);
                    }
                    return r;
                })
            )
        );



export const bitcast = (()=>
{
    const u32tmp = new Uint32Array(1);
    const i32tmp = new Float32Array(u32tmp.buffer);
    const f32tmp = new Float32Array(u32tmp.buffer);

    const setAndFetch = (x, A, B)=>{A[0] = x; return B[0]; };

    return {
        f32:      (x)=>setAndFetch(x, f32tmp, f32tmp),
        u32:      (x)=>setAndFetch(x, u32tmp, u32tmp),
        i32:      (x)=>setAndFetch(x, i32tmp, i32tmp),
        f32tou32: (x)=>setAndFetch(x, f32tmp, u32tmp),
        u32tof32: (x)=>setAndFetch(x, u32tmp, f32tmp),
        f32toi32: (x)=>setAndFetch(x, f32tmp, i32tmp),
        i32tof32: (x)=>setAndFetch(x, i32tmp, f32tmp),
        u32toi32: (x)=>setAndFetch(x, u32tmp, i32tmp),
        i32tou32: (x)=>setAndFetch(x, i32tmp, u32tmp)
    };

})();


export { AsyncBarrier };
