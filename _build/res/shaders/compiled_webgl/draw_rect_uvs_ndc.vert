#version 300 es
uniform highp vec4 inRectBounds;out vec2 uv;out vec2 ndc;void main(){int _;do{if(gl_VertexID<3){_=gl_VertexID;break;}_=gl_VertexID-2;break;}while(false);float a;if((_&1)==0){a=inRectBounds.x;}else{a=inRectBounds.z;}float b;if((_&2)==0){b=inRectBounds.y;}else{b=inRectBounds.w;}uv=vec2(a,b);ndc=(uv*2.)-vec2(1.);gl_Position=vec4(ndc,0.,1.);}