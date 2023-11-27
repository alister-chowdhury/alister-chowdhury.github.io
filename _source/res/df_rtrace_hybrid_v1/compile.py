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
    compile_cpp,
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

    dfrt_generate_v1_src = os.path.join(_ROOT_DIR, "dfrt_generate_v1.cpp")
    dfrt_generate_v1_obj = os.path.join(_BUILD_DIR, "dfrt_generate_v1.o")
    compile_cpp(
        dfrt_generate_v1_src,
        dfrt_generate_v1_obj,
        include_paths=[MINISTL_INCLUDE_DIR]
    )

    wasm_bootstreap_dfrt_v1_src = os.path.join(_ROOT_DIR, "wasm_bootstreap_dfrt_v1.c")
    wasm_bootstreap_dfrt_v1_obj = os.path.join(_BUILD_DIR, "wasm_bootstreap_dfrt_v1.o")
    compile_c(
        wasm_bootstreap_dfrt_v1_src,
        wasm_bootstreap_dfrt_v1_obj,
        include_paths=[MINISTL_INCLUDE_DIR]
    )

    link(
        (
            MINISTL_SIMPLE_MALLOC_STATIC_LIB,
            dfrt_generate_v1_obj,
            wasm_bootstreap_dfrt_v1_obj
        ),
        os.path.join(_ROOT_DIR, "..", "dfrt_v1.wasm"),
    )
