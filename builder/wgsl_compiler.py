import distutils.spawn
import os
import re
import subprocess
import tempfile
from contextlib import contextmanager

# This attempts to deal with the current state of generating
# WGSL, which quite honestly is frustrating at best.
# You have two backends naga and tint, naga is easy to install,
# but lacks atomics (and doesn't work with vertex shaders, unless
# converted directly form glsl) and tint is a pain to setup, because
# you need to compile it yourself and doesn't support writing to
# integer textures.

_DXC_EXEC = distutils.spawn.find_executable("dxc")
_GLSLC_EXEC = distutils.spawn.find_executable("glslc")
_SPIRV_OPT_EXEC = distutils.spawn.find_executable("spirv-opt")
_SPIRV_DIS_EXEC = distutils.spawn.find_executable("spirv-dis")
_SPIRV_CROSS_EXEC = distutils.spawn.find_executable("spirv-cross")
_NAGA_EXEC = distutils.spawn.find_executable("naga")
_TINT_EXEC = distutils.spawn.find_executable("tint")


GLOBAL_SHADER_INCLUDE_DIR = os.path.abspath(
    os.path.join(__file__, "..", "..", "_source", "res", "shaders", "include")
)


def validate_has_naga_executables():
    """Validate the local machine has the relevant executables needed.

    Raises:
        RuntimeError: Executables not found.
    """
    if not any(executable for executable in (_NAGA_EXEC,)):
        raise RuntimeError(
            "naga is needed to compile shaders, "
            "go install it (cargo install naga-cli)."
        )


def validate_has_tint_executables():
    """Validate the local machine has the relevant executables needed.

    Raises:
        RuntimeError: Executables not found.
    """
    if not any(executable for executable in (_TINT_EXEC,)):
        raise RuntimeError(
            "tint is needed to compile shaders, "
            "compile tint (https://dawn.googlesource.com/tint)."
        )


def validate_has_glsl_executables():
    """Validate the local machine has the relevant executables needed.

    Raises:
        RuntimeError: Executables not found.
    """
    if not any(executable for executable in (
            _GLSLC_EXEC,
            _SPIRV_OPT_EXEC,
            _SPIRV_CROSS_EXEC
        )):
        raise RuntimeError(
            "glslc, spirv-opt and spirv-cross are needed to compile shaders "
            "(install the VulkanSDK)."
        )


def validate_has_hlsl_executables():
    """Validate the local machine has the relevant executables needed.

    Raises:
        RuntimeError: Executables not found.
    """
    if not any(executable for executable in (
            _DXC_EXEC,
            _SPIRV_OPT_EXEC,
            _SPIRV_CROSS_EXEC
        )):
        raise RuntimeError(
            "dxc, spirv-opt and spirv-cross are needed to compile shaders "
            "(install the VulkanSDK)."
        )


def _check_call(command):
    """Wrapper around subprocess.Popen.

    Similar to subprocess.check_call, but captures
    stdout and stderr.

    Args:
        command (iterable): Commandline.

    Raises:
        RuntimeError: [description]
    """
    proc = subprocess.Popen(
        command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, close_fds=True
    )
    stdout, stderr = proc.communicate()
    if proc.returncode != 0:
        message = "Commandline:\n{0}".format(subprocess.list2cmdline(command))
        if stdout:
            message = "{0}\n\nSTDOUT:\n{1}".format(
                message, stdout.decode("latin-1").strip()
            )
        if stderr:
            message = "{0}\n\nSTDERR:\n{1}".format(
                message, stderr.decode("latin-1").strip()
            )
        raise RuntimeError(message)


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

        # Breaks naga: https://github.com/gfx-rs/wgpu/issues/4916
        # "--target-env=vulkan1.1",

        "-O",
        filepath,
        "-o",
        out_spv_path,
    ]

    # write-only doesn't exist in wgsl and naga will
    # throw an error.

    glslc_command.append("-Dwriteonly=")

    if macros:
        for key, value in macros.items():
            glslc_command.append("-D{0}={1}".format(key, value))
    if includes:
        for include in includes:
            glslc_command.extend(("-I", include))
    _check_call(glslc_command)


def _opt_spirv(spv_path):
    """Runs typical optimization passes on the spirv code.

    Args:
        spv_path (str): Path to spirv
    """
    spirv_opt_cmd = [
        _SPIRV_OPT_EXEC,
        "--strip-debug",
        "--strip-nonsemantic",
        "-O",
        "--compact-ids",
        spv_path,
        "-o",
        spv_path,
    ]
    _check_call(spirv_opt_cmd)


@contextmanager
def _tmp_file(ext):
    """Helper context manager to generate temp files."""
    tmp_file = tempfile.NamedTemporaryFile(delete=False, suffix=ext)
    try:
        tmp_file.close()
        yield tmp_file.name
    finally:
        os.unlink(tmp_file.name)


@contextmanager
def _compiled_spv(filepath, macros=None, includes=None):
    """Compiles desktop glsl into a temporary spv file.

    Args:
        filepath(str): Filepath of shader to compile.
        macros(dict): Macros to define. (Default: None)
        includes(iterable): Directories to include. (Default: None)

    Yields:
        str: Path to compile spv.
    """
    with _tmp_file(".spv") as tmp_spv:
        try:
            _compile_to_spirv(
                tmp_spv, filepath, macros=macros, includes=includes
            )
            _opt_spirv(tmp_spv)
            yield tmp_spv
        except Exception as e:
            if _SPIRV_DIS_EXEC and os.path.isfile(tmp_spv):
                try:
                    spirv_dis = subprocess.check_output(
                        [_SPIRV_DIS_EXEC, tmp_spv]
                    ).decode("latin-1")
                    print("!!!!!COMPILE ERROR!!!!")
                    print("SPIRV-DIS")
                    print(spirv_dis)
                except Exception:
                    pass
                raise e


