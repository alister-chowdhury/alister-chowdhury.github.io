#ifndef NUMBER_FORMATS_H
#define NUMBER_FORMATS_H


#define WASM_EXPORT __attribute__((visibility("default")))

#if defined(__GNUC__) || defined(__clang__)
#define FORCEINLINE __attribute__((always_inline)) inline
#elif defined(_MSC_VER)
#define FORCEINLINE __forceinline
#else
#define FORCEINLINE inline
#endif


typedef union
{
    float        f;
    unsigned int u;
} bits32;


static FORCEINLINE unsigned int f32tou32(float x) { bits32 b = { .f = x }; return b.u; }
static FORCEINLINE float u32tof32(unsigned int x) { bits32 b = { .u = x }; return b.f; }


float f16tof32(unsigned int x);
unsigned int f32tof16(float x);
unsigned int r11g11b10(float r, float g, float b);

#endif // NUMBER_FORMATS_H
