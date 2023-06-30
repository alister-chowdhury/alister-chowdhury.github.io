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
    "project_lines.vert" : {
        "filepath": "project_lines.vert",
        "macros": {
            "TARGETTING_WEBGL": 1
        }
    },
    "draw_lines.vert" : {
        "filepath": "draw_lines.vert",
        "macros": {
            "TARGETTING_WEBGL": 1
        }
    },
    "draw_select_overlay.vert" : {
        "filepath": "draw_select_overlay.vert"
    },
    "draw_select_overlay.frag" : {
        "filepath": "draw_select_overlay.frag"
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
