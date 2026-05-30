#pragma once

#include <cmath>
#include <cstdint>
#include <cstring>

inline uint32_t asuint(const float x) {
  uint32_t y;
  std::memcpy(&y, &x, sizeof(x));
  return y;
}

inline float asfloat(const uint32_t x) {
  float y;
  std::memcpy(&y, &x, sizeof(x));
  return y;
}

// Round to nearest even and truncate.
// e.g, for a trunc_bits = 3
//
//  x000 - x011 = 0
//  x100        = tie breaker, use prefix bit (x)
//  x101 - x111 = 1
//
//   h = (1 << (3-1)) - 1 = 0b011
//   o = h + x            = 0b011 or 0b100
//   result               = (fv + o) >> 3
//
//  Rounded down:
//   0000x000 = (00001000 + 00000100 [00001100]) >> 3 = 00001
//              (00000000 + 00000011 [00000011]) >> 3 = 00000
//   0000x001 = (00001001 + 00000100 [00001101]) >> 3 = 00001
//              (00000001 + 00000011 [00000100]) >> 3 = 00000
//   0000x011 = (00001011 + 00000100 [00001111]) >> 3 = 00001
//              (00000011 + 00000011 [00000110]) >> 3 = 00000
//
//  Tie breaker:
//   0000x100 = (00001100 + 00000100 [00010000]) >> 3 = 00010 | rounded up
//              (00000100 + 00000011 [00000111]) >> 3 = 00000 | rounded down
//
//  Rounded up:
//   0000x101 = (00001101 + 00000100 [00010001]) >> 3 = 00010
//              (00000101 + 00000011 [00001000]) >> 3 = 00001
//   0000x110 = (00001110 + 00000100 [00010010]) >> 3 = 00010
//              (00000110 + 00000011 [00001001]) >> 3 = 00001
//   0000x111 = (00001111 + 00000100 [00010011]) >> 3 = 00010
//              (00000111 + 00000011 [00001010]) >> 3 = 00001
inline uint32_t rtne_trunc(uint32_t fv, uint32_t trunc_bits) {
  uint32_t h = (1u << (trunc_bits - 1)) - 1u;
  uint32_t o = ((fv >> trunc_bits) & 1u) + h;
  return (o + fv) >> trunc_bits;
}

inline float f32_bias(int8_t bias) {
  uint32_t r = 0x3f800000u;
  if (bias > 0) {
    r += uint32_t(bias) << 23;
  } else {
    r -= uint32_t(-bias) << 23;
  }
  return asfloat(r);
}

// When converting between f32 and a custom format, we scale down the f32,
// so the denormal ranges match up, making everything else a lot simpler.
//
// e.g:
//  f32 denormals are < 2^-126
//  f16 denormals are < 2^-14
//
//  If we scale a f32 down by 2^-112, then the entire conversion process
//  becomes a trivial exercise in bitshifting.
inline float f32_scale_factor(uint32_t e_mask_base, bool inv) {
  int8_t bias = int8_t(127 - (e_mask_base >> 1));
  return f32_bias(inv ? bias : -bias);
}

inline uint32_t generic_convert_from_f32(float f,
                                         bool has_sign,
                                         uint32_t exp_bits,
                                         uint32_t mant_bits,
                                         int8_t exp_bias     = 0,
                                         bool handle_nan_inf = true) {
  // Output precision is outside of the range supported by f32.
  if ((exp_bits > 8) || (mant_bits > 23)) {
    return 0xffffffffu;
  }

  const uint32_t e_mask_base = (1u << exp_bits) - 1u;
  const uint32_t m_mask_base = (1u << mant_bits) - 1u;

  const uint32_t e_mask = e_mask_base << mant_bits;
  const uint32_t m_mask = m_mask_base;

  f *= f32_bias(exp_bias);
  f *= f32_scale_factor(e_mask_base, false);

  uint32_t r = 0;
  uint32_t v = asuint(f);

  // Copy over sign
  if (v & 0x80000000u) {
    v &= 0x7fffffffu;
    if (has_sign) {
      r |= (1u << (exp_bits + mant_bits));
    }
    // If the value isn't a nan, clamp to 0.
    // Signalling NaNs will be converted to quiet NaNs.
    else if (v < 0x7f800001u) {
      return 0;
    }
  }

  // Handle NaNs
  if (handle_nan_inf) {
    if (v >= 0x7f800001u) {
      r |= (e_mask | m_mask);
      return r;
    }
  }

  const uint32_t trunc_bits = (23 - mant_bits);
  uint32_t vl               = rtne_trunc(v, trunc_bits);

  // Overflow to infinity
  if (handle_nan_inf) {
    if (vl >= e_mask) {
      vl = e_mask;
    }
  }

  r |= vl;
  return r;
}

inline float generic_convert_to_f32(uint32_t v,
                                    bool has_sign,
                                    uint32_t exp_bits,
                                    uint32_t mant_bits,
                                    int8_t exp_bias     = 0,
                                    bool handle_nan_inf = true) {
  // Output precision is outside of the range supported by f32.
  if ((exp_bits > 8) || (mant_bits > 23)) {
    return NAN;
  }

  const uint32_t e_mask_base = (1u << exp_bits) - 1u;
  const uint32_t e_mask      = e_mask_base << mant_bits;

  if (has_sign) {
    const uint32_t s = (1u << (exp_bits + mant_bits));
    has_sign         = (v & s);
    v &= ~s;
  }

  uint32_t vu = v << (23 - mant_bits);

  // Copy over sign
  if (has_sign) {
    vu |= 0x80000000u;
  }

  // Handle NaN/Inf
  if (handle_nan_inf) {
    if ((v & e_mask) == e_mask) {
      vu |= 0x7f800000u;
      return asfloat(vu);
    }
  }

  float f = asfloat(vu);
  f *= f32_scale_factor(e_mask_base, true);
  f *= f32_bias(-exp_bias);
  return f;
}
