import{AsyncBarrier as e,createShader as r,createGraphicsProgram as t,getUniformLocation as n,createDummyVAO as o,deleteShaders as d}from"../../util.js";function loadShaderSource(e){return fetch("./shaders/compiled/"+e).then(e=>e.text())}export const paddedHexify=e=>e.toString(16).padStart(8,"0");export function decodeToString(e){let r="";for(let t=0;t<8;++t,e>>=4)r+="0123456789e.+-# "[15&e];return r}export let encodeNumber;let _RESOURCES=new e().enqueue(loadShaderSource("draw_number.vert"),"DRAW_NUMBER_VS_SRC").enqueue(loadShaderSource("draw_number.frag"),"DRAW_NUMBER_FS_SRC").enqueue(WebAssembly.instantiateStreaming(fetch("encode_number_web.wasm")).then(e=>{let r=e.instance.exports;r.init(),encodeNumber=e=>r.encodeNumber(e)>>>0}),"encodeNumber");class DrawNumbersCanvasContext{constructor(e){let u=e.getContext("webgl2");if(this.valid=!!u,!this.valid)return;let a=r(u,_RESOURCES.DRAW_NUMBER_VS_SRC,u.VERTEX_SHADER),i=r(u,_RESOURCES.DRAW_NUMBER_FS_SRC,u.FRAGMENT_SHADER),S=t(u,a,i),l={encodedNumber:n(u,S,"encodedNumber"),bgCol:n(u,S,"bgCol"),fgCol:n(u,S,"fgCol")};d(u,a,i),u.viewport(0,0,e.clientWidth,e.clientHeight),u.disable(u.DEPTH_TEST),u.disable(u.BLEND),u.useProgram(S),u.bindVertexArray(o(u)),this.render=(e,r,t)=>{u.uniform1ui(l.encodedNumber,e),u.uniform3f(l.bgCol,r[0],r[1],r[2]),u.uniform3f(l.fgCol,t[0],t[1],t[2]),u.drawArrays(u.TRIANGLES,0,3)}}}export function bindDrawNumbersContext(e){return void 0==e.drawCtx&&(e.drawCtx=new DrawNumbersCanvasContext(e)),e.drawCtx}export function onResourcesLoaded(e){return _RESOURCES.then(e)}