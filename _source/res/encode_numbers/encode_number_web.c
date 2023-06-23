
#define GPU_NUMBER_ENCODING_E        10
#define GPU_NUMBER_ENCODING_DOT      11
#define GPU_NUMBER_ENCODING_PLUS     12
#define GPU_NUMBER_ENCODING_NEG      13
#define GPU_NUMBER_ENCODING_INVALID  14
#define GPU_NUMBER_ENCODING_EMPTY    15


typedef unsigned int uint;


#ifndef BUILD_LUT_ON_INIT
# if defined(__GNUC__) || defined(__clang__)
#   define BUILD_LUT_ON_INIT 1
# else // defined(__GNUC__) || defined(__clang__)
#   define BUILD_LUT_ON_INIT 0
# endif // defined(__GNUC__) || defined(__clang__)
# endif // BUILD_LUT_ON_INIT


// math.h is sometimes not available it would seem when
// compiling with clang, but since we have to set this up
// for clang, we might aswell avoid math.h completly for gcc.
// However, as it turns out, not using math.h makes the final
// wasm file smaller.
#ifndef NO_MATH_H
# if defined(__GNUC__) || defined(__clang__)
#   define NO_MATH_H 1
# else // defined(__GNUC__) || defined(__clang__)
#   define NO_MATH_H 0
# endif // defined(__GNUC__) || defined(__clang__)
#endif // NO_MATH_H


#if NO_MATH_H
# define floorf __builtin_floorf
# if defined(__clang__)
// clang wants __builtin_abs, gcc wants __builtin_fabs
#  define fabs __builtin_abs
# else // defined(__clang__)
#  define fabs __builtin_fabs
# endif // defined(__clang__)
# define isnan __builtin_isnan
static inline int isinf(float x)
{
    return (*((uint*)&x) & 0x7fffffffu) == 0x7f800000u;
}
#else // NO_MATH_H
# include <math.h>
#endif // NO_MATH_H


static float POW_10_LUT[39 - -45] = {
#if !BUILD_LUT_ON_INIT
    1e-45, 1e-44, 1e-43, 1e-42,
    1e-41, 1e-40, 1e-39, 1e-38,
    1e-37, 1e-36, 1e-35, 1e-34,
    1e-33, 1e-32, 1e-31, 1e-30,
    1e-29, 1e-28, 1e-27, 1e-26,
    1e-25, 1e-24, 1e-23, 1e-22,
    1e-21, 1e-20, 1e-19, 1e-18,
    1e-17, 1e-16, 1e-15, 1e-14,
    1e-13, 1e-12, 1e-11, 1e-10,
    1e-09, 1e-08, 1e-07, 1e-06,
    1e-05, 1e-04, 1e-03, 1e-02,
    1e-01, 1e+00, 1e+01, 1e+02,
    1e+03, 1e+04, 1e+05, 1e+06,
    1e+07, 1e+08, 1e+09, 1e+10,
    1e+11, 1e+12, 1e+13, 1e+14,
    1e+15, 1e+16, 1e+17, 1e+18,
    1e+19, 1e+20, 1e+21, 1e+22,
    1e+23, 1e+24, 1e+25, 1e+26,
    1e+27, 1e+28, 1e+29, 1e+30,
    1e+31, 1e+32, 1e+33, 1e+34,
    1e+35, 1e+36, 1e+37, 1e+38
#endif // !BUILD_LUT_ON_INIT
};


#if BUILD_LUT_ON_INIT

#if defined(__GNUC__) && !defined(__clang__)
__attribute__((optimize("no-unroll-loops")))
#endif // defined(__GNUC__) && !defined(__clang__)

static inline void initPow10Lut()
{
    double x = 1e-45;
    float* out = &POW_10_LUT[0];

#ifdef __clang__
#pragma clang loop unroll(disable)
#endif // __clang__
    for(int i=-45; i<39; ++i)
    {
        *out++ = x;
        x *= 10.0;
    }
}
#endif // BUILD_LUT_ON_INIT


static inline float fpow10(int n)
{
    if(n < -45) { return 0; }
    if(n > 38 ) { n = 38; } // 1e+38 = inf with float
   return POW_10_LUT[n + 45];
}


static inline int floorLog10(float x)
{
    int bits = *(int*)&x;
    float approxLog2 = (float)(((bits >> 23) & 0xff) - 127);
    int approxLog10 = (int)floorf(
        approxLog2
        * 0.3010299956639811952137f  // log10(2)
    );
    if(x >= fpow10(approxLog10+1))
    {
        ++approxLog10;
    }
    return approxLog10;
}


static inline float fractInputReturnFloor(float* input)
{
    float floored = floorf(*input);
    *input -= floored;
    return floored;
}


typedef struct RepBuffer
{
    uint    data;
    uint    index;
} RepBuffer;


static inline RepBuffer RepBuffer_init()
{
    RepBuffer repBuffer;
    repBuffer.data = 0;
    repBuffer.index = 0;
    return repBuffer;
}

