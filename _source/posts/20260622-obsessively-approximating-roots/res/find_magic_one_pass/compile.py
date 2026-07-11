import sys
import os

sys.path.insert(
    0,
    os.path.abspath(
        os.path.join(
            __file__,
            "..",
            "..",
            "..",
            "..",
            "..",
            ".."
        )
    )
)

from builder.cc_compiler import (
    MINISTL_INCLUDE_DIR,
    MINISTL_SLOWMATH_SIMPLE_MALLOC_STATIC_LIB,
    compile_c,
    link
)

_ROOT_DIR = os.path.abspath(
    os.path.join(__file__, "..")
)

_BUILD_DIR = os.path.abspath(
    os.path.join(_ROOT_DIR, "build")
)


if __name__ == "__main__":
    if not os.path.isdir(_BUILD_DIR):
        os.makedirs(_BUILD_DIR)

    find_magic_one_pass_src = os.path.join(_ROOT_DIR, "find_magic_one_pass.c")
    find_magic_one_pass_obj = os.path.join(_BUILD_DIR, "find_magic_one_pass.o")
    compile_c(
        find_magic_one_pass_src,
        find_magic_one_pass_obj,
        include_paths=[MINISTL_INCLUDE_DIR],
        extra_args="-fno-fast-math"
    )

    link(
        (
            MINISTL_SLOWMATH_SIMPLE_MALLOC_STATIC_LIB,
            find_magic_one_pass_obj
        ),
        os.path.join(_ROOT_DIR, "..", "find_magic_one_pass.wasm"),
        stack_size = 0
    )
