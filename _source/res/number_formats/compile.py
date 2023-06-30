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

    f32tof16_src = os.path.join(_ROOT_DIR, "f32tof16.c")
    f32tof16_obj = os.path.join(_BUILD_DIR, "f32tof16.o")

    r11g11b10_src = os.path.join(_ROOT_DIR, "r11g11b10.c")
    r11g11b10_obj = os.path.join(_BUILD_DIR, "r11g11b10.o")
    
    compile_c(
        f32tof16_src,
        f32tof16_obj,
        include_paths=[MINISTL_INCLUDE_DIR]
    )

    compile_c(
        r11g11b10_src,
        r11g11b10_obj,
        include_paths=[MINISTL_INCLUDE_DIR]
    )

    link(
        (
            MINISTL_SIMPLE_MALLOC_STATIC_LIB,
            f32tof16_obj,
            r11g11b10_obj
        ),
        os.path.join(_ROOT_DIR, "..", "number_formats.wasm"),
        stack_size = 0
    )