static inline void RepBuffer_push(RepBuffer* repBuffer, uint value)
{
    repBuffer->data |= ((~value) & 15) << (4 * repBuffer->index++);
}

static inline void RepBuffer_pop(RepBuffer* repBuffer, uint count)
{
    if(count > repBuffer->index) { count = repBuffer->index; }
    uint mask = ~0;
    mask >>= ((count - repBuffer->index) * 4);
    repBuffer->data &= mask;
    repBuffer->index -= count;
}


static inline uint RepBuffer_remainingSpace(RepBuffer* repBuffer)
{
    return 8 - repBuffer->index;
}


static inline uint RepBuffer_get(RepBuffer* repBuffer)
{
    return ~repBuffer->data;
}


static inline uint RepBuffer_getZero()
{
/*
    RepBuffer repBuffer = RepBuffer_init();
    RepBuffer_push(&repBuffer, 0);
    RepBuffer_push(&repBuffer, GPU_NUMBER_ENCODING_DOT);
    RepBuffer_push(&repBuffer, 0);
    return RepBuffer_get(&repBuffer);
*/
    return 0xfffff0b0u;
}


static inline uint RepBuffer_getNan()
{
/*
    RepBuffer repBuffer = RepBuffer_init();
    RepBuffer_push(&repBuffer, GPU_NUMBER_ENCODING_INVALID);
    RepBuffer_push(&repBuffer, GPU_NUMBER_ENCODING_DOT);
    RepBuffer_push(&repBuffer, GPU_NUMBER_ENCODING_INVALID);
    return RepBuffer_get(&repBuffer);
*/
    return 0xfffffebeu;
}


static inline uint RepBuffer_getPosInf()
{
/*
    RepBuffer repBuffer = RepBuffer_init();
    RepBuffer_push(&repBuffer, GPU_NUMBER_ENCODING_PLUS);
    RepBuffer_push(&repBuffer, 9);
    RepBuffer_push(&repBuffer, GPU_NUMBER_ENCODING_E);
    RepBuffer_push(&repBuffer, GPU_NUMBER_ENCODING_PLUS);
    RepBuffer_push(&repBuffer, 9);
    RepBuffer_push(&repBuffer, 9);
    RepBuffer_push(&repBuffer, 9);
    RepBuffer_push(&repBuffer, 9);
    return RepBuffer_get(&repBuffer);
*/
    return 0x9999ca9cu;
}


static inline uint RepBuffer_getNegInf()
{
/*
    RepBuffer repBuffer = RepBuffer_init();
    RepBuffer_push(&repBuffer, GPU_NUMBER_ENCODING_NEG);
    RepBuffer_push(&repBuffer, 9);
    RepBuffer_push(&repBuffer, GPU_NUMBER_ENCODING_E);
    RepBuffer_push(&repBuffer, GPU_NUMBER_ENCODING_PLUS);
    RepBuffer_push(&repBuffer, 9);
    RepBuffer_push(&repBuffer, 9);
    RepBuffer_push(&repBuffer, 9);
    RepBuffer_push(&repBuffer, 9);
    return RepBuffer_get(&repBuffer);
*/
    return 0x9999ca9du;
}


static inline RepBuffer encodeWholeNumber(float x, int isInteger)
{
    RepBuffer repBuffer = RepBuffer_init();

    if(x < 0.0f)
    {
        x = -x;
        RepBuffer_push(&repBuffer, GPU_NUMBER_ENCODING_NEG);
    }

    int e10 = floorLog10(x);
    float d10 = fpow10(-e10);

    // Scale down
    x *= d10;

    // Apply rounding logic
    if(e10 < 7)
    {
        x += 0.5f * fpow10(-(int)(RepBuffer_remainingSpace(&repBuffer)) + 2);
    }

    // Deal with really odd case
    // where we round up enough to
    // change our current number
    if(x >= 10.0f)
    {
        x *= 0.1f;
        ++e10;
    }

    // Numbers >= 1, will also omit 0 for decimal numbers
    if(e10 >= 0)
    {
        for(int i=0; i<=e10; ++i)
        {
            uint decimal = (uint)fractInputReturnFloor(&x);
            x *= 10.0f;
            RepBuffer_push(&repBuffer, decimal);
        }

        // stop on whole numbers or if we'd just write a single decimal place
        if(isInteger || (RepBuffer_remainingSpace(&repBuffer) <= 1))
        {
            return repBuffer;
        }
    }

    // Decimals
    {
        // Include decimal place as zero we wish to strip
        uint writtenZeroes = 1;
        RepBuffer_push(&repBuffer, GPU_NUMBER_ENCODING_DOT);

        // Fill in 0's
        for(int i=0; i<(-e10-1); ++i)
        {
            RepBuffer_push(&repBuffer, 0);
            ++writtenZeroes;
        }

        // Use the remaining space for anything left
        uint budget = RepBuffer_remainingSpace(&repBuffer);
        for(uint i=0; i<budget; ++i)
        {
            uint decimal = (uint)fractInputReturnFloor(&x);
            x *= 10.0f;
            if(decimal == 0)
            {
                ++writtenZeroes;
            }
            else
            {
                writtenZeroes = 0;
            }
            RepBuffer_push(&repBuffer, decimal);
        }

        // Clear trailing 0's and possibly the decimal place
        RepBuffer_pop(&repBuffer, writtenZeroes);
    }

    return repBuffer;
}


