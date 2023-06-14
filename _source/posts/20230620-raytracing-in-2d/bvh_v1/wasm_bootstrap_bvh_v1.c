
#include <stddef.h>

#include "bvh_v1.h"


#if defined(__wasm) || defined(__wasm__)
#if !(defined(__GNUC__) || defined(__clang__))
#error "Unsupported compiler for webassembly"
#endif // !(defined(__GNUC__) || defined(__clang__))


#define WASM_EXPORT __attribute__((visibility("default")))


#ifndef BVH_V1_USE_DYNAMIC_MEMORY
# if defined(__has_builtin) && __has_builtin(__builtin_wasm_memory_grow) && __has_builtin(__builtin_wasm_memory_size)
#  define BVH_V1_USE_DYNAMIC_MEMORY 1
# else
#  define BVH_V1_USE_DYNAMIC_MEMORY 0
# endif
#endif // BVH_V1_USE_DYNAMIC_MEMORY


// We know the exact amount of memory we will need is propotional to the number of lines.
// So we opt to do a single allocation and split it up manually, or if don't have access
// to dynamic memory, we used a fixed size amout, supporting some max number of lines.
#if BVH_V1_USE_DYNAMIC_MEMORY

// NB: These can't be marked as static, or the compiler is liable to optimize
// access to this wrongly!
float4*          g_linesBuffer;      // Input    [x0, y0, x1, y1]
BvhEntryV1*      g_bvhBuffer;        // Output
WorkingEntryV1*  g_workspaceBuffer;  // Scratch


#else // BVH_V1_USE_DYNAMIC_MEMORY

// No dynamic memory, use a fixed size buffer (gross I know).
#define MAX_LINES 0xffff
static float4           g_linesBuffer[MAX_LINES];        // Input    [x0, y0, x1, y1]
static BvhEntryV1       g_bvhBuffer[MAX_LINES];          // Output
static WorkingEntryV1   g_workspaceBuffer[MAX_LINES];    // Scratch


#endif // BVH_V1_USE_DYNAMIC_MEMORY


WASM_EXPORT int allocateLines(uint32_t numLines)
{

#if BVH_V1_USE_DYNAMIC_MEMORY

    const static size_t wasmPagesize    = 65536;
    static void* wasmHeap               = 0;
    static size_t wasmHeapSize          = 0;

    const static uint32_t perLineSize = sizeof(float4)           // Line
                                        + sizeof(BvhEntryV1)     // Output buffer
                                        + sizeof(WorkingEntryV1) // Workspace
                                        ;

    const static uint32_t maxLineCount = ~((uint32_t)0) / perLineSize;
    if(numLines >= maxLineCount)
    {
        return 0;
    }

    size_t requiredBytes = (size_t)perLineSize * (size_t)numLines;
    if(requiredBytes > wasmHeapSize)
    {
        if(wasmHeap == 0)
        {
            wasmHeap = (void*)(__builtin_wasm_memory_size(0) * wasmPagesize);
        }

        size_t extraPages = (requiredBytes - wasmHeapSize + wasmPagesize - 1) / wasmPagesize;

        // Failed to allocate extra pages :(
        if (__builtin_wasm_memory_grow(0, extraPages) == -1)
        {
            return 0;
        }

        size_t dataEnd = __builtin_wasm_memory_size(0) * wasmPagesize;
        wasmHeapSize = dataEnd - (size_t)wasmHeap;
    }

    g_linesBuffer       = (float4*)wasmHeap;
    g_bvhBuffer         = (BvhEntryV1*)((uintptr_t)wasmHeap + sizeof(float4) * numLines);
    g_workspaceBuffer   = (WorkingEntryV1*)((uintptr_t)wasmHeap + (sizeof(float4) + sizeof(BvhEntryV1)) * numLines);

#else // BVH_V1_USE_DYNAMIC_MEMORY

    if(numLines > MAX_LINES)
    {
        return 0;
    }

#endif // BVH_V1_USE_DYNAMIC_MEMORY

    return 1;
}



WASM_EXPORT float4* getLinesBuffer() { return &g_linesBuffer[0]; }
WASM_EXPORT BvhEntryV1* getBvhBuffer() { return &g_bvhBuffer[0]; }
WASM_EXPORT uint32_t buildBvh(uint32_t numLines)
{
    return buildBvhV1(numLines, &g_linesBuffer[0], &g_bvhBuffer[0], &g_workspaceBuffer[0]);
}


#else // defined(__wasm) || defined(__wasm__)
#warning "Skipping wasm bootstrapping code, since not targetting wasm."
#endif // defined(__wasm) || defined(__wasm__)
