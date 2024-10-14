#ifndef COMPRESS_COMMON_H
#define COMPRESS_COMMON_H

#define WASM_EXPORT __attribute__((visibility("default")))

#if defined(__GNUC__) || defined(__clang__)
#define FORCEINLINE __attribute__((always_inline)) inline
#elif defined(_MSC_VER)
#define FORCEINLINE __forceinline
#else
#define FORCEINLINE inline
#endif

#endif // COMPRESS_COMMON_H
