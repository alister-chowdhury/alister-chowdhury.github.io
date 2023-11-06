import os
import re
import subprocess
import tempfile

from .find_exec import find_executable

_DXC_EXEC = find_executable("dxc", "DXC_PATH")
_GLSLC_EXEC = find_executable("glslc", "GLSLC_PATH")
_SPIRV_CROSS_EXEC = find_executable("spirv-cross", "SPIRV_CROSS_PATH")
_TINT_EXEC = find_executable("tint", "TINT_PATH")


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
    if not any(executable for executable in (_GLSLC_EXEC, _TINT_EXEC)):
        raise RuntimeError(
            "glslc and tint are needed to compile shaders "
            "(install the VulkanSDK) and compile tint (https://dawn.googlesource.com/tint)."
        )


def validate_has_hlsl_executables():
    """Validate the local machine has the relevant executables needed.

    Raises:
        RuntimeError: Executables not found.
    """
    if not any(executable for executable in (_DXC_EXEC, _SPIRV_OPT_EXEC, _TINT_EXEC)):
        raise RuntimeError(
            "dxc, spirv-opt and tint are needed to compile shaders "
            "(install the VulkanSDK) and compile tint (https://dawn.googlesource.com/tint)."
        )


# TODO
