import os
import re
import subprocess
import tempfile

from .find_exec import find_executable

_DXC_EXEC = find_executable("dxc", "DXC_PATH")
_GLSLC_EXEC = find_executable("glslc", "GLSLC_PATH")
_SPIRV_CROSS_EXEC = find_executable("spirv-cross", "SPIRV_CROSS_PATH")


GLOBAL_SHADER_INCLUDE_DIR = os.path.abspath(os.path.join(
    __file__,
    "..",
    "..",
    "_source",
    "res",
    "shaders",
    "include"
))


def validate_has_glsl_executables():
    """Validate the local machine has the relevant executables needed.

    Raises:
        RuntimeError: Executables not found.
    """
    if not any(executable for executable in (_GLSLC_EXEC, _SPIRV_CROSS_EXEC)):
        raise RuntimeError(
            "glslc and spirv-cross are needed to compile shaders "
            "(install the VulkanSDK)."
        )


def validate_has_hlsl_executables():
    """Validate the local machine has the relevant executables needed.

    Raises:
        RuntimeError: Executables not found.
    """
    if not any(executable for executable in (_DXC_EXEC, _SPIRV_CROSS_EXEC)):
        raise RuntimeError(
            "dxc and spirv-cross are needed to compile shaders "
            "(install the VulkanSDK)."
        )



def _spirv_to_webgl(spv_path):
    """Decompile spirv to WebGL GLSL.

    Args:
        spv_path (str): Path to spirv file.

    Returns:
        str: WebGL GLSL
    """
    spirv_cross_command = [
        _SPIRV_CROSS_EXEC,
        "--es",
        "--version", "300",
        spv_path
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
    result = re.sub("\n+", "\n", result)

    return result


def _compile_to_spirv(out_spv_path, filepath, macros=None, includes=None):
    """Compiles desktop glsl into spirv.

    Args:
        out_spv_path(str): filepath to write spirv.
        filepath(str): Filepath of shader to compile.
        macros(dict): Macros to define. (Default: None)
        includes(iterable): Directories to include. (Default: None)
    """
    glslc_command = [
        _GLSLC_EXEC,
        "--target-env=opengl4.5",
        "-O",
        "-g",
        filepath,
        "-o", out_spv_path
    ]

    if macros:
        for key, value in macros.items():
            glslc_command.append("-D{0}={1}".format(key, value))

    if includes:
        for include in includes:
            glslc_command.extend(("-I", include))

    subprocess.check_call(glslc_command)


def compile_glsl(filepath, macros=None, includes=None):
    """Compiles desktop glsl into webgl glsl.

    Args:
        filepath(str): Filepath of shader to compile.
        macros(dict): Macros to define. (Default: None)
        includes(iterable): Directories to include. (Default: None)

    Return:
        str: Compiled webgl glsl.
    """
    validate_has_glsl_executables()
    tmp_spv = tempfile.NamedTemporaryFile(delete=False)

    # First we compile the source shaders into spirv with glslc,
    # then we decompile into glsl es, using spirv-cross.
    #
    # TODO: It would be mildly nice to cache this, but glslc gives
    # no fantastic way to track dependencies without using C++.
    # We could however just use the pre-processor as a way to do this,
    # although that itself, is not very fast.
    try:
        tmp_spv.close()
        _compile_to_spirv(tmp_spv.name, filepath, macros=macros, includes=includes)
        return _spirv_to_webgl(tmp_spv.name)

    finally:
        os.unlink(tmp_spv.name)
