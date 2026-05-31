#include "FP19.h"

#include <cmath>

#include "generic.h"

uint32_t f32_to_tf32(float f) {
  uint32_t v = asuint(f);
  // Propagate lower nan bits, so we don't
  // accidentally turn this into an inf.
  if (std::isnan(f) && (v & 0x1fffu)) {
    return (v >> 13) | 1u;
  }
  return rtne_trunc(v, 13);
}

float tf32_to_f32(uint32_t x) { return asfloat((uint32_t)x << 13); }
