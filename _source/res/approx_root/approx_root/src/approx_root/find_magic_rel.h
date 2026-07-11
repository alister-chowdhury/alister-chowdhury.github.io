#ifndef APPROX_ROOT_FIND_MAGIC_MAX_REL_ERROR_H
#define APPROX_ROOT_FIND_MAGIC_MAX_REL_ERROR_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

// 64MB, probably don't want to allocate on the stack.
struct BruteRelMagicWorkspace {
  uint32_t initial_approxs[0x800000];
  float ref_values[0x800000];
};

/*
 * Find a magic number for a given root that results in the lowest relative
 * error. Returning where (max pos err + max neg err) converge towards 0.
 *
 * @param iroot Inverse root to calculate, should be (0 < iroot < 1).
 * @param workspace Working space to prevent excessivly recalculations.
 * @return Calculated magic number (or 0 if workspace is a nullptr).
 */
uint32_t find_magic_rel_error(float iroot,
                              struct BruteRelMagicWorkspace* workspace);

/*
 * Faster variant, approximates where the max pos/neg err would be located.
 * Is liable to be off by a few values (in practice the difference is ~1e-7).
 * Often around 5 orders of magnitude faster than the other method.
 *
 * @param iroot Inverse root to calculate, should be (0 < iroot < 1).
 * @return Calculated magic number.
 */
uint32_t find_magic_rel_error_fast(float iroot);

#ifdef __cplusplus
}  // extern "C"
#endif  // __cplusplus

#endif // APPROX_ROOT_FIND_MAGIC_MAX_REL_ERROR_H
