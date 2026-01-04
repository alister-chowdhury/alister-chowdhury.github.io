#include "FP4.h"

#include <cmath>

#include "generic.h"

uint8_t f32_to_e2m1(float f) {
  uint8_t r = 0x0;
  // Handle negatives, we're going to potentially
  // allow the value to overflow when converting.
  if (f < 0.0f) {
    r |= 0x8;
    f = -f;
  }
  uint32_t v = generic_convert_from_f32(f, false, 2, 1, 0, false);
  if (v > 0x7) {
    v = 0x7;
  }
  return r | uint8_t(v);
}

float e2m1_to_f32(uint8_t x) {
  switch (x & 0xf) {
    case 0x0:
      return 0.0f;
    case 0x1:
      return 0.5f;
    case 0x2:
      return 1.0f;
    case 0x3:
      return 1.5f;
    case 0x4:
      return 2.0f;
    case 0x5:
      return 3.0f;
    case 0x6:
      return 4.0f;
    case 0x7:
      return 6.0f;
    case 0x8:
      return -0.0f;
    case 0x9:
      return -0.5f;
    case 0xa:
      return -1.0f;
    case 0xb:
      return -1.5f;
    case 0xc:
      return -2.0f;
    case 0xd:
      return -3.0f;
    case 0xe:
      return -4.0f;
    case 0xf:
      return -6.0f;
  }
  return NAN;
}

uint8_t f32_to_binary4p2sf(float f) {
  if (std::isnan(f)) {
    return 0x8;
  }
  if (f == 0.0f) {
    return 0x0;
  }
  return f32_to_e2m1(f);
}

float binary4p2sf_to_f32(uint8_t x) {
  switch (x & 0xf) {
    case 0x0:
      return 0.0f;
    case 0x1:
      return 0.5f;
    case 0x2:
      return 1.0f;
    case 0x3:
      return 1.5f;
    case 0x4:
      return 2.0f;
    case 0x5:
      return 3.0f;
    case 0x6:
      return 4.0f;
    case 0x7:
      return 6.0f;
    case 0x8:
      return NAN;
    case 0x9:
      return -0.5f;
    case 0xa:
      return -1.0f;
    case 0xb:
      return -1.5f;
    case 0xc:
      return -2.0f;
    case 0xd:
      return -3.0f;
    case 0xe:
      return -4.0f;
    case 0xf:
      return -6.0f;
  }
  return NAN;
}

float binary4p2se_to_f32(uint8_t x) {
  switch (x & 0xf) {
    case 0x0:
      return 0.0f;
    case 0x1:
      return 0.5f;
    case 0x2:
      return 1.0f;
    case 0x3:
      return 1.5f;
    case 0x4:
      return 2.0f;
    case 0x5:
      return 3.0f;
    case 0x6:
      return 4.0f;
    case 0x7:
      return INFINITY;
    case 0x8:
      return NAN;
    case 0x9:
      return -0.5f;
    case 0xa:
      return -1.0f;
    case 0xb:
      return -1.5f;
    case 0xc:
      return -2.0f;
    case 0xd:
      return -3.0f;
    case 0xe:
      return -4.0f;
    case 0xf:
      return -INFINITY;
  }
  return NAN;
}
