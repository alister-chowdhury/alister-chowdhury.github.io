#ifndef __MINSTL_LIMITS_H
#define __MINSTL_LIMITS_H

#define SCHAR_MAX __SCHAR_MAX__
#define SHRT_MAX __SHRT_MAX__
#define INT_MAX __INT_MAX__
#define LONG_MAX __LONG_MAX__

#define SCHAR_MIN ((-SCHAR_MAX) - 1)
#define SHRT_MIN  ((-SHRT_MAX)  - 1)
#define INT_MIN  ((-INT_MAX)   - 1)
#define LONG_MIN  ((-LONG_MAX)  - 1l)

#define UCHAR_MAX ((__SCHAR_MAX__ << 1) + 1)
#define USHRT_MAX ((__SHRT_MAX__  << 1) + 1)
#define UINT_MAX ((__INT_MAX__   << 1) + 1u)
#define ULONG_MAX ((__LONG_MAX__  << 1) + 1lu)

#endif // __MINSTL_LIMITS_H
