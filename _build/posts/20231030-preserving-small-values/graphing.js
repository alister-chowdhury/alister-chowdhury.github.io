export const drawLinesArray=(e,o,t=null)=>{(null==t||void 0==t)&&(t=e=>e);let i=t(o[0]);for(let l=1;l<o.length;++l){let n=t(o[l]);e.beginPath(),e.moveTo(...i),e.lineTo(...n),e.stroke(),i=n}};export const drawNormalised=(e,o,t)=>{let i=e.width,l=1/i,n=[0,t(0)];for(let r=1;r<i;++r){let $=l*r,s=[$,t($)];o.beginPath(),o.moveTo(...n),o.lineTo(...s),o.stroke(),n=s}};export const drawGridLines=(e,o=!1)=>{let t=o?20:10;for(let i=0;i<=t;++i){let l=i/t;e.beginPath(),e.moveTo(0,l),e.lineTo(1,l),e.stroke(),e.beginPath(),e.moveTo(l,0),e.lineTo(l,1),e.stroke()}if(o){let n=e.lineWidth;e.lineWidth*=2,e.beginPath(),e.moveTo(0,.5),e.lineTo(1,.5),e.stroke(),e.beginPath(),e.moveTo(.5,0),e.lineTo(.5,1),e.stroke(),e.lineWidth=n}};