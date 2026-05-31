#ifndef MINIFLOAT_FP6_H
#define MINIFLOAT_FP6_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

// OCP-MX Formats
// https://www.opencompute.org/documents/ocp-microscaling-formats-mx-v1-0-spec-final-pdf
// No dedicated infinity or NaN.

// OCP-MX-E2M3
// 1.2.3
uint8_t f32_to_e2m3(float x);
float e2m3_to_f32(uint8_t x);

// OCP-MX-E3M2
// 1.3.2
uint8_t f32_to_e3m2(float x);
float e3m2_to_f32(uint8_t x);

#ifdef __cplusplus
}  // extern "C"
#endif  // __cplusplus

#endif  // MINIFLOAT_FP6_H