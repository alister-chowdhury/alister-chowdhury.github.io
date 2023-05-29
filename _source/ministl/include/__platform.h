#ifndef __MINSTL__PLATFORM_H
#define __MINSTL__PLATFORM_H


#if defined(__cplusplus)
#define __MISTL_CPP             1
#define __MINSTL_EXTERN_C_START extern "C" {
#define __MINSTL_EXTERN_C_END   }
#else // defined(__cplusplus)
#define __MISTL_CPP             0
#define __MINSTL_EXTERN_C_START
#define __MINSTL_EXTERN_C_END
#endif // defined(__cplusplus)



#define __MINSTL_FORCEINLINE __attribute__((always_inline)) inline
#define __MINSTL_NOINLINE    __attribute__((noinline))



#endif //__MINSTL__PLATFORM_H
