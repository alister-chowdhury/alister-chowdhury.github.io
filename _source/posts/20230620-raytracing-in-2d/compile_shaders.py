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

from builder.shader_compiler import compile_glsl, GLOBAL_SHADER_INCLUDE_DIR


_SRC_DIR = os.path.abspath(
    os.path.join(__file__, "..", "shaders")
)

_COMPILED_DIR = os.path.abspath(
    os.path.join(__file__, "..", "shaders", "compiled")
)


_SHADER_MAPPING = {
    "v1_draw_bvh_all.vert" : {
        "filepath": "v1_draw_bvh.vert",
        "macros": {
            "LINE_BVH_V1_LOC": 0,
            "TARGETTING_WEBGL": 1
        }
    },
    "v1_draw_bvh_lines.vert" : {
        "filepath": "v1_draw_bvh.vert",
        "macros": {
            "LINE_BVH_V1_LOC": 0,
            "ONLY_LINES": 1,
            "TARGETTING_WEBGL": 1
        }
    },
    "v1_draw_bvh_bbox.vert" : {
        "filepath": "v1_draw_bvh.vert",
        "macros": {
            "LINE_BVH_V1_LOC": 0,
            "ONLY_BOXES": 1,
            "TARGETTING_WEBGL": 1
        }
    },
    "v1_draw_bvh.frag" : {
        "filepath": "v1_draw_bvh.frag",
        "macros": {
            "TARGETTING_WEBGL": 1
        }
    }
}


# must match ordering in v1_tracing_test.frag
_BVH_VIS_TRACE_TYPES = (
    "pointlight",
    "visibility",
    "num_visits",
    "num_intersections",
    "composite",
    "line_id"
)


for _idx, _name in enumerate(_BVH_VIS_TRACE_TYPES):
    _SHADER_MAPPING["v1_tracing_test_{0}.frag".format(_name)] = {
        "filepath": "v1_tracing_test.frag",
        "macros": {
            "VIS_TRACE_TYPE": _idx,
            "LINE_BVH_V1_LOC": 0,
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
