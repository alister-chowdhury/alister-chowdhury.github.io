#version 460 core


layout(binding=0)  uniform sampler2D inVoidData;
layout(location=0) uniform vec4 textureSizeAndInvSize;
layout(location=3) uniform int updateSpan;


uint triangleToQuadVertexIdZ(uint vertexId)
{
    // 0---1
    // | / |
    // 2---3
    //
    // 0 1 2 =>  0 1 2
    // 3 4 5 =>  1 2 3
    if(vertexId >= 3) { vertexId -= 2; }
    return vertexId;
}


void main()
{
    uint packedVoidCoord = floatBitsToUint(texelFetch(inVoidData, ivec2(0, 0), 0).y);

    // Draw regions that need their energy updating post
    // void and cluster swap.
    //
    // Triangles 0,1    => VoidCoord +/- [0, 0]
    // Triangles 2,3    => VoidCoord +/- [2, 0]
    // Triangles 4,5    => VoidCoord +/- [0, 2]
    // Triangles 6,7    => VoidCoord +/- [2, 2]
    //
    uint vertexId = uint(gl_VertexID);
    uint quadId = triangleToQuadVertexIdZ(vertexId % 6);
    uint triangleId = vertexId / 6;
    int offsetX = int((triangleId & 1) << 1);
    int offsetY = int((triangleId) & 2);

    ivec2 coord = ivec2(int(packedVoidCoord & 0xffff), int(packedVoidCoord >> 16));

    // TODO:
    // This is a bit messy, and not especially elegant
    if(float(coord.x) >= textureSizeAndInvSize.x * 0.5)
    {
        offsetX = -offsetX;
    }
    if(float(coord.y) >= textureSizeAndInvSize.y * 0.5)
    {
        offsetY = -offsetY;
    }

    coord.x += ((quadId & 1) == 0) ? -updateSpan : (updateSpan + 1);
    coord.y += ((quadId & 2) == 0) ? -updateSpan : (updateSpan + 1);
    vec2 ndc = (vec2(coord) + 0.5) * textureSizeAndInvSize.zw * 2 - 1;

    vec2 ndcOffset = vec2(float(offsetX), float(offsetY));
    ndc += ndcOffset;

    gl_Position = vec4(ndc, 0., 1.);
}
