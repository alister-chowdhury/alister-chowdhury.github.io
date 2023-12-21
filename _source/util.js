
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
        const c = f(s);
        return c;
    }
};

export function loadCommonShaderSource(name, type="webgl")
{
    return fetch("/res/shaders/compiled_" + type + "/" + name).then(src => src.text());
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


export const resolveChildren = (desc)=>
{
    // Recursively find all objects and if it's a thenable
    // add it to the promise queue.
    const waitFor = [];
    const writeBack = [];
    let collectObjects = null;

    collectObjects = (x)=>
    {
        for (const [key, value] of Object.entries(x))
        {
            if(typeof value === "object")
            {
                if(value.then !== undefined)
                {
                    waitFor.push(value);
                    writeBack.push([x, key]);
                }
                else
                {
                    collectObjects(value);
                }
            }
        }
    };
    
    collectObjects(desc);

    return Promise.all(waitFor).then((values) =>
    {
        for(let i=0; i<writeBack.length; ++i)
        {
            const ref = writeBack[i];
            ref[0][ref[1]] = values[i];
        }
        return desc;
    });
};


export const createCanvasDragHandler = (canvas, startDragging, drag, stopDragging)=>
{
    const calcDragUV = (event, touch)=>
    {
        event.preventDefault();
        const bbox = canvas.getBoundingClientRect();
        const ref = touch ?
                    [event.touches[0].clientX, event.touches[0].clientY]
                    : [event.clientX, event.clientY]
                    ;
        return [(ref[0] - bbox.x) / bbox.width,
                 1.0 - (ref[1] - bbox.y) / bbox.height];
    };

    const initDrag = event=>{

       if(event.type == "mousedown")
       {
            const onMove = (event)=>{
                drag(calcDragUV(event, false));
            };
            const onEnd = (event)=>{
                event.preventDefault();
                canvas.removeEventListener("mousemove", onMove, false);
                canvas.removeEventListener("mouseup", onEnd, false);
                stopDragging();
            };
            canvas.addEventListener("mousemove", onMove, false);
            canvas.addEventListener("mouseup", onEnd, false);
            startDragging(calcDragUV(event, false));
       }
       else
       {
            const onMove = (event)=>{
                drag(calcDragUV(event, true));
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
};

export { AsyncBarrier };
