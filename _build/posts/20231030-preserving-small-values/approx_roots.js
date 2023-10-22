import{drawNormalised as t,drawLinesArray as e,drawGridLines as l}from"./graphing.js";import{bitcast as r}from"../../util.js";export const ApproxRoots=(()=>{let n=r.f32tou32,a=r.u32tof32,o=r.f32,i=r.u32,f=-1,s=Math.max(2,navigator.hardwareConcurrency||2),$=[],u=[],g=[],_=[],h=[],m=null,p=[],c=[],d=0,x=0,y=0,S=0,w=0,k=!1,C=0,v=0,E=!0,M={weight:1/0},T=()=>d/y,I=()=>{for(let t=0;t<$.length;++t)if(h.length>0)$.pop().postMessage({gid:f,invExponent:v,applyMagicAsFloat:E,magic:h.pop()});else break},L=()=>{let t=23,e=0,l=[],r=r=>{if(t<=0)return!1;let n=0;t<=r?r=t:n=t-(r-1);let a=1<<r,o=t-r,i=1<<o;return e+=a,l.push({numSearchValues:a,shift:o,incrementAmount:i,cumSumTaskCount:e}),0!=(t=n)};for(;r(4););return l},b=()=>{for(let t of u)t()},A=()=>{if(0!=p.length){let t=M.magic;null!=m?(t-=m.incrementAmount,S+=1):S=0;let e=p.shift(),l=e.shift;for(let r=0;r<e.numSearchValues;++r)h.push(t+(r<<l));x=e.cumSumTaskCount,m=e,I()}else b()},H=(()=>{let t=0;return()=>{f=t++}})(),W=t=>{let e=null;e=()=>{function l(){0!=h.length?t.postMessage({gid:f,invExponent:v,applyMagicAsFloat:E,magic:h.pop()}):$.push(t)}console.log("worker connected"),t.removeEventListener("message",e),t.addEventListener("message",function(t){let{taskGid:e,magic:r,weight:n,maxerr:a,avgerr:o}=t.data;if(e==f){if(++d,n<M.weight)for(let i of(M={magic:r,weight:n,maxerr:a,avgerr:o},_))i(M);c.push({offset:r,maxerr:a,passId:S});let s=T();for(let $ of g)$(s);d>=x&&A()}l()}),l()},t.addEventListener("message",e)};for(let z=0;z<s;++z){let O=new Worker("approx_roots_worker.js");W(O)}let P=(t,e=!0)=>{(k=1>Math.abs(t))&&(t=1/t),H(),h.length=0,d=0,x=0,y=0,c.length=0,v=1/(C=t),E=e;M={magic:C>0?Math.floor(127-127*v)<<23:Math.ceil(127-127*v)<<23,weight:1/0},m=null,w=(p=L()).length,y=p[p.length-1].cumSumTaskCount,A()},R=(t=-1)=>{c.sort((t,e)=>t.offset-e.offset);let e=1/0,l=-1/0,r=1/0,n=-1/0;for(let a of c)a.passId==t&&(a.maxerr<e&&(e=a.maxerr),a.maxerr>l&&(l=a.maxerr),a.offset<r&&(r=a.offset),a.offset>n&&(n=a.offset));let o=1/(n-r+1),i=1/(l-e+1),f=[];for(let s of c){if(s.passId!=t)continue;let $=1/(s.passId-t+1),u=s.passId/w,g="#"+Math.floor(255*u+.5).toString(16).padStart(2,"0")+"d5ff";f.push([(s.offset-r+.5)*o,(s.maxerr-e+.5)*i,$,g])}return{points:f,minOffset:r,maxOffset:n,minErr:e,maxErr:l}},j=(t,l=-1)=>{let r=R(l),n=t.getContext("2d"),a=t.width,o=t.height,i=1/Math.sqrt(a*o);n.setTransform(a,0,0,-o,0,o),n.clearRect(0,0,1,1),n.rect(0,0,1,1),n.fillStyle="#400778",n.lineWidth=i,n.fill(),n.strokeStyle="#00d5ff",n.fillStyle="#ffd5ff";let f=r.points;for(let s of(e(n,f,t=>[.8*t[0]+.1,.8*t[1]+.1]),f.sort((t,e)=>t[2]-e[2]),f)){let $=s[2];n.fillStyle=s[3],n.beginPath(),n.arc(.8*s[0]+.1,.8*s[1]+.1,i*$*3,0,2*Math.PI),n.fill()}return r},F=(t,e)=>{e.innerHTML="";let l=[];for(let r=0;r<w;++r){let n=t.createElement("div"),a=t.createElement("canvas"),o=t.createElement("div");n.appendChild(a),n.appendChild(o),o.innerHTML=`Pass ${r+1}`,e.appendChild(n),l.push([a,o])}let i=0;for(let f of l){let s=f[0],$=f[1];s.style.width="150px",s.style.height="150px",s.width=s.clientWidth,s.height=s.clientHeight;let u=j(s,i++);$.innerHTML+=`<br>0x${u.minOffset.toString(16)} - 0x${u.maxOffset.toString(16)}`}},q=()=>{let t=t=>Number.isInteger(t)?t+".0":t,e=E?`    // 3 x full rate
    float y = float(asuint(x));
    y = y * ${t(v)}f
          + ${t(M.magic)}f;
    return asfloat(uint(y));`:`    // 4 x full rate
    float y = float(asuint(x));
    y = y * ${t(v)}f;
    uint z = uint(y);
    return asfloat(z + 0x${M.magic.toString(16)}u);`,l=E?`    // 3 x full rate
    float y = float(asuint(x));
    y = y * ${t(C)}f
          - ${t(M.magic*C)}f;
    return asfloat(uint(y));`:`    // 4 x full rate
    uint z = asuint(x) - 0x${M.magic.toString(16)}u;
    float y = float(z);
    y = y * ${t(C)}f;
    return asfloat(uint(y));`;return[`
float encode(float x)
{
${k?l:e}
}
`,`
float decode(float x)
{
${k?e:l}
}
`]},G=(e,r=8)=>{e.width=e.clientWidth,e.height=e.clientHeight;let f=e.getContext("2d"),s=e.width,$=e.height,u=(1<<r)-1,g=1/u,_=t=>Math.floor(u*t+.5)*g;f.setTransform(s,0,0,-$,0,$),f.clearRect(0,0,1,1),f.rect(0,0,1,1),f.fillStyle="#400778",f.fill(),f.lineWidth=1/Math.sqrt(s*$),f.strokeStyle="#aaaaaa",l(f,!1),f.lineWidth*=2,f.strokeStyle="#00d5ff";let h=null,m=null;if(E?(h=t=>{let e=o(n(t));return a(i(e=e*v+M.magic))},m=t=>{let e=o(n(t));return a(i(e=e*C-M.magic*C))}):(h=t=>{let e=o(n(t)),l=i(e*=v);return a(l+M.magic)},m=t=>{let e=n(t)-M.magic,l=o(e)*C;return a(i(l))}),k){let p=h;h=m,m=p}t(e,f,t=>m(_(h(t))))};return{newJob:P,makeRefinementGraphStages:F,generateSourceCode:q,makeComparisonGraph:G,onFinish(t){u.push(t)},onProgress(t){g.push(t)},onMagicUpdate(t){_.push(t)}}})();