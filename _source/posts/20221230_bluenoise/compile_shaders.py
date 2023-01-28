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

from builder.shader_compiler import compile_glsl


_SRC_DIR = os.path.abspath(
    os.path.join(__file__, "..", "shaders")
)

_COMPILED_DIR = os.path.abspath(
    os.path.join(__file__, "..", "shaders", "compiled")
)


_SHADER_MAPPING = {
    "draw_full_screen.vert" : {
        "filepath": "draw_full_screen.vert",
    },

    "draw_full_screen_with_uvs.vert" : {
        "filepath": "draw_full_screen.vert",
        "macros": {
            "VS_OUTPUT_UV": 0,
        }
    },

    "void_and_cluster_init.frag" : {
        "filepath": "void_and_cluster_init.frag",
    },

    "void_and_cluster_partial_update.vert" : {
        "filepath": "void_and_cluster_partial_update.vert",
    },

    "void_and_cluster_reduce_init.frag" : {
        "filepath": "void_and_cluster_reduce_init.frag",
    },

    "void_and_cluster_reduce_iter.frag" : {
        "filepath": "void_and_cluster_reduce_iter.frag",
    },

    "void_and_cluster_update.frag" : {
        "filepath": "void_and_cluster_update.frag",
    },

    "vis_bluenoise_scaled.frag" : {
        "filepath": "vis_bluenoise.frag",
        "macros": {
            "TILE_SAMPLE": 0,
        },
    },

    "vis_bluenoise_tiled.frag" : {
        "filepath": "vis_bluenoise.frag",
        "macros": {
            "TILE_SAMPLE": 1,
        },
    },

    "export_first_channel.frag" : {
        "filepath": "export_first_channel.frag",
    },

    "bc4_compress.frag" : {
        "filepath": "bc4_compress.frag",
    },
}


if __name__ == "__main__":
    for dst, src_data in _SHADER_MAPPING.items():
        dst = os.path.join(_COMPILED_DIR, dst)
        src = os.path.join(_SRC_DIR, src_data["filepath"])
        macros = src_data.get("macros")
        print("Compiling\nSrc: {0}\nDst: {1}\nDefines={2}\n".format(src, dst, macros))
        compiled_glsl = compile_glsl(src, macros)
        with open(dst, "w") as out_fp:
            out_fp.write(compiled_glsl)
