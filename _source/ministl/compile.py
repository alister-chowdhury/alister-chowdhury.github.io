import sys
import os

sys.path.insert(
    0,
    os.path.abspath(
        os.path.join(
            __file__,
            "..",
            "..",
            ".."
        )
    )
)

from builder.cc_compiler import compile_c, make_static_lib

_ROOT_DIR = os.path.abspath(
    os.path.join(__file__, "..")
)

_SRC_DIR = os.path.abspath(
    os.path.join(__file__, "..", "src")
)

_INCLUDE_DIR = os.path.abspath(
    os.path.join(__file__, "..", "include")
)

_BUILD_DIR = os.path.abspath(
    os.path.join(__file__, "..", "build")
)


_MUSL_FILES = (
    "acos.c",
    "acosf.c",
    "acosh.c",
    "acoshf.c",
    "asin.c",
    "asinf.c",
    "asinh.c",
    "asinhf.c",
    "atan.c",
    "atan2.c",
    "atan2f.c",
    "atanf.c",
    "atanh.c",
    "atanhf.c",
    "cbrt.c",
    "cbrtf.c",
    "cos.c",
    "cosf.c",
    "cosh.c",
    "coshf.c",
    "erf.c",
    "erff.c",
    "exp.c",
    "exp2.c",
    "exp2f.c",
    "exp2f_data.c",
    "expf.c",
    "expm1.c",
    "expm1f.c",
    "exp_data.c",
    "fdim.c",
    "fdimf.c",
    "fmax.c",
    "fmaxf.c",
    "fmin.c",
    "fminf.c",
    "fmod.c",
    "fmodf.c",
    "frexp.c",
    "frexpf.c",
    "hypot.c",
    "hypotf.c",
    "ilogb.c",
    "ilogbf.c",
    "lgamma.c",
    "lgammaf.c",
    "lgammaf_r.c",
    "lgamma_r.c",
    "log.c",
    "log10.c",
    "log10f.c",
    "log1p.c",
    "log1pf.c",
    "log2.c",
    "log2f.c",
    "log2f_data.c",
    "log2_data.c",
    "logb.c",
    "logbf.c",
    "logf.c",
    "logf_data.c",
    "log_data.c",
    "modf.c",
    "modff.c",
    "nextafter.c",
    "nextafterf.c",
    "pow.c",
    "powf.c",
    "powf_data.c",
    "pow_data.c",
    "remainder.c",
    "remainderf.c",
    "remquo.c",
    "remquof.c",
    "sin.c",
    "sinf.c",
    "sinh.c",
    "sinhf.c",
    "tan.c",
    "tanf.c",
    "tanh.c",
    "tanhf.c",
    "tgamma.c",
    "tgammaf.c",
    "__math_divzero.c",
    "__math_divzerof.c",
    "__math_invalid.c",
    "__math_invalidf.c",
    "__math_invalidl.c",
    "__math_oflow.c",
    "__math_oflowf.c",
    "__math_uflow.c",
    "__math_uflowf.c",
    "__math_xflow.c",
    "__math_xflowf.c",
)


_MUSL_EXTRA_ARGS = (
    '-Wno-ignored-pragmas',
    '-Dweak=__attribute__((__weak__))',
    '-Dhidden=__attribute__((__visibility__("hidden")))',
    '-Dweak_alias(old, new)=extern __typeof(old) new __attribute__((__weak__, __alias__(#old)))',
)

if __name__ == "__main__":
    includes = [_INCLUDE_DIR]
    _src = lambda *x: os.path.join(_SRC_DIR, *x)
    _build = lambda *x: os.path.join(_BUILD_DIR, *x)

    if not os.path.isdir(_BUILD_DIR):
        os.makedirs(_BUILD_DIR)

    obj_files = []

    # Compile musl math libraries
    musl_includes = includes + [
        _src("musl/include/"),
        _src("musl/arch/generic/")
    ]
    for musl_file in _MUSL_FILES:
        musl_obj = _build("{0}.o".format(musl_file))
        obj_files.append(musl_obj)
        compile_c(
            _src("musl/src/", musl_file),
            musl_obj,
            include_paths=musl_includes,
            extra_args=_MUSL_EXTRA_ARGS
        )

    memcmp_object = _build("_memcmp.o")
    obj_files.append(memcmp_object)
    compile_c(_src("_memcmp.c"), memcmp_object, include_paths=includes)

    malloc_simple_object = _build("_malloc__simple.o")
    compile_c(_src("_malloc.c"), malloc_simple_object, include_paths=includes, extra_args=("-DMALLOC_SIMPLE=1",))

    make_static_lib(obj_files + [malloc_simple_object], os.path.join(_ROOT_DIR, "ministl_simplemalloc.lib"))
