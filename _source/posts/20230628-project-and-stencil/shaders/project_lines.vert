#version 460 core

// MB:
//      Lines and playerPosition are stored in a fixed NDC space
//      we aren't allowing the camera to be scaled or panned.


// WebGL doesn't support 1D textures
#if TARGETTING_WEBGL
layout(binding=0) uniform sampler2D lines;
#define LINES_TEXEL_FETCH(P) texelFetch(lines, ivec2((P), 0), 0)
#else // TARGETTING_WEBGL
layout(binding=0) uniform sampler1D lines;
#define LINES_TEXEL_FETCH(P) texelFetch(lines, (P), 0)
#endif // TARGETTING_WEBGL


layout(location=0) uniform vec2 playerPosition;


uint vertexIdToShadowVertexId(uint idx)
{
    // 0-----1
    // |  \  |
    // 4 __\ 2
    //  \   /
    //    3
    // 0 1 2 => 0, 1, 2
    // 3 4 5 => 2, 3, 4
    // 6 7 8 => 2, 4, 0
    switch(idx)
    {
        case 0u:
        case 8u:
            return 0u;
        case 1u:
            return 1u;
        case 2u:
        case 3u:
        case 6u:
            return 2u;
        case 4u:
            return 3u;
        default: // 5, 7
            return 4u;
    }
}


// Extends a line out into a 5-gon
//
// 0-----1
// |     |
// 4     2
//  \   /
//    3
//
// https://www.geogebra.org/calculator/gjz8fexq
vec2 getShadowCoord(vec2 P,
                    vec2 A,
                    vec2 B,
                    uint shadowVertexId)
{
    if(shadowVertexId == 0u) return A;
    if(shadowVertexId == 1u) return B;

    vec2 PB = B - P;

    float BInterval = max(0., max(
        ((PB.x >= 0. ? 1. : -1.) - B.x) / PB.x,
        ((PB.y >= 0. ? 1. : -1.) - B.y) / PB.y
    ));

    vec2 projectedB = B + BInterval * PB;
    if(shadowVertexId == 2u) return projectedB;

    vec2 PA = A - P;
    float AInterval = max(0., max(
            ((PA.x >= 0. ? 1. : -1.) - A.x) / PA.x,
            ((PA.y >= 0. ? 1. : -1.) - A.y) / PA.y
        ));

    vec2 projectedA = A + AInterval * PA;
    if(shadowVertexId == 4u) return projectedA;

    //
    // shadowVertexId == 3u
    //

    // vec2 halfVector = normalize(normalize(PA) + normalize(PB));
    // vec2 halfVector = normalize(PA * length(PB) + PB * length(PA));
    vec2 halfVector = (PA * length(PB) + PB * length(PA));

    vec2 axBy = vec2(projectedA.x, projectedB.y);
    vec2 bxAy = vec2(projectedB.x, projectedA.y);

    if(dot(halfVector, axBy - P) <= 0.) { axBy = vec2(0.); } 
    if(dot(halfVector, bxAy - P) <= 0.) { bxAy = vec2(0.); } 

    vec2 connectionXBias = (abs(axBy.x) > abs(bxAy.x)) ? axBy
                                                        : bxAy;

    vec2 connectionYBias = (abs(axBy.y) > abs(bxAy.y)) ? axBy
                                                        : bxAy;

    vec2 connectionPoint = (abs(connectionXBias.x) > abs(connectionYBias.y))
                            ? connectionXBias
                            : connectionYBias;

    return connectionPoint;
}


void main()
{
    vec4 line = LINES_TEXEL_FETCH(int(gl_VertexID / 9u));
    vec2 NDC = getShadowCoord(playerPosition,
                              line.xy,
                              line.zw,
                              vertexIdToShadowVertexId(gl_VertexID % 9u));
    gl_Position = vec4(NDC, 0., 1.);
}
