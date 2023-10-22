export const drawLinesArray = (ctx, arr, transform=null)=>{

    if(transform == null || transform == undefined)
    {
        transform = (x)=>x;
    }

    let last = transform(arr[0]);
    for(let i=1; i<arr.length; ++i)
    {
        let curr = transform(arr[i]);
        ctx.beginPath();
        ctx.moveTo(...last);
        ctx.lineTo(...curr);
        ctx.stroke();
        last = curr;
    }
};


export const drawNormalised = (canvas, ctx, f)=>
{
    const width = canvas.width;
    const dX = 1.0 / width;

    let last = [0, f(0)];
    for(let i=1; i<width; ++i)
    {
        const x = dX * i;
        const curr = [x, f(x)];
        ctx.beginPath();
        ctx.moveTo(...last);
        ctx.lineTo(...curr);
        ctx.stroke();
        last = curr;
    }
};


export const drawGridLines = (ctx, ndc=false)=>
{
    const num = ndc ? 20 : 10;
    for(let i=0; i<=num; ++i)
    {
        const x = i / num;
        ctx.beginPath();
        ctx.moveTo(0, x);
        ctx.lineTo(1, x);
        ctx.stroke();
        ctx.beginPath();
        ctx.moveTo(x, 0);
        ctx.lineTo(x, 1);
        ctx.stroke();
    }

    if(ndc)
    {
        const pw = ctx.lineWidth;
        ctx.lineWidth *= 2;
        ctx.beginPath();
        ctx.moveTo(0, 0.5);
        ctx.lineTo(1, 0.5);
        ctx.stroke();
        ctx.beginPath();
        ctx.moveTo(0.5, 0);
        ctx.lineTo(0.5, 1);
        ctx.stroke();
        ctx.lineWidth = pw;        
    }
};