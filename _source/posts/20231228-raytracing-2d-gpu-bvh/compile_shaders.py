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

from builder.wgsl_compiler import compile_glsl, GLOBAL_SHADER_INCLUDE_DIR


_SRC_DIR = os.path.abspath(
    os.path.join(__file__, "..", "shaders")
)

_COMPILED_DIR = os.path.abspath(
    os.path.join(__file__, "..", "shaders", "compiled")
)


PICK_MAX_DIST = 0.025 * 0.5

_SHADER_MAPPING = {
    "draw_lines.vert.wgsl" : {
        "filepath": "draw_lines.vert",
    },
    "pick_line_to_edit.comp.wgsl" : {
        "filepath": "pick_line_to_edit.comp",
        "macros": {
            "PICK_MAX_DIST": PICK_MAX_DIST
        }
    },
    "apply_snapping.comp.wgsl" : {
        "filepath": "apply_snapping.comp",
        "macros": {
            "PICK_MAX_DIST": PICK_MAX_DIST
        }
    },
    "apply_line_edit.comp.wgsl" : {
        "filepath": "apply_line_edit.comp"
    },
    "draw_editable_points.vert.wgsl" : {
        "filepath": "draw_editable_points.vert",
        "macros": {
            "PICK_MAX_DIST": PICK_MAX_DIST
        }
    },
    "draw_editable_points.frag.wgsl" : {
        "filepath": "draw_editable_points.frag"
    },
    "draw_picked_point.vert.wgsl" : {
        "filepath": "draw_picked_point.vert",
        "macros": {
            "PICK_MAX_DIST": PICK_MAX_DIST
        }
    },
    "draw_picked_point.frag.wgsl" : {
        "filepath": "draw_picked_point.frag"
    },
    "draw_tree.vert.wgsl" : {
        "filepath": "draw_tree.vert",
        "macros": {
            "LINE_BVH_V2_BINDING": 0,
        }
    },
    "draw_tree.frag.wgsl" : {
        "filepath": "draw_tree.frag",
    }
}


_BVH_VIS_TRACE_TYPES = (
    "pointlight",
    "visibility",
    "num_visits",
    "num_intersections",
    "composite",
)


for _idx, _name in enumerate(_BVH_VIS_TRACE_TYPES):
    _SHADER_MAPPING["v2_tracing_test_{0}.frag.wgsl".format(_name)] = {
        "filepath": "v2_tracing_test.frag",
        "macros": {
            "VIS_TRACE_TYPE": _idx,
            "LINE_BVH_V2_BINDING": 0,
        }
    }

if __name__ == "__main__":
    for dst, src_data in _SHADER_MAPPING.items():
        dst = os.path.join(_COMPILED_DIR, dst)
        src = os.path.join(_SRC_DIR, src_data["filepath"])
        macros = src_data.get("macros")
        backend = src_data.get("backend", None)
        print("Compiling\nSrc: {0}\nDst: {1}\nDefines={2}\nBackend={3}".format(
            src,
            dst,
            macros,
            backend
        ))
        compiled_wgsl = compile_glsl(
            src,
            macros,
            includes=(GLOBAL_SHADER_INCLUDE_DIR,),
            backend=backend
        )
        with open(dst, "w") as out_fp:
            out_fp.write(compiled_wgsl)
