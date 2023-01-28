class AsyncBarrier{constructor(){this.num=0,this.p=[]}ready(){return 0==this.num}enqueue(e,r=null){let t=this;return++t.num,e.then(e=>{if(null!=r&&(t[r]=e),0==--t.num){let n=t.p;t.p=[],n.forEach(e=>e())}}),t}then(e){let r=this;return new Promise(t=>{r.num<1?t(e()):r.p.push(()=>{t(e())})})}}export function createShader(e,r,t){if(!e)return null;let n=e.createShader(t);if(e.shaderSource(n,r,0),e.compileShader(n),!e.getShaderParameter(n,e.COMPILE_STATUS)){let a=e.getShaderInfoLog(n);var o=`Failed to compile shader (type: ${t}):
${a}.`;throw console.log(o),alert(o),Error(o)}return n}export function createGraphicsProgram(e,r,t=null){if(!e)return null;let n=e.createProgram();if(e.attachShader(n,r),null!=t&&e.attachShader(n,t),e.linkProgram(n),!e.getProgramParameter(n,e.LINK_STATUS)){let a=e.getProgramInfoLog(n);var o=`Failed to link graphics program:
${a}.`;throw console.log(o),alert(o),Error(o)}return e.detachShader(n,r),null!=t&&e.detachShader(n,t),n}export function getUniformLocation(e,r,t){return e?e.getUniformLocation(r,t):null}export function createDummyVAO(e){return e?e.createVertexArray():null}export function deleteShaders(e,...r){if(e)for(let t of r)t&&e.deleteShader(t)}export{AsyncBarrier};