def _spirv_to_glsl(spv_path):
    """Decompile spirv to GLSL.

    Args:
        spv_path (str): Path to spirv file.

    Returns:
        str: GLSL
    """
    spirv_cross_command = [_SPIRV_CROSS_EXEC, "--vulkan-semantics", spv_path]
    return (
        subprocess.Popen(
            spirv_cross_command, stdout=subprocess.PIPE, close_fds=True
        )
        .stdout.read()
        .decode("latin-1")
    )


def _spv_glsl_to_wgsl_naga(src_filepath, spv_path, out_wgsl_path):
    """Decompile spv to glsl to wgsl via naga.

    Args:
        src_filepath (str): Input filepath.
        spv_path (str): Input spirv binary.
        out_wgsl_path (str): Output path to wgsl.
    """
    suffix = os.path.splitext(src_filepath)[-1].lower()
    with _tmp_file(suffix) as tmp_glsl:
        with open(tmp_glsl, "w") as out_fp:
            glsl = _spirv_to_glsl(spv_path)

            # Yet another naga bug: https://github.com/gfx-rs/wgpu/issues/4520
            # glslc and friends assume gl_VertexIndex to be int
            # but naga insists that it is uint.
            glsl = glsl.replace("gl_VertexIndex", "int(gl_VertexIndex)")
            out_fp.write(glsl)

        # Strip leading .
        stage = suffix[1:]
        
        if stage == "comp":
            stage = "compute"

        naga_cmd = [
            _NAGA_EXEC,
            "--input-kind",
            "glsl",
            "--shader-stage",
            stage,
            tmp_glsl,
            out_wgsl_path,
        ]
        _check_call(naga_cmd)


def _spirv_to_wgsl_naga(src_filepath, spv_path, out_wgsl_path):
    """Convert spirv to wgsl via naga.

    Args:
        src_filepath (str): Input src_filepath.
        spv_path (str): Input spirv binary.
        out_wgsl_path (str): Output path to wgsl.
    """
    validate_has_naga_executables()
    try:
        naga_cmd = [
            _NAGA_EXEC,
            "--input-kind",
            "spv",
            spv_path,
            out_wgsl_path,
        ]
        _check_call(naga_cmd)
    except Exception as naga_err:
        # Right, so naga just basically breaks
        # for any vertex shader, something about
        # clip distances being set, I have no idea
        # nor do I care.
        # But decompiling back to glsl will sometimes work.
        # https://github.com/gfx-rs/wgpu/issues/4915
        if _SPIRV_CROSS_EXEC:
            print("USING SPIRV->GLSL:\n{0}".format(naga_err))
            _spv_glsl_to_wgsl_naga(src_filepath, spv_path, out_wgsl_path)
            print("!SUCCESS!")
        else:
            raise naga_err


def _spirv_to_wgsl_tint(src_filepath, spv_path, out_wgsl_path):
    """Convert spirv to wgsl via tint.

    Args:
        src_filepath (str): Input filepath.
        spv_path (str): Input spirv binary.
        out_wgsl_path (str): Output path to wgsl.
    """
    validate_has_tint_executables()
    tint_cmd = [_TINT_EXEC, spv_path, "-o", out_wgsl_path]
    _check_call(tint_cmd)


def _spirv_to_wgsl_auto(src_filepath, spv_path, out_wgsl_path):
    """Convert spirv to wgsl via naga or tint.

    Args:
        src_filepath (str): Input filepath.
        spv_path (str): Input spirv binary.
        out_wgsl_path (str): Output path to wgsl.
    """
    try:
        _spirv_to_wgsl_naga(src_filepath, spv_path, out_wgsl_path)
    except Exception as naga_err:
        try:
            _spirv_to_wgsl_tint(src_filepath, spv_path, out_wgsl_path)
        except Exception as tint_err:

            raise RuntimeError(
                "Unable to compile:\n"
                "Naga error:\n"
                "{0}\n"
                "Tint error:\n"
                "{1}".format(naga_err, tint_err)
            )


def compile_glsl(filepath, macros=None, includes=None, backend=None):
    """Compiles desktop glsl into wgsl.

    Args:
        filepath(str): Filepath of shader to compile.
        macros(dict): Macros to define. (Default: None)
        includes(iterable): Directories to include. (Default: None)
        backend(str): Backend to use. (Default: None)

    Return:
        str: Compiled wgsl.
    """
    validate_has_glsl_executables()

    if backend:
        backend = backend.lower()
    backend_func = None
    if backend == "naga":
        backend_func = _spirv_to_wgsl_naga
    elif backend == "tint":
        backend_func = _spirv_to_wgsl_tint
    elif not backend:
        backend_func = _spirv_to_wgsl_auto
    else:
        raise ValueError("Unsupported backend: {0}".format(backend))

    tmp_wgsl = tempfile.NamedTemporaryFile(delete=False, suffix=".wgsl")
    with _tmp_file(".wgsl") as tmp_wgsl:
        with _compiled_spv(filepath, macros=macros, includes=includes) as tmp_spv:
            backend_func(filepath, tmp_spv, tmp_wgsl)
            with open(tmp_wgsl, "r") as in_fp:
                return in_fp.read()
