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
    os.path.join(__file__, "..")
)

_COMPILED_DIR = os.path.abspath(
    os.path.join(__file__, "..", "compiled_webgpu")
)


_SHADER_MAPPING = {
    "draw_full_screen.vert.wgsl" : {
        "filepath": "draw_full_screen.vert",
    },
    "draw_full_screen_uvs.vert.wgsl" : {
        "filepath": "draw_full_screen.vert",
        "macros": {
            "VS_OUTPUT_UV": 0,
        }
    },
    "draw_full_screen_ndc.vert.wgsl" : {
        "filepath": "draw_full_screen.vert",
        "macros": {
            "VS_OUTPUT_NDC": 0,
        },
    },
    "draw_full_screen_uvs_ndc.vert.wgsl" : {
        "filepath": "draw_full_screen.vert",
        "macros": {
            "VS_OUTPUT_UV": 0,
            "VS_OUTPUT_NDC": 1,
        }
    },
    "draw_col.frag.wgsl" : {
        "filepath": "draw_col.frag",
    },
}

# v2_tracing_generate_bvh.comp
_SHADER_MAPPING.update({
    "v2_tracing_generate_bvh_L{0}.comp.wgsl".format(level):
    {
        "filepath": "v2_tracing_generate_bvh.comp",
        "macros":
        {
            "NUM_LEVELS": level
        }
    }
    for level in range(1, 5)
})


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
