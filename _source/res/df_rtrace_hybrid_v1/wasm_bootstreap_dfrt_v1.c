
#include <stddef.h>
#include <stdlib.h>
#include <math.h>

#include "dfrt_v1.h"


#if defined(__wasm) || defined(__wasm__)
#if !(defined(__GNUC__) || defined(__clang__))
#error "Unsupported compiler for webassembly"
#endif // !(defined(__GNUC__) || defined(__clang__))


#define WASM_EXPORT __attribute__((visibility("default")))


uint32_t    g_numLines;
float4*     g_inLines = 0;
uint32_t*   g_outDfTexture = 0;
uint32_t    g_outLineBufferCount = 0;
float4*     g_outLinesBuffer = 0;


WASM_EXPORT float4* getInputLinesBuffer() { return &g_inLines[0]; }
WASM_EXPORT uint32_t* getOutputDfTexture() { return &g_outDfTexture[0]; }
WASM_EXPORT uint32_t getOutputLinesBufferCount() { return g_outLineBufferCount; }
WASM_EXPORT float4* getOutputLinesBuffer() { return &g_outLinesBuffer[0]; }


static void resetInputs()
{
    free(g_inLines);
    g_inLines = 0;
    g_numLines = 0;
}

static void resetOutputs()
{
    free(g_outDfTexture);
    free(g_outLinesBuffer);
    g_outDfTexture = 0;
    g_outLinesBuffer = 0;
    g_outLineBufferCount = 0;
}


WASM_EXPORT int setNumInputLines(uint32_t numLines)
{
    resetInputs();
    resetOutputs();

    g_inLines = malloc(numLines * sizeof(float4));
    if(g_inLines)
    {
        g_numLines = numLines;
        return 1;
    }
    return 0;
}


WASM_EXPORT void prepareLines()
{
    DFRTV1PrepareLines(&g_inLines[0], g_numLines);
}


WASM_EXPORT int render(uint32_t res)
{
    resetOutputs();

    DFRTV1Inputs inputs = defaultDFRTV1Inputs();
    inputs.numLines = g_numLines;
    inputs.preparedLines = g_inLines;
    inputs.resolution = res;
    inputs.capturePadding = 1.0f;

    DFRTV1Outputs outputs = defaultDFRTV1Outputs();
    int ok = DFRTV1Render(&inputs, &outputs);

    g_outDfTexture = outputs.dfTexture;
    g_outLinesBuffer = outputs.lineBuffer;
    g_outLineBufferCount = outputs.lineBufferCount;

    return ok;
}

#else // defined(__wasm) || defined(__wasm__)
#warning "Skipping wasm bootstrapping code, since not targetting wasm."
#endif // defined(__wasm) || defined(__wasm__)
