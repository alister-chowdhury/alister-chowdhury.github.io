#ifndef __MINSTL_STDDEF_H
#define __MINSTL_STDDEF_H


#define offsetof(type, member)                      __builtin_offsetof(type, member)
typedef __SIZE_TYPE__                               size_t;
typedef __PTRDIFF_TYPE__                            ptrdiff_t;
typedef struct { long long __a; long double __b; }  max_align_t; // match gcc / clang


#endif // __MINSTL_STDINT_H
