#version 460 core

#include "common.glsli"
#include "lights_common.glsli"


layout(binding=0) uniform sampler2D lightPlaneMap;

#if TARGETTING_WEBGL
layout(binding=1) uniform usampler2D lightingData;
#else // TARGETTING_WEBGL
layout(binding=1) uniform usampler1D lightingData;
#endif // TARGETTING_WEBGL

layout(location=0) out uvec4 outOOBox;


vec2 projectRay(vec3 planeAndDistance, float theta)
{
    vec2 rd = vec2(cos(theta), sin(theta));
    float denom = dot(planeAndDistance.xy, rd);

    // Prevent divisions by zero and excessive expansion at grazing angles
    float onedeg = 0.01745240643728351;
    if(abs(denom) <= onedeg)
    {
        return vec2(0);
    }

    float distToPlane = planeAndDistance.z / denom;
    return rd * distToPlane;
}

void main()
{
    int lineIndex = int(gl_FragCoord.x);

    vec2 ro = loadPointLightData(lightingData, lineIndex).position;

    // Assumed linemap resolution to be a power of 2
    int lightPlaneMapWidth = textureSize(lightPlaneMap, 0).x;
    float invTextureSizeTwoPi = rcpForPowersOf2(float(lightPlaneMapWidth)) * TWOPI;

    const float bias = 1.0;

    // Find initial furthest vector
    vec2 furthest = vec2(0);
    float furthestDistSq = -65504.0;

    for(int x=0; x < lightPlaneMapWidth; ++x)
    {
        vec3 planeAndDistance = texelFetch(lightPlaneMap, ivec2(x, lineIndex), 0).xyz;
             planeAndDistance.xy = planeAndDistance.xy * 2 - 1;

        float thetaLeft = (float(x) - bias) * invTextureSizeTwoPi;
        vec2 projectionLeft = projectRay(planeAndDistance, thetaLeft);
        float leftDistSq = dot(projectionLeft, projectionLeft);
        float thetaRight = (float(x) + bias) * invTextureSizeTwoPi;
        vec2 projectionRight = projectRay(planeAndDistance, thetaRight);
        float rightDistSq = dot(projectionRight, projectionRight);

        if(leftDistSq > furthestDistSq)
        {
            furthest = projectionLeft;
            furthestDistSq = leftDistSq;
        }

        if(rightDistSq > furthestDistSq)
        {
            furthest = projectionRight;
            furthestDistSq = rightDistSq;
        }
    }

    // Next find the furthest point from our first point
    vec2 furthestTangent = vec2(0);
    float furthestTangentDistSq = -65504.0;

    for(int x=0; x < lightPlaneMapWidth; ++x)
    {
        vec3 planeAndDistance = texelFetch(lightPlaneMap, ivec2(x, lineIndex), 0).xyz;
             planeAndDistance.xy = planeAndDistance.xy * 2 - 1;

        float thetaLeft = (float(x) - bias) * invTextureSizeTwoPi;
        vec2 projectionLeft = projectRay(planeAndDistance, thetaLeft);
        float leftDistSq = dot(projectionLeft - furthest, projectionLeft - furthest);
        float thetaRight = (float(x) + bias) * invTextureSizeTwoPi;
        vec2 projectionRight = projectRay(planeAndDistance, thetaRight);
        float rightDistSq = dot(projectionRight - furthest, projectionRight - furthest);

        if(leftDistSq > furthestTangentDistSq)
        {
            furthestTangent = projectionLeft;
            furthestTangentDistSq = leftDistSq;
        }

        if(rightDistSq > furthestTangentDistSq)
        {
            furthestTangent = projectionRight;
            furthestDistSq = rightDistSq;
        }
    }

    vec2 L0 = furthest;
    vec2 L1 = furthestTangent;

    // All remaining points should lie either left or right of our computed line
    //
    // TODO: Pretty sure, it should be possible to have a different left and right
    //       value for L0 and L1, for a potentially tighter result.
    float CDist = 0.0;
    float DDist = 0.0;

    vec2 Ld = normalize(L1 - L0);
    vec2 Ln = vec2(Ld.y, -Ld.x);
    float Lw = dot(Ln, L0);

    for(int x=0; x < lightPlaneMapWidth; ++x)
    {
        vec3 planeAndDistance = texelFetch(lightPlaneMap, ivec2(x, lineIndex), 0).xyz;
             planeAndDistance.xy = planeAndDistance.xy * 2 - 1;

        float thetaLeft = (float(x) - bias) * invTextureSizeTwoPi;
        vec2 projectionLeft = projectRay(planeAndDistance, thetaLeft);
        float leftDist = dot(projectionLeft, Ln) - Lw;
        
        float thetaRight = (float(x) + bias) * invTextureSizeTwoPi;
        vec2 projectionRight = projectRay(planeAndDistance, thetaRight);
        float rightDist = dot(projectionRight, Ln) - Lw;

        if(leftDist < 0)
        {
            if(abs(leftDist) > abs(CDist))
            {
                CDist = leftDist;
            }
        }
        else
        {
            if(leftDist > DDist)
            {
                DDist = leftDist;
            }
        }

        if(rightDist < 0)
        {
            if(abs(rightDist) > abs(CDist))
            {
                CDist = rightDist;
            }
        }
        else
        {
            if(rightDist > DDist)
            {
                DDist = rightDist;
            }
        }
    }

    vec2 A = furthest + Ln * CDist;
    vec2 B = furthest + Ln * DDist;
    vec2 C = furthestTangent + Ln * DDist;
    vec2 D = furthestTangent + Ln * CDist;

    outOOBox = uvec4(packHalf2x16(A + ro),
                     packHalf2x16(B + ro),
                     packHalf2x16(C + ro),
                     packHalf2x16(D + ro));
}
