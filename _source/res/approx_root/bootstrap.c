#include "approx_root/src/approx_root/find_magic_rel.h"
#include "approx_root/src/approx_root/find_magic_ulp.h"

#if defined(__wasm) || defined(__wasm__)
#if !(defined(__GNUC__) || defined(__clang__))
#error "Unsupported compiler for webassembly"
#endif  // !(defined(__GNUC__) || defined(__clang__))

#define WASM_EXPORT __attribute__((visibility("default")))

struct BruteRelMagicWorkspace relwp;
WASM_EXPORT uint32_t find_magic_rel_error_(float iroot) {
  return find_magic_rel_error(iroot, &relwp);
}

WASM_EXPORT uint32_t find_magic_rel_error_fast_(float iroot) {
  return find_magic_rel_error_fast(iroot);
}

WASM_EXPORT uint32_t find_magic_ulp_error_(float iroot) {
  return find_magic_ulp_error(iroot);
}

#else  // defined(__wasm) || defined(__wasm__)
#warning "Skipping wasm bootstrapping code, since not targetting wasm."
#endif  // defined(__wasm) || defined(__wasm__)
