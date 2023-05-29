#ifndef __MINSTL_MATH_H
#define __MINSTL_MATH_H

#include "__platform.h"


#if __MISTL_CPP
__MINSTL_FORCEINLINE int isnan(float __x) { return __builtin_isnan(__x); }
__MINSTL_FORCEINLINE int isnan(double __x) { return __builtin_isnan(__x); }

__MINSTL_FORCEINLINE int isinf(float __x) { return __builtin_isinf(__x); }
__MINSTL_FORCEINLINE int isinf(double __x) { return __builtin_isinf(__x); }

__MINSTL_FORCEINLINE int isfinite(float __x) { return __builtin_isfinite(__x); }
__MINSTL_FORCEINLINE int isfinite(double __x) { return __builtin_isfinite(__x); }

__MINSTL_FORCEINLINE int isnormal(float __x) { return __builtin_isnormal(__x); }
__MINSTL_FORCEINLINE int isnormal(double __x) { return __builtin_isnormal(__x); }

__MINSTL_FORCEINLINE int signbit(float __x) { return __builtin_signbit(__x); }
__MINSTL_FORCEINLINE int signbit(double __x) { return __builtin_signbit(__x); }

__MINSTL_FORCEINLINE int isunordered(float __x, float __y) { return __builtin_isunordered(__x, __x); }
__MINSTL_FORCEINLINE int isunordered(double __x, double __y) { return __builtin_isunordered(__x, __y); }

__MINSTL_FORCEINLINE int isless(float __x, float __y) { return __builtin_isless(__x, __x); }
__MINSTL_FORCEINLINE int isless(double __x, double __y) { return __builtin_isless(__x, __y); }

__MINSTL_FORCEINLINE int islessequal(float __x, float __y) { return __builtin_islessequal(__x, __x); }
__MINSTL_FORCEINLINE int islessequal(double __x, double __y) { return __builtin_islessequal(__x, __y); }

__MINSTL_FORCEINLINE int islessgreater(float __x, float __y) { return __builtin_islessgreater(__x, __x); }
__MINSTL_FORCEINLINE int islessgreater(double __x, double __y) { return __builtin_islessgreater(__x, __y); }

__MINSTL_FORCEINLINE int isgreater(float __x, float __y) { return __builtin_isgreater(__x, __x); }
__MINSTL_FORCEINLINE int isgreater(double __x, double __y) { return __builtin_isgreater(__x, __y); }

__MINSTL_FORCEINLINE int isgreaterequal(float __x, float __y) { return __builtin_isgreaterequal(__x, __x); }
__MINSTL_FORCEINLINE int isgreaterequal(double __x, double __y) { return __builtin_isgreaterequal(__x, __y); }
#endif // __MISTL_CPP


__MINSTL_EXTERN_C_START

#define FP_NAN       0
#define FP_INFINITE  1
#define FP_ZERO      2
#define FP_SUBNORMAL 3
#define FP_NORMAL    4

#define FP_ILOGBNAN 0x80000000
#define FP_ILOGB0   0x80000000

#define M_1_PI     0.31830988618379067154
#define M_2_PI     0.63661977236758134308
#define M_2_SQRTPI 1.12837916709551257390
#define M_E        2.7182818284590452354
#define M_LN10     2.30258509299404568402
#define M_LN2      0.69314718055994530942
#define M_LOG10E   0.43429448190325182765
#define M_LOG2E    1.4426950408889634074
#define M_PI       3.14159265358979323846
#define M_PI_2     1.57079632679489661923
#define M_PI_4     0.78539816339744830962
#define M_SQRT1_2  0.70710678118654752440
#define M_SQRT2    1.41421356237309504880

#define NAN       __builtin_nanf("")
#define INFINITY  __builtin_inff()


typedef double double_t;
typedef float float_t;


#if !__MISTL_CPP

#define isnan __builtin_isnan
#define isinf __builtin_isinf
#define isfinite __builtin_isfinite
#define isnormal __builtin_isnormal
#define signbit __builtin_signbit
#define isunordered __builtin_isunordered
#define isless __builtin_isless
#define islessequal __builtin_islessequal
#define islessgreater __builtin_islessgreater
#define isgreater __builtin_isgreater
#define isgreaterequal __builtin_isgreaterequal
#endif // !__MISTL_CPP


