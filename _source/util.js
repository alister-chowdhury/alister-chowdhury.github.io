
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

    if(fragmentShader != null)
    {
        GL.attachShader(program, fragmentShader);
    }
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
    
    if(fragmentShader != null)
    {
        GL.detachShader(program, fragmentShader);
    }

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


export { AsyncBarrier };
