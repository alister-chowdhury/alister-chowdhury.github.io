#ifndef MINIFLOAT_FP4_H
#define MINIFLOAT_FP4_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

//     |.000|.001|.010|.011|.100|.101|.110|.111
// 0...|   0| 0.5|   1| 1.5|   2|   3|   4|   6
// 1...|  −0|−0.5|  −1|−1.5|  −2|  −3|  −4|  −6
uint8_t f32_to_e2m1(float f);
float e2m1_to_f32(uint8_t x);

//     |.000|.001|.010|.011|.100|.101|.110|.111
// 0...|   0| 0.5|   1| 1.5|   2|   3|   4|   6
// 1...| NaN|−0.5|  −1|−1.5|  −2|  −3|  −4|  −6
uint8_t f32_to_binary4p2sf(float f);
float binary4p2sf_to_f32(uint8_t x);

//     |.000|.001|.010|.011|.100|.101|.110|.111
// 0...|   0| 0.5|   1| 1.5|   2|   3|   4| Inf
// 1...| NaN|−0.5|  −1|−1.5|  −2|  −3|  −4|-Inf
inline uint8_t f32_to_binary4p2se(float f) { return f32_to_binary4p2sf(f); }
float binary4p2se_to_f32(uint8_t x);

#ifdef __cplusplus
}  // extern "C"
#endif  // __cplusplus

#endif  // MINIFLOAT_FP4_H
