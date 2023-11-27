#ifndef DFRT_V1_H
#define DFRT_V1_H

#include <stdint.h>


#if defined(__GNUC__) || defined(__clang__)
#define DFRT_V1_FORCEINLINE __attribute__((always_inline)) inline
#elif defined(_MSC_VER)
#define DFRT_V1_FORCEINLINE __forceinline
#else
#define DFRT_V1_FORCEINLINE inline
#endif


typedef struct
{
    float x, y;
} float2;


typedef struct
{
    float x, y, z, w;
} float4;


typedef struct
{
    uint32_t    numLines;
    float4*     preparedLines;
    uint32_t    resolution;
    float       capturePadding;
} DFRTV1Inputs;


typedef struct
{
    uint32_t*   dfTexture;
    float4*     lineBuffer;
    uint32_t    lineBufferCount;
} DFRTV1Outputs;


DFRT_V1_FORCEINLINE DFRTV1Inputs defaultDFRTV1Inputs()
{
    DFRTV1Inputs result;
    result.numLines = 0;
    result.preparedLines = 0;
    result.resolution = 128;
    result.capturePadding = 1.0f;
    return result;
}


DFRT_V1_FORCEINLINE DFRTV1Outputs defaultDFRTV1Outputs()
{
    DFRTV1Outputs result;
    result.dfTexture = 0;
    result.lineBuffer = 0;
    result.lineBufferCount = 0;
    return result;
}


#ifdef __cplusplus
extern "C"
{
#endif // __cplusplus


/* Transforms lines into: [x0, y0, dx, dy] to simplify subsequent operations. */
void DFRTV1PrepareLines(float4* lines, uint32_t numLines);


/* Renders the DFRTV1 texture and generates a linebuffer to be updated.
 * dfTexture and lineBuffer need to be free'd by the callee.
 */
int DFRTV1Render(const DFRTV1Inputs* inputs, DFRTV1Outputs* outputs);


#ifdef __cplusplus
} // extern "C"
#endif // __cplusplus

#endif // DFRT_V1_H
