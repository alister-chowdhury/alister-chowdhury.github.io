#ifndef __MINSTL_STRING_H
#define __MINSTL_STRING_H

#include "__platform.h"

__MINSTL_EXTERN_C_START


__MINSTL_FORCEINLINE void* memcpy(void* __dst, const void* __src, __SIZE_TYPE__ __sz) { return __builtin_memcpy(__dst, __src, __sz); }
__MINSTL_FORCEINLINE void* memmove(void* __dst, const void* __src, __SIZE_TYPE__ __sz) { return __builtin_memmove(__dst, __src, __sz); }
__MINSTL_FORCEINLINE void* memset(void* __dest, int __c, __SIZE_TYPE__ __n) { return __builtin_memset(__dest, __c, __n); }


__attribute__((const)) int memcmp(const void*, const void*, __SIZE_TYPE__);


__MINSTL_EXTERN_C_END


#endif // __MINSTL_STRING_H
