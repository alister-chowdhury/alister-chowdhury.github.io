
#include "number_formats.h"

WASM_EXPORT
unsigned int r11g11b10(float r, float g, float b)
{

    unsigned int ri = (f32tof16(r) << 17) & 0xffe00000u;
    unsigned int gi = (f32tof16(g) << 6) & 0x001ffc00u;
    unsigned int bi = (f32tof16(b) >> 5) & 0x000003ffu;
    return ri | gi | bi;
}
