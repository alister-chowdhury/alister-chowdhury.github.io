#ifndef MINIFLOAT_FP8_H
#define MINIFLOAT_FP8_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

// Shortend IEEE 754 half-precision binary floating-point format
// 8bit
// 1.5.2
uint8_t f32_to_fp8(float x);
float fp8_to_f32(uint8_t x);

uint8_t f16_to_fp8(uint16_t x);
inline uint16_t fp8_to_f16(uint8_t x) { return (uint16_t)x << 8; }

inline uint8_t half_to_fp8(uint16_t x) { return f16_to_fp8(x); }
inline uint16_t fp8_to_half(uint8_t x) { return fp8_to_f16(x); }

// How to handle a value that exceeds the maximum magnitude.
//
// OCP 8-bit Floating Point Specification (OFP8)
// 5.2.1. Conversion Arithmetic
// https://www.opencompute.org/documents/ocp-8-bit-floating-point-specification-ofp8-revision-1-0-2023-12-01-pdf-1
enum OFP8_SatMode {
  OPF8_Saturating,    //  Generate the max normal OFP8 magnitude.
  OPF8_NonSaturating  //  E4M3 destination: generate a NaN
                      //  E5M2 destination: generate an infinity
};

// OFP8 Binary Interchange Format (E4M3)
// 1.4.3
// NaN = 0xff / 0x7f, no dedicated infinity.
uint8_t f32_to_e4m3(float x, enum OFP8_SatMode sat_mode);
float e4m3_to_f32(uint8_t x);

// OFP8 Binary Interchange Format (E5M2)
// 1.5.2
uint8_t f32_to_e5m2(float x, enum OFP8_SatMode sat_mode);
inline float e5m2_to_f32(uint8_t x) { return fp8_to_f32(x); }
uint8_t f16_to_e5m2(uint16_t x, enum OFP8_SatMode sat_mode);
inline uint16_t e5m2_to_f16(uint8_t x) { return fp8_to_f16(x); }
inline uint8_t half_to_e5m2(uint16_t x, enum OFP8_SatMode sat_mode) {
  return f16_to_e5m2(x, sat_mode);
}
inline uint16_t e5m2_to_half(uint8_t x) { return fp8_to_f16(x); }

// FNUZ variants
// exp_bias += 1
// No infinity, No negative 0, NaN = 0x80
uint8_t f32_to_e4m3fnuz(float x);
float e4m3fnuz_to_f32(uint8_t x);

uint8_t f32_to_e5m2fnuz(float x);
float e5m2fnuz_to_f32(uint8_t x);

// OCP-MX Formats
// https://www.opencompute.org/documents/ocp-microscaling-formats-mx-v1-0-spec-final-pdf

// OCP-MX-E8M0
// 0.8.0
// NaN = 0xff, no 0, no dedicated infinity.
uint8_t f32_to_e8m0(float x);
float e8m0_to_f32(uint8_t x);

#ifdef __cplusplus
}  // extern "C"
#endif  // __cplusplus

#endif  // MINIFLOAT_FP8_H
