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

    encode_number_web_src = os.path.join(_ROOT_DIR, "encode_number_web.c")
    encode_number_web_obj = os.path.join(_BUILD_DIR, "encode_number_web.o")
    compile_c(
        encode_number_web_src,
        encode_number_web_obj,
        include_paths=[MINISTL_INCLUDE_DIR]
    )

    link(
        (
            MINISTL_SIMPLE_MALLOC_STATIC_LIB,
            encode_number_web_obj
        ),
        os.path.join(_ROOT_DIR, "..", "encode_number_web.wasm"),
    )
