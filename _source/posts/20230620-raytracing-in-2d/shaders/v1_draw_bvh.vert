#version 460 core

// dispatch GL_LINES, 16 * numNodes

#define LINE_BVH_V1_LOC 0
#include "common.glsli"
#include "v1_tracing.glsli"


#ifndef ONLY_LINES
#define ONLY_LINES 0
#endif

#ifndef ONLY_BOXES
#define ONLY_BOXES 0
#endif


layout(location=0) out vec3 vsToFsCol;


void main()
{
    int index = int(gl_VertexID);
    int pointIndex = index & 1; index /= 2;
    int lineIndex = index & 3; index /= 4;
    int sideIndex = index & 1; index /= 2;
    int entryIndex = index;

    vec4 metadata = V1_BVH_TEXEL_FETCH(entryIndex * 3);
    vec4 data = V1_BVH_TEXEL_FETCH(entryIndex * 3 + 1 + sideIndex);

    bool isBbox = floatBitsToInt(sideIndex == 0 ? metadata.x : metadata.z) == LINE_BVH_V1_BBOX_TYPE;
    vec2 uv = vec2(0);

    if(!isBbox)
    {
#if !ONLY_BOXES
        if(lineIndex == 0)
        {
            uv = data.xy;
            if(pointIndex == 1)
            {
                uv -= data.zw;
            }
        }
#endif // !ONLY_BOXES
    }
    else
    {
#if !ONLY_LINES
        switch(lineIndex)
        {
            case 0: uv = (pointIndex == 0) ? data.xy : data.zy; break;
            case 1: uv = (pointIndex == 0) ? data.zy : data.zw; break;
            case 2: uv = (pointIndex == 0) ? data.zw : data.xw; break;
            case 3: uv = (pointIndex == 0) ? data.xw : data.xy; break;
            default: break;
        }
#endif // !ONLY_LINES
    }

    vec3 col = randomHs1Col(uint(entryIndex * 2 + sideIndex) * 123);

    if(!isBbox)
    {
        col *= 2;
        // col *= 0;
    }

    vsToFsCol = col;

    gl_Position = vec4(uv * 2.0 - 1.0, 0., 1.);
}

