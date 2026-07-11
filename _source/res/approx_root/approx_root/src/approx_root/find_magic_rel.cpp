#include "find_magic_rel.h"

#include <float.h>
#include <cmath>

#include "common.h"

template <typename GetRelBiasErrorFuncT>
FORCEINLINE uint32_t magic_solver_rel_bias(
    uint32_t lhs_magic, /* lower magic number (positive rel error)  */
    uint32_t rhs_magic, /* upper magic number (negative rel error) */
    GetRelBiasErrorFuncT& get_rel_bias_error /* function which returns the
                                                relative error of a magic */
) {
  float lhs_err = get_rel_bias_error(lhs_magic);
  float rhs_err = get_rel_bias_error(rhs_magic);

  while ((rhs_magic - lhs_magic) > 1) {
    // Lerp between both sides, weighting the bias (faster convergence, than
    // binary search)
    float a = std::abs(lhs_err) / (std::abs(lhs_err) + std::abs(rhs_err));
    uint32_t search_magic =
        lhs_magic + uint32_t((rhs_magic - lhs_magic) * a + 0.5f);

    if (search_magic <= lhs_magic) {
      search_magic = lhs_magic + 1u;
    }
    if (search_magic >= rhs_magic) {
      search_magic = rhs_magic - 1u;
    }

    float search_err = get_rel_bias_error(search_magic);
    if (search_err > 0.0f) {
      lhs_magic = search_magic;
      lhs_err   = search_err;
    } else {
      rhs_magic = search_magic;
      rhs_err   = search_err;
    }
  }

  return (std::abs(lhs_err) < std::abs(rhs_err)) ? lhs_magic : rhs_magic;
}

uint32_t find_magic_rel_error(float iroot,
                              struct BruteRelMagicWorkspace* workspace) {
  if (!workspace) {
    return 0u;
  }

  // Precalculate the initial approximation and ref value, this prevents us
  // from having to effectively call `pow` 8388608 times per iteration.
  uint32_t* const initial_approxs = workspace->initial_approxs;
  float* const ref_values         = workspace->ref_values;
  for (uint32_t it = 0u; it < 0x800000; ++it) {
    const uint32_t input_value = it + 0x3f800000u;
    initial_approxs[it]        = uint32_t(float(input_value) * iroot);
    ref_values[it]             = std::pow(asfloat(input_value), iroot);
  }

  auto get_rel_error_bias = [&](const uint32_t magic) -> float {
    float min_err = FLT_MAX;
    float max_err = -FLT_MAX;
    for (uint32_t it = 0u; it < 0x800000; ++it) {
      const float approx = asfloat(initial_approxs[it] + magic);
      const float ref    = ref_values[it];
      const float err    = (ref - approx) / ref;
      if (err < min_err) {
        min_err = err;
      }
      if (err > max_err) {
        max_err = err;
      }
    }
    return min_err + max_err;
  };

  // Delta from: `asuint(2.0f) - 1`
  const uint32_t lhs_magic =
      asuint(ref_values[0x7fffff]) - initial_approxs[0x7fffff];
  // Delta from `asuint(1.0f)`
  const uint32_t rhs_magic = asuint(ref_values[0]) - initial_approxs[0];
  return magic_solver_rel_bias(lhs_magic, rhs_magic, get_rel_error_bias);
}

uint32_t find_magic_rel_error_fast(float iroot) {
  // Working floating point format.
  // - f64 = will often match the brute a bit better
  // - f32 = faster
  using approx_fp_t = double;

  // 0x3fffffe0 is pretty much always where the most negative error
  // will be found, so we just compute this once and reuse it
  // NB: There are cases, especially for very small iroot values, where
  // this isn't true, but even then is a pretty reasonable metric
  const uint32_t ub_target         = 0x3fffffe0u;
  const float ub_correct           = std::pow(asfloat(ub_target), iroot);
  const uint32_t ub_initial_approx = uint32_t(approx_fp_t(ub_target) * iroot);

  const approx_fp_t root  = 1.0 / iroot;
  auto get_rel_error_bias = [&](const uint32_t magic) -> float {
    // Find the constatly shifting lower bound target, which should produce
    // the maximum positive relative error.
    const uint32_t lb_target =
        uint32_t(approx_fp_t(0x3f800000u - magic) * root);

    // Max positive rel error
    const float lb_correct           = std::pow(asfloat(lb_target), iroot);
    const uint32_t lb_initial_approx = uint32_t(approx_fp_t(lb_target) * iroot);
    const float lb_approx            = asfloat(lb_initial_approx + magic);
    const float lb_rel_error         = (lb_correct - lb_approx) / lb_correct;

    // Max negative rel error
    const float ub_approx    = asfloat(ub_initial_approx + magic);
    const float ub_rel_error = (ub_correct - ub_approx) / ub_correct;

    return lb_rel_error + ub_rel_error;
  };

  // Delta from: `asuint(2.0f) - 1`
  uint32_t lhs_magic = asuint(std::pow(asfloat(0x3fffffffu), iroot)) -
                       uint32_t(float(0x3fffffffu) * iroot);
  // Delta from `asuint(1.0f)`
  uint32_t rhs_magic = 0x3f800000u  // 1^x = 1
                       - uint32_t(float(0x3f800000u) * iroot);
  return magic_solver_rel_bias(lhs_magic, rhs_magic, get_rel_error_bias);
}

#if 0
// Test case
#include <chrono>
#include <cstdio>

BruteRelMagicWorkspace wp;

int main(void) {
  float iroot = 1.0f / 2.0f;

  const auto start       = std::chrono::high_resolution_clock::now();
  const uint32_t brute   = find_rel_error_magic_brute(iroot, &wp);
  const auto after_brute = std::chrono::high_resolution_clock::now();
  const uint32_t fast    = find_rel_error_magic_fast(iroot);
  const auto after_fast  = std::chrono::high_resolution_clock::now();

  printf("iroot = %f\n", iroot);
  const std::chrono::duration<double, std::milli> brute_time =
      after_brute - start;
  printf("brute = 0x%x [%f ms]\n", brute, brute_time.count());
  const std::chrono::duration<double, std::milli> fast_time =
      after_fast - after_brute;
  printf("fast = 0x%x [%f ms]\n", fast, fast_time.count());
}
#endif
