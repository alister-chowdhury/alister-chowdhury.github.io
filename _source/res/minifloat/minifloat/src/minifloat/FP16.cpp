#include "FP16.h"

#include <cmath>
#include <cstring>

#include "generic.h"

uint16_t f32_to_bfloat16(float f) {
  uint32_t v = asuint(f);
  // Propagate lower nan bits, so we don't
  // accidentally turn this into an inf.
  if (std::isnan(f) && (v & 0xffff)) {
    return (v >> 16) | 1u;
  }
  return rtne_trunc(v, 16);
}

float bfloat16_to_f32(uint16_t x) { return asfloat((uint32_t)x << 16); }

uint16_t f32_to_f16(float x) {
  return (uint16_t)generic_convert_from_f32(x, true, 5, 10);
}
float f16_to_f32(uint16_t x) { return generic_convert_to_f32(x, true, 5, 10); }

uint16_t f32_to_u11(float x) {
  return (uint16_t)generic_convert_from_f32(x, false, 5, 6);
}
float u11_to_f32(uint16_t x) { return generic_convert_to_f32(x, false, 5, 6); }

uint16_t f32_to_u10(float x) {
  return (uint16_t)generic_convert_from_f32(x, false, 5, 5);
}
float u10_to_f32(uint16_t x) { return generic_convert_to_f32(x, false, 5, 5); }

uint16_t f16_to_u11(uint16_t x) {
  // Clamp to 0, but allow NaNs to propagate
  if (x & 0x8000) {
    if (x < 0xfc01) {
      return 0;
    }
    return 0x7fff >> 4;
  } else if (x >= 0x7c01) {
    return 0x7fff >> 4;
  }
  return uint16_t(rtne_trunc(x, 4));
}

uint16_t f16_to_u10(uint16_t x) {
  // Clamp to 0, but allow NaNs to propagate
  if (x & 0x8000) {
    if (x < 0xfc01) {
      return 0;
    }
    return 0x7fff >> 5;
  } else if (x >= 0x7c01) {
    return 0x7fff >> 5;
  }
  return uint16_t(rtne_trunc(x, 5));
}
