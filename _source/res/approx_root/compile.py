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
    MINISTL_SLOWMATH_SIMPLE_MALLOC_STATIC_LIB,
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

_SRC_FILES = [
    "find_magic_rel.cpp",
    "find_magic_ulp.cpp",
]


if __name__ == "__main__":
    if not os.path.isdir(_BUILD_DIR):
        os.makedirs(_BUILD_DIR)

    obj_files = []
    for src_file in _SRC_FILES:
        obj_file = os.path.join(_BUILD_DIR, "{0}.o".format(src_file))
        obj_files.append(obj_file)
        compile_cpp(
            os.path.join(_ROOT_DIR, "approx_root", "src", "approx_root", src_file),
            obj_file,
            include_paths=[MINISTL_INCLUDE_DIR]
        )

    bootstrap_src = os.path.join(_ROOT_DIR, "bootstrap.c")
    bootstrap_obj = os.path.join(_BUILD_DIR, "bootstrap.o")
    obj_files.append(bootstrap_obj)
    compile_c(
        bootstrap_src,
        bootstrap_obj,
        include_paths=[MINISTL_INCLUDE_DIR],
        extra_args="-fno-fast-math"
    )

    link(
        (
            MINISTL_SLOWMATH_SIMPLE_MALLOC_STATIC_LIB,
            *obj_files
        ),
        os.path.join(_ROOT_DIR, "..", "approx_root.wasm"),
    )
