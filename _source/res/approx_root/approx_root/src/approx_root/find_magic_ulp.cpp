#include "find_magic_ulp.h"

#include <cmath>

#include "common.h"

FORCEINLINE uint32_t find_magic_ulp_inner(float iroot,
                                          const uint32_t delta_min_start,
                                          const uint32_t delta_min_end,
                                          const uint32_t delta_max_start,
                                          const uint32_t delta_max_end) {
  uint32_t delta_min = 0xffffffffu;
  uint32_t delta_max = 0u;

  // Calculate delta_max
  for (uint32_t input = delta_max_start; input <= delta_max_end; ++input) {
    // Initial approximation, pre correction
    uint32_t initial_adj = (uint32_t)((float)input * iroot);
    // The actual pow value we're trying to match against
    uint32_t ref_value = asuint(std::pow(asfloat(input), iroot));
    // Pick the mid point between the min and max extremes
    uint32_t delta = ref_value - initial_adj;
    if (delta >= delta_max) {
      delta_max = delta;
    }
  }

  // Calculate delta_min
  for (uint32_t input = delta_min_start; input <= delta_min_end; ++input) {
    // Initial approximation, pre correction
    uint32_t initial_adj = (uint32_t)((float)input * iroot);
    // The actual pow value we're trying to match against
    uint32_t ref_value = asuint(std::pow(asfloat(input), iroot));
    // Pick the mid point between the min and max extremes
    uint32_t delta = ref_value - initial_adj;
    if (delta <= delta_min) {
      delta_min = delta;
    }
  }

  // (delta_min + delta_max) >> 1, without overflow;
  uint32_t magic = (delta_min & delta_max) + ((delta_min ^ delta_max) >> 1);
  return magic;
}

uint32_t find_magic_ulp_error(float iroot) {
  uint32_t delta_min_start = 0x3fff81ecu;
  uint32_t delta_min_end   = 0x3fffffe0u;
  uint32_t delta_max_start = 0x3f800020u;
  uint32_t delta_max_end   = 0x3f80aa20u;

  switch (asuint(iroot) >> 23) {
    case (0x38000000u >> 23): {
      delta_min_start = 0x3fff81ecu;
      delta_min_end   = 0x3fffffe0u;
      delta_max_start = 0x3f802020u;
      delta_max_end   = 0x3f80771au;
      break;
    }
    case (0x38800000u >> 23): {
      delta_min_start = 0x3fffc077u;
      delta_min_end   = 0x3fffffe0u;
      delta_max_start = 0x3f801020u;
      delta_max_end   = 0x3f807b5cu;
      break;
    }
    case (0x39000000u >> 23): {
      delta_min_start = 0x3fffe06au;
      delta_min_end   = 0x3fffffe0u;
      delta_max_start = 0x3f800820u;
      delta_max_end   = 0x3f8076dbu;
      break;
    }
    case (0x39800000u >> 23): {
      delta_min_start = 0x3ffff061u;
      delta_min_end   = 0x3fffffe0u;
      delta_max_start = 0x3f800420u;
      delta_max_end   = 0x3f80795fu;
      break;
    }
    case (0x3a000000u >> 23): {
      delta_min_start = 0x3ffff860u;
      delta_min_end   = 0x3fffffe0u;
      delta_max_start = 0x3f800220u;
      delta_max_end   = 0x3f80765fu;
      break;
    }
    case (0x3a800000u >> 23): {
      delta_min_start = 0x3ffffc60u;
      delta_min_end   = 0x3fffffe0u;
      delta_max_start = 0x3f800120u;
      delta_max_end   = 0x3f807a9cu;
      break;
    }
    case (0x3b000000u >> 23): {
      delta_min_start = 0x3ffffe60u;
      delta_min_end   = 0x3fffffe0u;
      delta_max_start = 0x3f8000a0u;
      delta_max_end   = 0x3f807a1cu;
      break;
    }
    case (0x3b800000u >> 23): {
      delta_min_start = 0x3fffff60u;
      delta_min_end   = 0x3fffffe0u;
      delta_max_start = 0x3f80005fu;
      delta_max_end   = 0x3f807c5eu;
      break;
    }
    case (0x3c000000u >> 23): {
      delta_min_start = 0x3fffffe0u;
      delta_min_end   = 0x3fffffe0u;
      delta_max_start = 0x3f8000a0u;
      delta_max_end   = 0x3f807bdfu;
      break;
    }
    case (0x3c800000u >> 23): {
      delta_min_start = 0x3fffffe0u;
      delta_min_end   = 0x3fffffe0u;
      delta_max_start = 0x3f800020u;
      delta_max_end   = 0x3f806b9eu;
      break;
    }
    case (0x3d000000u >> 23): {
      delta_min_start = 0x3fffffe0u;
      delta_min_end   = 0x3fffffe0u;
      delta_max_start = 0x3f800020u;
      delta_max_end   = 0x3f80785fu;
      break;
    }
    case (0x3d800000u >> 23): {
      delta_min_start = 0x3fffffe0u;
      delta_min_end   = 0x3fffffe0u;
      delta_max_start = 0x3f800020u;
      delta_max_end   = 0x3f807d20u;
      break;
    }
    case (0x3e000000u >> 23): {
      delta_min_start = 0x3fffffe0u;
      delta_min_end   = 0x3fffffe0u;
      delta_max_start = 0x3f800020u;
      delta_max_end   = 0x3f808ba0u;
      break;
    }
    case (0x3e800000u >> 23): {
      delta_min_start = 0x3fffffe0u;
      delta_min_end   = 0x3fffffe0u;
      delta_max_start = 0x3f800020u;
      delta_max_end   = 0x3f80aa20u;
      break;
    }
    default:
      break;
  }

  return find_magic_ulp_inner(iroot, delta_min_start, delta_min_end,
                              delta_max_start, delta_max_end);
}
