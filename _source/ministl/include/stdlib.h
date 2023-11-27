#ifndef __MINSTL_STDLIB_H
#define __MINSTL_STDLIB_H

#include "__platform.h"

__MINSTL_EXTERN_C_START


void* malloc(__SIZE_TYPE__);
void* realloc(void*, __SIZE_TYPE__);
void free(void*);


__MINSTL_EXTERN_C_END


#endif // __MINSTL_STDLIB_H
