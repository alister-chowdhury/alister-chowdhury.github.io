#ifndef APPROX_ROOT_COMMON_H
#define APPROX_ROOT_COMMON_H

#include <stdint.h>
#include <string.h>

#if defined(__GNUC__) || defined(__clang__)
#define FORCEINLINE __attribute__((always_inline)) inline
#elif defined(_MSC_VER)
#define FORCEINLINE __forceinline
#else
#define FORCEINLINE inline
#endif

FORCEINLINE uint32_t asuint(float x) {
  uint32_t z;
  memcpy(&z, &x, sizeof(x));
  return z;
}

FORCEINLINE float asfloat(uint32_t x) {
  float z;
  memcpy(&z, &x, sizeof(x));
  return z;
}

#endif // APPROX_ROOT_COMMON_H
