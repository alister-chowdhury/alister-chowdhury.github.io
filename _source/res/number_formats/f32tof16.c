
#include "number_formats.h"

// Derived from ProjectPhysX at https://stackoverflow.com/a/60047308
WASM_EXPORT
float f16tof32(unsigned int x)
{
    // IEEE-754 16-bit floating-point format (without infinity): 1-5-10, exp-15, +-131008.0, +-6.1035156E-5,
    // +-5.9604645E-8, 3.311 digits
    const unsigned int e = (x & 0x7C00u) >> 10;      // exponent
    const unsigned int m = (x & 0x03FFu) << 13;      // mantissa
    const unsigned int v = f32tou32((float)m) >> 23; // evil log2 bit hack to count leading zeros in denormalized format
    return u32tof32((x & 0x8000u) << 16 | (e != 0u) * ((e + 112u) << 23 | m) |
                    ((e == 0) & (m != 0)) *
                        ((v - 37u) << 23 | ((m << (150u - v)) & 0x007FE000u))); // sign : normalized : denormalized
}

WASM_EXPORT
unsigned int f32tof16(float x)
{
    const unsigned int b = f32tou32(x) + 0x00001000u; // round-to-nearest-even: add last bit after truncated mantissa
    const unsigned int e = (b & 0x7F800000u) >> 23;   // exponent
    const unsigned int m = b & 0x007FFFFFu; // mantissa; in line below: 0x007FF000 = 0x00800000-0x00001000 = decimal
                                            // indicator flag - initial rounding
    return ((b & 0x80000000u) >> 16) | (e > 112u) * ((((e - 112u) << 10) & 0x7C00u) | m >> 13) |
           ((e < 113u) & (e > 101u)) * ((((0x007FF000u + m) >> (125u - e)) + 1) >> 1) |
           (e > 143u) * 0x7FFFu; // sign : normalized : denormalized : saturate
}
