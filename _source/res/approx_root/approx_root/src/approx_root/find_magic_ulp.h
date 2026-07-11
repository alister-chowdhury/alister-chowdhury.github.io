#ifndef APPROX_ROOT_FIND_MAGIC_MAX_ULP_ERROR_H
#define APPROX_ROOT_FIND_MAGIC_MAX_ULP_ERROR_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

/*
 * Find a magic number for a given root that results in the lowest ulp error.
 *
 * @param iroot Inverse root to calculate, should be (0 < iroot < 1).
 * @return Calculated magic number.
 */
uint32_t find_magic_ulp_error(float iroot);

#ifdef __cplusplus
}  // extern "C"
#endif  // __cplusplus

#endif // APPROX_ROOT_FIND_MAGIC_MAX_ULP_ERROR_H
