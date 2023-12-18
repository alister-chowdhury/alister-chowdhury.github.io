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

from builder.webgl_compiler import compile_glsl, GLOBAL_SHADER_INCLUDE_DIR


_SRC_DIR = os.path.abspath(
    os.path.join(__file__, "..", "shaders")
)

_COMPILED_DIR = os.path.abspath(
    os.path.join(__file__, "..", "shaders", "compiled")
)


_SHADER_MAPPING = {
    "draw_lines.vert" : {
        "filepath": "draw_lines.vert",
        "macros": {
            "TARGETTING_WEBGL": 1
        }
    }
}


# must match ordering in dfrt_v1_tracing_test.frag
_VIS_TRACE_TYPES = (
    "pointlight",
    "visibility",
    "num_iterations",
    "num_intersections",
    "composite",
)


for _idx, _name in enumerate(_VIS_TRACE_TYPES):
    _SHADER_MAPPING["dfrt_v1_tracing_test_{0}.frag".format(_name)] = {
        "filepath": "dfrt_v1_tracing_test.frag",
        "macros": {
            "VIS_TRACE_TYPE": _idx,
            "DF_RTRACE_DFTEX_V1_LOC": 0,
            "DF_RTRACE_LINES_V1_LOC": 1,
            "DF_RTRACE_PARAMS_V1_LOC": 1,
            "TARGETTING_WEBGL": 1
        }
    }

# must match ordering in dfrt_v1_vis_df.frag
_VIS_DF_TYPES = (
    "dist",
    "numlines",
    "composite"
)


for _idx, _name in enumerate(_VIS_DF_TYPES):
    _SHADER_MAPPING["dfrt_v1_vis_df_{0}.frag".format(_name)] = {
        "filepath": "dfrt_v1_vis_df.frag",
        "macros": {
            "VIS_DF_TYPE": _idx,
            "DF_RTRACE_DFTEX_V1_LOC": 0,
            "DF_RTRACE_PARAMS_V1_LOC": 0,
            "TARGETTING_WEBGL": 1
        }
    }

if __name__ == "__main__":
    for dst, src_data in _SHADER_MAPPING.items():
        dst = os.path.join(_COMPILED_DIR, dst)
        src = os.path.join(_SRC_DIR, src_data["filepath"])
        macros = src_data.get("macros")
        print("Compiling\nSrc: {0}\nDst: {1}\nDefines={2}\n".format(src, dst, macros))
        compiled_glsl = compile_glsl(src, macros, includes=(GLOBAL_SHADER_INCLUDE_DIR,))
        with open(dst, "w") as out_fp:
            out_fp.write(compiled_glsl)
