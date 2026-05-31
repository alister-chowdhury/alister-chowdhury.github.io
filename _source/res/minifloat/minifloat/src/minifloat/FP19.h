#ifndef MINIFLOAT_FP19_H
#define MINIFLOAT_FP19_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

// Shortened IEEE 754 single-precision floating-point format (TensorFloat-32)
// 1.8.10
uint32_t f32_to_tf32(float f);
float tf32_to_f32(uint32_t x);

#ifdef __cplusplus
}  // extern "C"
#endif  // __cplusplus

#endif  // MINIFLOAT_FP19_H
