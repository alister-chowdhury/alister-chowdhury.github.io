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
    compile_cpp,
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

    generate_bvh_v1_src = os.path.join(_ROOT_DIR, "bvh_v1", "generate_bvh_v1.cpp")
    generate_bvh_v1_obj = os.path.join(_BUILD_DIR, "generate_bvh_v1.o")
    compile_cpp(
        generate_bvh_v1_src,
        generate_bvh_v1_obj,
        include_paths=[MINISTL_INCLUDE_DIR]
    )

    wasm_bootstrap_bvh_v1_src = os.path.join(_ROOT_DIR, "bvh_v1", "wasm_bootstrap_bvh_v1.c")
    wasm_bootstrap_bvh_v1_obj = os.path.join(_BUILD_DIR, "wasm_bootstrap_bvh_v1.o")
    compile_c(
        wasm_bootstrap_bvh_v1_src,
        wasm_bootstrap_bvh_v1_obj,
        include_paths=[MINISTL_INCLUDE_DIR]
    )

    link(
        (
            MINISTL_SIMPLE_MALLOC_STATIC_LIB,
            generate_bvh_v1_obj,
            wasm_bootstrap_bvh_v1_obj
        ),
        os.path.join(_ROOT_DIR, "bvh_v1.wasm"),
    )
