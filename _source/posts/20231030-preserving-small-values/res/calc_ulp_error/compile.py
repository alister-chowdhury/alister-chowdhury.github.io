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
    MINISTL_SIMPLE_MALLOC_STATIC_LIB,
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

    calc_ulp_error_src = os.path.join(_ROOT_DIR, "calc_ulp_error.c")
    calc_ulp_error_obj = os.path.join(_BUILD_DIR, "calc_ulp_error.o")
    compile_c(
        calc_ulp_error_src,
        calc_ulp_error_obj,
        include_paths=[MINISTL_INCLUDE_DIR]
    )

    link(
        (
            MINISTL_SIMPLE_MALLOC_STATIC_LIB,
            calc_ulp_error_obj
        ),
        os.path.join(_ROOT_DIR, "..", "calc_ulp_error.wasm"),
        stack_size = 0
    )
