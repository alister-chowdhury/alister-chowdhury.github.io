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


_SHADER_MAPPING = {}

for _tile_size in (8, 16, 32):
    _SHADER_MAPPING["pick_{0}.comp.wgsl".format(_tile_size)] = {
        "filepath": "pick.comp",
        "macros": {
            "TILE_SIZE": _tile_size,
            "USE_IMAGE_BUFFERS": 0,
        }
    }
    _SHADER_MAPPING["update_energy_{0}.comp.wgsl".format(_tile_size)] = {
        "filepath": "update_energy.comp",
        "macros": {
            "TILE_SIZE": _tile_size,
            "USE_IMAGE_BUFFERS": 0,
        }
    }
    _SHADER_MAPPING["buffer_to_image_{0}.frag.wgsl".format(_tile_size)] = {
        "filepath": "buffer_to_image.frag",
        "macros": {
            "TILE_SIZE": _tile_size
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
