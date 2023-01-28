
class AsyncBarrier
{
    constructor()
    {
        this.num = 0;
        this.p = [];
    }

    ready()
    {
        return this.num == 0;
    }

    enqueue(task, name=null)
    {
        const s = this;
        ++s.num;
        task.then(
            result =>
            {
                if(name != null)
                {
                    s[name] = result;
                }
                if(--s.num == 0)
                {
                    let promises = s.p;
                    s.p = [];
                    promises.forEach(f => f());
                }
            }
        );
        return s;
    }

    then(f)
    {
        const s = this;
        return new Promise(
            resolve =>
            {
                if(s.num<1)
                {
                    resolve(f());
                }
                else
                {
                    s.p.push(()=>{resolve(f())});
                }
            }
        );
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


export { AsyncBarrier };
