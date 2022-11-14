import distutils.spawn
import os
import re
import subprocess
import tempfile


_SRC_DIR = os.path.abspath(
    os.path.join(__file__, "..", "..", "shaders")
)

_COMPILED_DIR = os.path.abspath(
    os.path.join(__file__, "..", "..", "shaders", "compiled")
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


_GLSLC_EXEC = distutils.spawn.find_executable("glslc")
_SPIRV_CROSS_EXEC = distutils.spawn.find_executable("spirv-cross")


if not _GLSLC_EXEC or not _SPIRV_CROSS_EXEC:
    raise RuntimeError(
        "glslc and spirv-cross are needed to compile shaders "
        "(install the VulkanSDK)."
    )


def compile_webgl_shader(filepath, macros=None):
    """Compiles desktop glsl into webgl glsl.

    Args:
        filepath(str): Filepath of shader to compile.
        macros(dict): Macros to define. (Default: None)

    Return:
        str: Compiled webgl glsl.
    """
    tmp_spv = tempfile.NamedTemporaryFile(delete=False)

    # First we compile the source shaders into spirv with glslc,
    # then we decompile into glsl es, using spirv-cross.
    try:
        tmp_spv.close()
        glslc_command = [
            _GLSLC_EXEC,
            "--target-env=opengl4.5",
            "-O",
            "-g",
            filepath,
            "-o", tmp_spv.name
        ]

        if macros:
            for key, value in macros.items():
                glslc_command.append("-D{0}={1}".format(key, value))

        subprocess.check_call(glslc_command)

        spirv_cross_command = [
            _SPIRV_CROSS_EXEC,
            "--es",
            "--version", "300",
            tmp_spv.name
        ]
        result = subprocess.Popen(
            spirv_cross_command,
            stdout=subprocess.PIPE,
            close_fds=True
        ).stdout.read().decode("latin-1")


        # Make things high precision, not totally sure how much of a
        # difference this makes in practice, but I'd rather not have
        # to debug rounding errors.
        result = re.sub(
            r"(\s*)(mediump|lowp)(\s*)",
            lambda x: "{0}highp{1}".format(x.group(1), x.group(3)),
            result,
            flags=re.MULTILINE
        )

        result = re.sub(
            r"uniform\s*(highp|mediump|lowp)?(\s+)",
            "uniform highp ",
            result,
            flags=re.MULTILINE
        )

        # Remove weird \r\r\n line endings
        # and conform to unix style
        result = result.replace("\r\r\n", "\n")
        result = result.replace("\r\n", "\n")

        while "\n\n" in result:
            result = result.replace("\n\n", "\n")

        # TODO: Could probably do a minify pass
        # to remove excess whitespace, make things like
        # 1.0 => 1. and 0.1 => .1

        return result

    finally:
        os.unlink(tmp_spv.name)


if __name__ == "__main__":
    for dst, src_data in _SHADER_MAPPING.items():
        dst = os.path.join(_COMPILED_DIR, dst)
        src = os.path.join(_SRC_DIR, src_data["filepath"])
        macros = src_data.get("macros")
        print("Compiling\nSrc: {0}\nDst: {1}\nDefines={2}\n".format(src, dst, macros))
        compiled_glsl = compile_webgl_shader(src, macros)
        with open(dst, "w") as out_fp:
            out_fp.write(compiled_glsl)
