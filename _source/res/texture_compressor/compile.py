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

_BC7ENC_DIR = os.path.abspath(
    os.path.join(_ROOT_DIR, "bc7enc_rdo")
)


if __name__ == "__main__":
    if not os.path.isdir(_BUILD_DIR):
        os.makedirs(_BUILD_DIR)

    # Compile bc1, bc3, bc4, bc5, bc7 into bnc.wasm
    bc7enc_include_paths = [
        MINISTL_INCLUDE_DIR,
        _BC7ENC_DIR
    ]

    rgbcx_src = os.path.join(_BC7ENC_DIR, "rgbcx.cpp")
    rgbcx_obj = os.path.join(_BUILD_DIR, "rgbcx.o")
    compile_cpp(
        rgbcx_src,
        rgbcx_obj,
        include_paths=bc7enc_include_paths,
        extra_args=(
            "-DRGBCX_USE_SMALLER_TABLES=0",
        )
    )

    bc7enc_src = os.path.join(_BC7ENC_DIR, "bc7enc.cpp")
    bc7enc_obj = os.path.join(_BUILD_DIR, "bc7enc.o")
    compile_cpp(
        bc7enc_src,
        bc7enc_obj,
        include_paths=bc7enc_include_paths,
        extra_args=(
            "-DRGBCX_USE_SMALLER_TABLES=0",
        )
    )

    bcn_compressor_src = os.path.join(_ROOT_DIR, "bcn.cpp")
    bcn_compressor_obj = os.path.join(_BUILD_DIR, "bcn.o")
    
    compile_cpp(
        bcn_compressor_src,
        bcn_compressor_obj,
        include_paths=bc7enc_include_paths,
        extra_args=(
            "-DRGBCX_USE_SMALLER_TABLES=0",
        )
    )

    link(
        (
            MINISTL_SIMPLE_MALLOC_STATIC_LIB,
            rgbcx_obj,
            bc7enc_obj,
            bcn_compressor_obj
        ),
        os.path.join(_ROOT_DIR, "bcn.wasm"),
    )
