#include <math.h>
#include <stdint.h>


#if defined(__GNUC__) || defined(__clang__)
#define FORCEINLINE __attribute__((always_inline)) inline
#elif defined(_MSC_VER)
#define FORCEINLINE __forceinline
#else
#define FORCEINLINE inline
#endif


FORCEINLINE uint32_t asuint(float x)
{
    return ((union{ float f; uint32_t u;}){ .f = x }).u;
}


FORCEINLINE float asfloat(uint32_t x)
{
    return ((union{ float f; uint32_t u;}){ .u = x }).f;
}


FORCEINLINE float calc_approx_li(float value,
                              float invRoot,
                              float magic)
{
    return asfloat((uint32_t)((float)asuint(value) * invRoot + magic));
}


FORCEINLINE float calc_approx(float value,
                              float invRoot,
                              uint32_t magic)
{
    return asfloat((uint32_t)((float)asuint(value) * invRoot) + magic);
}


FORCEINLINE double calc_ulp_error_li(float value,
                                  float invRoot,
                                  float magic)
{
    uint32_t correct = asuint(powf(value, invRoot));
    uint32_t approx = asuint(calc_approx_li(value, invRoot, magic));
    return fabs((double)correct - (double)approx);
}


FORCEINLINE double calc_ulp_error(float value,
                                  float invRoot,
                                  uint32_t magic)
{
    uint32_t correct = asuint(powf(value, invRoot));
    uint32_t approx = asuint(calc_approx(value, invRoot, magic));
    return fabs((double)correct - (double)approx);
}


FORCEINLINE void calc_magic_ulp_error(float invRoot,
                                      uint32_t magic,
                                      int applyMagicAsFloat,
                                      double* out_max_ulp,
                                      double* out_avg_ulp)
{
    double max_ulp = 0.0f;
    double avg_ulp = 0.0f;

    // const uint32_t first = 0x3b800000u;     // 0.00390625f
    // const uint32_t end = 0x3f800001u;      // 1.0f + uint(1)

    const uint32_t first = 0x3f800000u; // 1.0f
    const uint32_t end = 0x40000000u;   // 2.0f

    if(applyMagicAsFloat)
    {
        float magicf = (float)magic;
        for(uint32_t i=first; i<end; ++i)
        {
            double err = calc_ulp_error_li(asfloat(i), invRoot, magicf);
            if(err > max_ulp) { max_ulp = err; }
            avg_ulp += err;
        }
    }
    else
    {
        for(uint32_t i=first; i<end; ++i)
        {
            double err = calc_ulp_error(asfloat(i), invRoot, magic);
            if(err > max_ulp) { max_ulp = err; }
            avg_ulp += err;
        }
    }

    double norm_factor = (end - first);
    *out_max_ulp = max_ulp;
    *out_avg_ulp = avg_ulp / norm_factor;
}


#define WASM_EXPORT __attribute__((visibility("default")))


double max_ulp_state;
double avg_ulp_state;


WASM_EXPORT double calc_magic_error(float invRoot, uint32_t magic, int applyMagicAsFloat)
{
    calc_magic_ulp_error(invRoot, magic, applyMagicAsFloat, &max_ulp_state, &avg_ulp_state);
    return max_ulp_state * (double)0xffffffff + avg_ulp_state;
}


WASM_EXPORT double get_max_ulp_err()
{
    return max_ulp_state;
}


WASM_EXPORT double get_avg_ulp_err()
{
    return avg_ulp_state;
}
