#include "FP8.h"

#include <cmath>

#include "generic.h"

uint8_t f32_to_fp8(float x) {
  return (uint8_t)generic_convert_from_f32(x, true, 5, 2);
}

float fp8_to_f32(uint8_t x) { return generic_convert_to_f32(x, true, 5, 2); }

uint8_t f16_to_fp8(uint16_t x) {
  // Ensure NaNs propagate
  if (x & 0x8000) {
    if (x > 0xfc00) {
      return 0xff;
    }
  } else if (x >= 0x7c01) {
    return 0x7f;
  }
  return uint8_t(rtne_trunc(x, 8));
}

uint8_t f32_to_e4m3(float x, OFP8_SatMode sat_mode) {
  // Handle negatives (including -0), we're going to potentially
  // allow the value to overflow when converting.
  uint8_t s = 0x80 & (asuint(x) >> 24);

  // Handle NaNs
  if (std::isnan(x)) {
    return 0x7f | s;
  }

  if (x < 0.0f) {
    x = -x;
  }

  uint32_t v = generic_convert_from_f32(x, false, 4, 3, 0, false);
  if (v > 0x7e) {
    v = sat_mode == OPF8_Saturating ? 0x7e : 0x7f;
  }

  return uint8_t(v) | s;
}

float e4m3_to_f32(uint8_t x) {
  // Handle NaNs
  if ((x & 0x7f) == 0x7f) {
    return asfloat((x == 0x7f) ? 0x7fffffffu : 0xffffffffu);
  }
  return generic_convert_to_f32(x, true, 4, 3, 0, false);
}

static inline uint8_t e5m2_saturate(uint8_t x, OFP8_SatMode sat_mode) {
  if (sat_mode == OPF8_Saturating) {
    if (x == 0x7c) {
      return 0x7b;
    }
    if (x == 0xfc) {
      return 0xfb;
    }
  }
  return x;
}

uint8_t f32_to_e5m2(float x, OFP8_SatMode sat_mode) {
  uint8_t y = f32_to_fp8(x);
  return e5m2_saturate(y, sat_mode);
}

uint8_t f16_to_e5m2(uint16_t x, OFP8_SatMode sat_mode) {
  uint8_t y = f16_to_fp8(x);
  return e5m2_saturate(y, sat_mode);
}

uint8_t f32_to_e8m0(float x) {
  if (std::isnan(x)) {
    return 0xffu;
  }

  // Clamp negative values to 2^-127, there isn't anything in spec
  // about what to do with these, but I imagine most people would
  // naturally expect this.
  if (x <= 0.0f) {
    return 0u;
  }

  uint8_t r = uint8_t(rtne_trunc(asuint(x), 23));

  // Clamp inf to 2^127, spec also doesn't seems to say anything
  // about handling infinities, but I doubt most people want large
  // exponents to turn into a NaN.
  if (r == 0xffu) {
    r = 0xfeu;
  }
  return r;
}

float e8m0_to_f32(uint8_t x) {
  if (x == 0xffu) {
    return NAN;
  }
  // 0 is 2^-127, rather than 0, the rest maps directly to the exponent.
  if (!x) {
    return asfloat(0x400000u);
  }
  return asfloat(uint32_t(x) << 23);
}
