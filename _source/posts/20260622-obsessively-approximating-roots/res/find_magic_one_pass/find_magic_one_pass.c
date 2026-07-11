#include <math.h>
#include <stdint.h>

#if defined(__GNUC__) || defined(__clang__)
#define FORCEINLINE __attribute__((always_inline)) inline
#elif defined(_MSC_VER)
#define FORCEINLINE __forceinline
#else
#define FORCEINLINE inline
#endif

FORCEINLINE uint32_t asuint(float x) {
  return ((union {
           float f;
           uint32_t u;
         }){.f = x})
      .u;
}

FORCEINLINE float asfloat(uint32_t x) {
  return ((union {
           float f;
           uint32_t u;
         }){.u = x})
      .f;
}

typedef struct CalcMagicExtra_ {
  uint32_t delta_min_input;
  uint32_t delta_max_input;
  uint32_t delta_min;
  uint32_t delta_max;
} CalcMagicExtra;

uint32_t calc_root_magic_(float inv_root, CalcMagicExtra* out_extras) {
  CalcMagicExtra working;
  working.delta_min = 0xffffffffu;
  working.delta_max = 0u;

  // [1, 2)
  for (uint32_t input = 0x3f800000u; input < 0x40000000; ++input) {
    // Initial approximation, pre correction
    uint32_t initial_adj = (uint32_t)((float)input * inv_root);

    // The actual pow value we're trying to match against
    uint32_t ref_value = asuint(powf(asfloat(input), inv_root));

    // Pick the mid point between the min and max extremes
    uint32_t delta = ref_value - initial_adj;

    if (delta < working.delta_min) {
      working.delta_min_input = input;
      working.delta_min       = delta;
    }
    if (delta > working.delta_max) {
      working.delta_max_input = input;
      working.delta_max       = delta;
    }
  }

  if (out_extras) {
    *out_extras = working;
  }

  // (delta_min + delta_max) >> 1, without overflow;
  uint32_t magic = (working.delta_min & working.delta_max) +
                   ((working.delta_min ^ working.delta_max) >> 1);
  return magic;
}

#define WASM_EXPORT __attribute__((visibility("default")))

CalcMagicExtra extras_state;

WASM_EXPORT uint32_t calc_root_magic(float inv_root) {
  return calc_root_magic_(inv_root, &extras_state);
}

WASM_EXPORT uint32_t get_delta_min_input() {
  return extras_state.delta_min_input;
}
WASM_EXPORT uint32_t get_delta_max_input() {
  return extras_state.delta_max_input;
}
WASM_EXPORT uint32_t get_delta_min() { return extras_state.delta_min; }
WASM_EXPORT uint32_t get_delta_max() { return extras_state.delta_max; }
