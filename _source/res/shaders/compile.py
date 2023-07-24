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
    os.path.join(__file__, "..")
)

_COMPILED_DIR = os.path.abspath(
    os.path.join(__file__, "..", "compiled")
)


_SHADER_MAPPING = {
    "const_col.frag" : {
        "filepath": "const_col.frag",
    },
    "draw_full_screen.vert" : {
        "filepath": "draw_full_screen.vert",
    },
    "draw_full_screen_uvs.vert" : {
        "filepath": "draw_full_screen.vert",
        "macros": {
            "VS_OUTPUT_UV": 0,
        }
    },
    "draw_full_screen_ndc.vert" : {
        "filepath": "draw_full_screen.vert",
        "macros": {
            "VS_OUTPUT_NDC": 0,
        }
    },
    "draw_full_screen_uvs_ndc.vert" : {
        "filepath": "draw_full_screen.vert",
        "macros": {
            "VS_OUTPUT_UV": 0,
            "VS_OUTPUT_NDC": 1,
        }
    },
    "draw_rect.vert" : {
        "filepath": "draw_rect.vert",
    },
    "draw_rect_uvs.vert" : {
        "filepath": "draw_rect.vert",
        "macros": {
            "VS_OUTPUT_UV": 0,
        }
    },
    "draw_rect_ndc.vert" : {
        "filepath": "draw_rect.vert",
        "macros": {
            "VS_OUTPUT_NDC": 0,
        }
    },
    "draw_rect_uvs_ndc.vert" : {
        "filepath": "draw_rect.vert",
        "macros": {
            "VS_OUTPUT_UV": 0,
            "VS_OUTPUT_NDC": 1,
        }
    },
    "draw_col.frag" : {
        "filepath": "draw_col.frag",
    },
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
