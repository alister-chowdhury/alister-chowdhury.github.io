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
    },
    "draw_bbox.vert" : {
        "filepath": "draw_bbox.vert",
        "macros": {
            "TARGETTING_WEBGL": 1
        }
    },
    "draw_obbox.vert" : {
        "filepath": "draw_obbox.vert",
        "macros": {
            "TARGETTING_WEBGL": 1
        }
    },
    "draw_lights_bbox.vert" : {
        "filepath": "draw_lights.vert",
        "macros": {
            "TARGETTING_WEBGL": 1,
            "USE_OBBOX": 0,
        }
    },
    "draw_lights_obbox.vert" : {
        "filepath": "draw_lights.vert",
        "macros": {
            "TARGETTING_WEBGL": 1,
            "USE_OBBOX": 1,
        }
    },
    "draw_lights_binary.frag" : {
        "filepath": "draw_lights.frag",
        "macros": {
            "TARGETTING_WEBGL": 1,
            "PLANE_BLOCKING_MODE": "PLANE_BLOCKING_MODE_BINARY"
        }
    },
    "draw_lights_pcf.frag" : {
        "filepath": "draw_lights.frag",
        "macros": {
            "TARGETTING_WEBGL": 1,
            "PLANE_BLOCKING_MODE": "PLANE_BLOCKING_MODE_BINARY_TWOTAP_PCF"
        }
    },
    "gen_bbox.frag" : {
        "filepath": "gen_bbox.frag",
        "macros": {
            "TARGETTING_WEBGL": 1,
        }
    },
    "gen_obbox.frag" : {
        "filepath": "gen_obbox.frag",
        "macros": {
            "TARGETTING_WEBGL": 1,
        }
    },
    "gen_plane_map.frag" : {
        "filepath": "gen_plane_map.frag",
        "macros": {
            "TARGETTING_WEBGL": 1
        }
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
