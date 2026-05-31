#include "FP6.h"

#include <cmath>

#include "generic.h"

uint8_t f32_to_e2m3(float x) {
  // Handle negatives (including -0), we're going to potentially
  // allow the value to overflow when converting.
  uint32_t u = asuint(x);
  uint8_t s  = 0x20 & (u >> 26);

  // There is no dedicated infinity / NaN
  // Infinity needs to be saturated and NaN is implementation defined (so we
  // saturate).
  if ((u & 0x7f800000u) == 0x7f800000u) {
    return s | 0x1f;
  }

  if (x < 0.0f) {
    x = -x;
  }

  uint32_t v = generic_convert_from_f32(x, false, 2, 3, 0, false);
  if (v > 0x1f) {
    v = 0x1f;
  }

  return uint8_t(v) | s;
}

float e2m3_to_f32(uint8_t x) {
  return generic_convert_to_f32(x, true, 2, 3, 0, false);
}

uint8_t f32_to_e3m2(float x) {
  // Handle negatives (including -0), we're going to potentially
  // allow the value to overflow when converting.
  uint32_t u = asuint(x);
  uint8_t s  = 0x20 & (u >> 26);

  // There is no dedicated infinity / NaN
  // Infinity needs to be saturated and NaN is implementation defined (so we
  // saturate).
  if ((u & 0x7f800000u) == 0x7f800000u) {
    return s | 0x1f;
  }

  if (x < 0.0f) {
    x = -x;
  }

  uint32_t v = generic_convert_from_f32(x, false, 3, 2, 0, false);
  if (v > 0x1f) {
    v = 0x1f;
  }
  return uint8_t(v) | s;
}

float e3m2_to_f32(uint8_t x) {
  return generic_convert_to_f32(x, true, 3, 2, 0, false);
}