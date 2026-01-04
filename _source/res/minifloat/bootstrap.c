#include "minifloat/src/minifloat/FP16.h"
#include "minifloat/src/minifloat/FP4.h"
#include "minifloat/src/minifloat/FP8.h"

#if defined(__wasm) || defined(__wasm__)
#if !(defined(__GNUC__) || defined(__clang__))
#error "Unsupported compiler for webassembly"
#endif  // !(defined(__GNUC__) || defined(__clang__))

#define WASM_EXPORT __attribute__((visibility("default")))

#define WASM_EXPORT_WRAPPER_1(rettype, name, argtype) \
  WASM_EXPORT rettype name##_(argtype x) { return name(x); }

WASM_EXPORT_WRAPPER_1(uint8_t, f32_to_e2m1, float)
WASM_EXPORT_WRAPPER_1(float, e2m1_to_f32, uint8_t)

WASM_EXPORT_WRAPPER_1(uint8_t, f32_to_binary4p2sf, float)
WASM_EXPORT_WRAPPER_1(float, binary4p2sf_to_f32, uint8_t)

WASM_EXPORT_WRAPPER_1(uint8_t, f32_to_binary4p2se, float)
WASM_EXPORT_WRAPPER_1(float, binary4p2se_to_f32, uint8_t)

WASM_EXPORT_WRAPPER_1(uint8_t, f32_to_fp8, float)
WASM_EXPORT_WRAPPER_1(float, fp8_to_f32, uint8_t)

WASM_EXPORT_WRAPPER_1(uint8_t, f16_to_fp8, uint16_t)
WASM_EXPORT_WRAPPER_1(uint16_t, fp8_to_f16, uint8_t)

WASM_EXPORT uint8_t f32_to_e4m3_(float x, int saturate) {
  return f32_to_e4m3(x, saturate ? OPF8_Saturating : OPF8_NonSaturating);
}

WASM_EXPORT_WRAPPER_1(float, e4m3_to_f32, uint8_t)

WASM_EXPORT uint8_t f32_to_e5m2_(float x, int saturate) {
  return f32_to_e5m2(x, saturate ? OPF8_Saturating : OPF8_NonSaturating);
}

WASM_EXPORT_WRAPPER_1(float, e5m2_to_f32, uint8_t)

WASM_EXPORT uint8_t f16_to_e5m2_(uint8_t x, int saturate) {
  return f16_to_e5m2(x, saturate ? OPF8_Saturating : OPF8_NonSaturating);
}

WASM_EXPORT_WRAPPER_1(uint16_t, e5m2_to_f16, uint8_t)

WASM_EXPORT_WRAPPER_1(uint16_t, f32_to_bfloat16, float)
WASM_EXPORT_WRAPPER_1(float, bfloat16_to_f32, uint16_t)

WASM_EXPORT_WRAPPER_1(uint16_t, f32_to_f16, float)
WASM_EXPORT_WRAPPER_1(float, f16_to_f32, uint16_t)

WASM_EXPORT_WRAPPER_1(uint16_t, f32_to_u11, float)
WASM_EXPORT_WRAPPER_1(float, u11_to_f32, uint16_t)
WASM_EXPORT_WRAPPER_1(uint16_t, f32_to_u10, float)
WASM_EXPORT_WRAPPER_1(float, u10_to_f32, uint16_t)

WASM_EXPORT_WRAPPER_1(uint16_t, f16_to_u11, uint16_t)
WASM_EXPORT_WRAPPER_1(uint16_t, u11_to_f16, uint16_t)
WASM_EXPORT_WRAPPER_1(uint16_t, f16_to_u10, uint16_t)
WASM_EXPORT_WRAPPER_1(uint16_t, u10_to_f16, uint16_t)

#else  // defined(__wasm) || defined(__wasm__)
#warning "Skipping wasm bootstrapping code, since not targetting wasm."
#endif  // defined(__wasm) || defined(__wasm__)
