#pragma once

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

// Round to nearest even.
// e.g, for a trunc_bits = 3
//  x000 - x011 = 0
//  x100        = tie breaker, use prefix bit (x)
//  x101 - x111 = 1
inline bool rtne(uint32_t fv, uint32_t trunc_bits) {
  // Move the prefix bit to the lsb to bias tie-breakers.
  fv |= (fv >> trunc_bits) & 1u;
  uint32_t tie  = (1u << (trunc_bits - 1u));
  uint32_t mask = (1u << trunc_bits) - 1u;
  return ((fv & mask) > tie);
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
  uint32_t vl               = v >> trunc_bits;
  vl += rtne(v, trunc_bits);

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
    }
  }

  float f = asfloat(vu);
  f *= f32_scale_factor(e_mask_base, true);
  f *= f32_bias(-exp_bias);
  return f;
}
