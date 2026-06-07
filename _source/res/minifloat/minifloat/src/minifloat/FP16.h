#ifndef MINIFLOAT_FP16_H
#define MINIFLOAT_FP16_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

// Shortened IEEE 754 single-precision floating-point format (bfloat16)
// 1.8.7
uint16_t f32_to_bfloat16(float f);
float bfloat16_to_f32(uint16_t x);

// IEEE 754 half-precision binary floating-point format (binary16)
// 1.5.10
uint16_t f32_to_f16(float x);
float f16_to_f32(uint16_t x);
inline uint16_t f32_to_half(float x) { return f32_to_f16(x); }
inline float half_to_f32(uint16_t x) { return f16_to_f32(x); }

// Shortend unsigned IEEE 754 half-precision binary floating-point format
// 11bit / 10bit unsigned float (R11G11B10)
// 0.5.6 / 0.5.5
uint16_t f32_to_u11(float x);
float u11_to_f32(uint16_t x);
uint16_t f32_to_u10(float x);
float u10_to_f32(uint16_t x);

uint16_t f16_to_u11(uint16_t x);
inline uint16_t u11_to_f16(uint16_t x) { return x << 4; }
uint16_t f16_to_u10(uint16_t x);
inline uint16_t u10_to_f16(uint16_t x) { return x << 5; }

inline uint16_t half_to_u11(uint16_t x) { return f16_to_u11(x); }
inline uint16_t u11_to_half(uint16_t x) { return u11_to_f16(x); }
inline uint16_t half_to_u10(uint16_t x) { return f16_to_u10(x); }
inline uint16_t u10_to_half(uint16_t x) { return u10_to_f16(x); }

// Shortend unsigned IEEE 754 half-precision binary floating-point format
// 14bit unsigned float (E5B9G9R9)
// 0.5.9
uint16_t f32_to_e5m9(float x);
float e5m9_to_f32(uint16_t x);

uint16_t f16_to_e5m9(uint16_t x);
inline uint16_t e5m9_to_f16(uint16_t x) { return x << 1; }

inline uint16_t half_to_e5m9(uint16_t x) { return f16_to_e5m9(x); }
inline uint16_t e5m9_to_half(uint16_t x) { return e5m9_to_f16(x); }

#ifdef __cplusplus
}  // extern "C"
#endif  // __cplusplus

#endif  // MINIFLOAT_FP16_H
