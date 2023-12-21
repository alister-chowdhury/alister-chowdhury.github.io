
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
