#version 460 core

#include "v2_tracing.glsli"
#include "common.glsli"

layout(binding=1) uniform nodeStart_ { int nodeStart; };

flat layout(location=0) out vec3 colA;
flat layout(location=1) out vec3 colB;
flat layout(location=2) out float level;
     layout(location=3) out vec2 localCoord;


bool resolveNode(uint nodeId,
                 out vec4 bbox,
                 out int resolvedLevel)
{
    /*
               0              1          => 0
           2      3       4      5       => 1
         6   7  8   9   10 11  12 13     => 2
    */
    resolvedLevel = findMSB((nodeId + 2)) - 1;  // int(log2(i+2))-1)
    uint type = LINE_BVH_V2_NODE_TYPE;
    uint head = 0;

    for(int i=0; i<=resolvedLevel; ++i)
    {
        if(type != LINE_BVH_V2_NODE_TYPE) { return false; }

        uint side = (nodeId >> i) & 1;
        bbox = v2LinesBvh[head + 1 + side];
        if((bbox.x >= bbox.z) || (bbox.y >= bbox.w))
        {
            return false;
        }

        vec4 v0 = v2LinesBvh[head + 0];
        vec2 header = side == 0 ? v0.xy : v0.zw;
        type = floatBitsToUint(header.x);
        head = floatBitsToUint(header.y);
    }

    return true;
}

void main()
{
    int nodeId = gl_VertexID / 6 + nodeStart;
    int quadId = triangleToQuadVertexIdZ(gl_VertexID % 6);

    vec4 bbox ;
    int resolvedLevel;
    if(!resolveNode(nodeId, bbox, resolvedLevel))
    {
        bbox = vec4(0);
    }

    localCoord = vec2((quadId & 1) == 0 ? 0 : 8 * (bbox.z-bbox.x),
                      (quadId & 2) == 0 ? 0 : 8 * (bbox.w-bbox.y));

    vec2 ndc = vec2((quadId & 1) == 0 ? bbox.x : bbox.z,
                    (quadId & 2) == 0 ? bbox.y : bbox.w)
                    * 2 - 1;

    level = float(resolvedLevel);

    float H0 = randomBounded(simpleHash32_u2v0(uvec2(nodeId, 0u)));
    float H1 = randomBounded(simpleHash32_u2v0(uvec2(0u, nodeId)));

    if(fract(abs(H0 - H1) + 1) < 0.2)
    {
        H1 = fract(H1 + 0.5);
    }

    colA = hs1(H0);
    colB = hs1(H1);

    gl_Position = vec4(ndc, 0.0, 1.0);
}
