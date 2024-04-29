
#version 460 core
#extension GL_EXT_samplerless_texture_functions : require

layout(set=0, binding=0)  uniform texture2D inTexture;
layout(location=0)        out uvec2 outValue;


uvec2 makeBlock(float a, float b, uvec4 quantR0, uvec4 quantR1, uvec4 quantR2, uvec4 quantR3)
{
    quantR0 <<= uvec4(0u, 3u, 6u, 9u);
    quantR1 <<= uvec4(12u, 15u, 18u, 21u);
    quantR2 <<= uvec4(0u, 3u, 6u, 9u);
    quantR3 <<= uvec4(12u, 15u, 18u, 21u);

    uint quant0 = quantR0.x | quantR0.y | quantR0.z | quantR0.w
                | quantR1.x | quantR1.y | quantR1.z | quantR1.w
                ;

    uint quant1 = quantR2.x | quantR2.y | quantR2.z | quantR2.w
                | quantR3.x | quantR3.y | quantR3.z | quantR3.w
                ;


    uint aBits = uint(a * 255.0f);
    uint bBits = uint(b * 255.0f);

    return uvec2(
        bBits | (aBits << 8) | (quant0 << 16),
        (quant0 >> 16) | (quant1 << 8)
    );
}


void finalizeValueMode0(inout uint value)
{
    value = 7u - value;
    if(value != 0) { ++value; }
    if(value == 8) { value = 1; }
}


void finalizeValueMode0(inout uvec4 value)
{
    finalizeValueMode0(value.x);
    finalizeValueMode0(value.y);
    finalizeValueMode0(value.z);
    finalizeValueMode0(value.w);
}


uvec2 packMode0(vec4 R0, vec4 R1, vec4 R2, vec4 R3, float a, float b)
{
    float scale = 7.0f / (b - a);
    
    vec4 projR0 = (R0 - a) * scale + 0.5f;
    vec4 projR1 = (R1 - a) * scale + 0.5f;
    vec4 projR2 = (R2 - a) * scale + 0.5f;
    vec4 projR3 = (R3 - a) * scale + 0.5f;

    uvec4 quantR0 = uvec4(clamp(ivec4(projR0), ivec4(0), ivec4(7)));
    uvec4 quantR1 = uvec4(clamp(ivec4(projR1), ivec4(0), ivec4(7)));
    uvec4 quantR2 = uvec4(clamp(ivec4(projR2), ivec4(0), ivec4(7)));
    uvec4 quantR3 = uvec4(clamp(ivec4(projR3), ivec4(0), ivec4(7)));

    finalizeValueMode0(quantR0);
    finalizeValueMode0(quantR1);
    finalizeValueMode0(quantR2);
    finalizeValueMode0(quantR3);

    return makeBlock(a, b, quantR0, quantR1, quantR2, quantR3);
}


void main()
{
    ivec2 coord = ivec2(gl_FragCoord.xy) << 2;

    // No gathers in ESSL 300
    vec4 R0 = vec4(
        texelFetch(inTexture, coord + ivec2(0, 0), 0).x,
        texelFetch(inTexture, coord + ivec2(1, 0), 0).x,
        texelFetch(inTexture, coord + ivec2(2, 0), 0).x,
        texelFetch(inTexture, coord + ivec2(3, 0), 0).x
    );
    vec4 R1 = vec4(
        texelFetch(inTexture, coord + ivec2(0, 1), 0).x,
        texelFetch(inTexture, coord + ivec2(1, 1), 0).x,
        texelFetch(inTexture, coord + ivec2(2, 1), 0).x,
        texelFetch(inTexture, coord + ivec2(3, 1), 0).x
    );
    vec4 R2 = vec4(
        texelFetch(inTexture, coord + ivec2(0, 2), 0).x,
        texelFetch(inTexture, coord + ivec2(1, 2), 0).x,
        texelFetch(inTexture, coord + ivec2(2, 2), 0).x,
        texelFetch(inTexture, coord + ivec2(3, 2), 0).x
    );
    vec4 R3 = vec4(
        texelFetch(inTexture, coord + ivec2(0, 3), 0).x,
        texelFetch(inTexture, coord + ivec2(1, 3), 0).x,
        texelFetch(inTexture, coord + ivec2(2, 3), 0).x,
        texelFetch(inTexture, coord + ivec2(3, 3), 0).x
    );

    vec4 min4 = min(min(R0, R1), min(R2, R3));
    vec4 max4 = max(max(R0, R1), max(R2, R3));
    vec2 ranges = vec2(
        min(min(min4.x, min4.y), min(min4.z, min4.w)),
        max(max(max4.x, max4.y), max(max4.z, max4.w))
    );

    outValue = packMode0(R0, R1, R2, R3, ranges.x, ranges.y);

}
