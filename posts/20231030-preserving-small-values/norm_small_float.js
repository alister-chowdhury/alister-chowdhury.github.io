import{bitcast as t}from"../../util.js";import{drawNormalised as l,drawGridLines as e}from"./graphing.js";export const NormSmallFloat=(()=>{let a=t.f32tou32,o=t.u32tof32,r=t.f32,f=t.u32,$=t=>{let l;if(Number.isInteger(t))l=(1<<23+t)-1;else{let e=(1<<23+Math.floor(t))-1,a=(1<<23+Math.ceil(t))-1,r=t-Math.floor(t);l=Math.floor(e+(a-e)*r)}let f=o(l),$=1/l,n=l,u=1/f;return[f,$,n,u]},n=(t,$,n,u)=>{let i=t.getContext("2d");t.width=t.clientWidth,t.height=t.clientHeight;let s=t.width,_=t.height;i.setTransform(s,0,0,-_,0,_),i.clearRect(0,0,1,1),i.rect(0,0,1,1),i.fillStyle="#400778",i.fill(),i.lineWidth=1/Math.sqrt(s*_),i.strokeStyle="#aaaaaa",e(i,n);let x=t=>{let l=a(t*$[0]);return r(l*$[1]),r(l*$[1])},d=t=>{t=2*t-1;let l=Math.abs(t)*$[0],e=.5*$[1]*Math.sign(t);return a(l)*e+.5},c=t=>{let l=f(t*$[2]);return o(l)*$[3]},y=t=>{let l=2*t*$[2]-$[2],e=o(f(Math.abs(l)))*$[3],a=e*Math.sign(l);return .5*a+.5},g=(1<<u)-1,h=1/g,z=t=>Math.floor(g*t+.5)*h;i.lineWidth*=2,i.strokeStyle="#ffd5ff",i.strokeStyle="#00d5ff",l(t,i,n?t=>y(z(d(t))):t=>c(z(x(t))))},u=(t,l)=>{let e=t=>`asfloat(0x${a(t).toString(16)}u)`,o=null,r=null;return l?(o=`float encode(float x)
{
     // 5 x full rate
    float y = abs(x) * ${e(t[0])};
    uint z = 0x${a(.5*t[1]).toString(16)}u
            | (asuint(x) & 0x80000000u);
    return float(asuint(y)) * asfloat(z) + 0.5;
}`,r=`float decode(float x)
{
     // 5 x full rate
    float y = x * ${e(2*t[2])}
                - ${e(t[2])};
    float z = asfloat(uint(abs(y)))
            * ${e(t[3])};
    return asfloat(asuint(z)
                | (asuint(y) & 0x80000000u));
}`):(o=`float encode(float x)
{
     // 3 x full rate
    float y = x * ${e(t[0])};
    float z = float(asuint(y));
    return z * ${e(t[1])};
}`,r=`float decode(float x)
{
     // 3 x full rate
    float y = x * ${e(t[2])};
    float z = asfloat(uint(y));
    return z * ${e(t[3])};
}`),[o,r]};return{calcCoefs:$,drawGraph:n,generateSourceCode:u}})();