__MINSTL_FORCEINLINE float fabsf(float __x) { return __builtin_fabsf(__x); }
__MINSTL_FORCEINLINE double fabs(double __x) { return __builtin_fabs(__x); }
__MINSTL_FORCEINLINE float fmaf(float __x, float __y, float __z) { return __x * __y + __z; }
__MINSTL_FORCEINLINE double fma(double __x, double __y, double __z) { return __x * __y + __z; }
__MINSTL_FORCEINLINE double copysign(double __x, double __y) { return __builtin_copysign(__x, __y); }
__MINSTL_FORCEINLINE float copysignf(float __x, float __y) { return __builtin_copysignf(__x, __y); }
__MINSTL_FORCEINLINE float sqrtf(float __x) { return __builtin_sqrtf(__x); }
__MINSTL_FORCEINLINE double sqrt(double __x) { return __builtin_sqrt(__x); }
__MINSTL_FORCEINLINE float ceilf(float __x) { return __builtin_ceilf(__x); }
__MINSTL_FORCEINLINE double ceil(double __x) { return __builtin_ceil(__x); }
__MINSTL_FORCEINLINE float truncf(float __x) { return __builtin_truncf(__x); }
__MINSTL_FORCEINLINE double trunc(double __x) { return __builtin_trunc(__x); }
__MINSTL_FORCEINLINE float floorf(float __x) { return __builtin_floorf(__x); }
__MINSTL_FORCEINLINE double floor(double __x) { return __builtin_floor(__x); }
__MINSTL_FORCEINLINE float roundf(float __x) { return __builtin_nearbyintf(__x); }
__MINSTL_FORCEINLINE double round(double __x) { return __builtin_nearbyint(__x); }
__MINSTL_FORCEINLINE long lroundf(float __x) { return (long)roundf(__x); }
__MINSTL_FORCEINLINE long lround(double __x) { return (long)round(__x); }
__MINSTL_FORCEINLINE long long llroundf(float __x) { return (long long)roundf(__x); }
__MINSTL_FORCEINLINE long long llround(double __x) { return (long long)round(__x); }


double acos(double);
float acosf(float);
double acosh(double);
float acoshf(float);
double asin(double);
float asinf(float);
double asinh(double);
float asinhf(float);
double atan(double);
float atanf(float);
double atan2(double, double);
float atan2f(float, float);
double atanh(double);
float atanhf(float);
double cbrt(double);
float cbrtf(float);
double cos(double);
float cosf(float);
double cosh(double);
float coshf(float);
double erf(double);
float erff(float);
double erfc(double);
float erfcf(float);
double exp(double);
float expf(float);
double exp2(double);
float exp2f(float);
double expm1(double);
float expm1f(float);
double fdim(double, double);
float fdimf(float, float);
double fmax(double, double);
float fmaxf(float, float);
double fmin(double, double);
float fminf(float, float);
double fmod(double, double);
float fmodf(float, float);
double frexp(double, int*);
float frexpf(float, int*);
double hypot(double, double);
float hypotf(float, float);
int ilogb(double);
int ilogbf(float);
double lgamma(double);
float lgammaf(float);
double log(double);
float logf(float);
double log10(double);
float log10f(float);
double log1p(double);
float log1pf(float);
double log2(double);
float log2f(float);
double logb(double);
float logbf(float);
double modf(double, double*);
float modff(float, float*);
double nextafter(double, double);
float nextafterf(float, float);
double pow(double, double);
float powf(float, float);
double remainder(double, double);
float remainderf(float, float);
double remquo(double, double, int*);
float remquof(float, float, int*);
double sin(double);
float sinf(float);
double sinh(double);
float sinhf(float);
double tan(double);
float tanf(float);
double tanh(double);
float tanhf(float);
double tgamma(double);
float tgammaf(float);

__MINSTL_EXTERN_C_END


#endif // __MINSTL_MATH_H