static inline RepBuffer encodeEngNotation(float x)
{

    RepBuffer repBuffer = RepBuffer_init();

    if(x < 0.0f)
    {
        x = -x;
        RepBuffer_push(&repBuffer, GPU_NUMBER_ENCODING_NEG);
    }

    int e10 = (int)floorLog10(x);
    float d10 = fpow10(-e10);

    // Scale down
    x *= d10;

    uint budget = RepBuffer_remainingSpace(&repBuffer);

    // X.e+X
    budget -= 5;
    if(fabs(e10) >= 10)
    {
        budget -= 1;
    }

    // Apply rounding logic
    x += 0.5f * fpow10(-(int)budget);

    // Deal with really odd case
    // where we round up enough to
    // change our current number
    if(x >= 10.0f)
    {
        x *= 0.1f;
        // Even odder case where our budget decreases
        if(++e10 == 10)
        {
            budget -= 1;
        }
    }

    // First number and a dot
    {
        uint decimal = (uint)fractInputReturnFloor(&x);
        x *= 10.0f;
        RepBuffer_push(&repBuffer, decimal);
        RepBuffer_push(&repBuffer, GPU_NUMBER_ENCODING_DOT);
    }

    while(budget != 0)
    {
        uint decimal = (uint)fractInputReturnFloor(&x);
        x *= 10.0f;
        RepBuffer_push(&repBuffer, decimal);
        --budget;
    }

    RepBuffer_push(&repBuffer, GPU_NUMBER_ENCODING_E);
    RepBuffer_push(&repBuffer, (e10 < 0) ? GPU_NUMBER_ENCODING_NEG : GPU_NUMBER_ENCODING_PLUS);

    if(e10 < 0)
    {
        e10 = -e10;
    }

    // NB: We only handle two digit exponents (which is fine for floats)
    if(e10 >= 10)
    {
        RepBuffer_push(&repBuffer, (uint)(e10 / 10));
    }

    RepBuffer_push(&repBuffer, ((uint)e10) % 10);

    return repBuffer;
}


static inline int requiresEngineerNotationI32(int value)
{
    if(value < 0)
    {
        value = -value;
        return !(value < 10000000);
    }
    return !(value < 100000000);
}


static inline int requiresEngineerNotationU32(uint value)
{
    return !(value < 100000000u);
}


static inline int requiresEngineerNotationF32(float value)
{
    // This is the maximum float we can represent as an integer.
    // before errors start emerging, (8000011 will output 8000012).
    // Found purely by brute force.
    // If targetting integers, the range would be limited to
    // the digit budget: [-9999999, 99999999].
    const float maxValidFloat = 8000010.0f;
    if(value < 0)
    {
        value = -value;
        return !(value <= maxValidFloat && value >= 0.001);
    }
    return !(value <= maxValidFloat && value >= 0.0001);
}


static inline uint encodeNumberI32(int value)
{
    if(value == 0) { return RepBuffer_getZero(); }
    RepBuffer buf = requiresEngineerNotationI32(value)
                    ? encodeEngNotation((float)value)
                    : encodeWholeNumber((float)value, 1);
    return RepBuffer_get(&buf);
}


static inline uint encodeNumberU32(int value)
{
    if(value == 0) { return RepBuffer_getZero(); }
    RepBuffer buf = requiresEngineerNotationU32(value)
                    ? encodeEngNotation((float)value)
                    : encodeWholeNumber((float)value, 1);
    return RepBuffer_get(&buf);
}


static inline uint encodeNumberF32(float value)
{
    if(value == 0)      { return RepBuffer_getZero(); }
    if(isnan(value))    { return RepBuffer_getNan(); }
    if(isinf(value))
    {
        if(value > 0)
        {
            return RepBuffer_getPosInf();
        }
        return RepBuffer_getNegInf();
    }

    RepBuffer buf = requiresEngineerNotationF32(value)
                    ? encodeEngNotation(value)
                    : encodeWholeNumber(value, floorf(value) == value);
    return RepBuffer_get(&buf);
}




#define WASM_EXPORT __attribute__((visibility("default")))

WASM_EXPORT void init()
{
#if BUILD_LUT_ON_INIT
    initPow10Lut();
#endif // BUILD_LUT_ON_INIT
}


WASM_EXPORT uint encodeNumber(float value)
{
    return encodeNumberF32(value);
}
