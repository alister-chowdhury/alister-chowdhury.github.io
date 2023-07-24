import distutils.spawn
import os
import re
import subprocess
import tempfile


_DXC_EXEC = distutils.spawn.find_executable("dxc")
_GLSLC_EXEC = distutils.spawn.find_executable("glslc")
_SPIRV_OPT_EXEC = distutils.spawn.find_executable("spirv-opt")
_TINT_EXEC = distutils.spawn.find_executable("tint")


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
