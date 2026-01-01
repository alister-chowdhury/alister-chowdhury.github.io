# MINISTL

Mini subset of the C STD and C++ STL, specifically targetting wasm via clang, made purely to deal with not always having access to libcxx.
I'm adding additional things when / if I need them.

MUSL is currently used for some of the more non-trivial math functions.

## Dependencies
* LLVM (Been using 21.1.8), optional to compile C/C++

## Building

```
python compile.py
```
