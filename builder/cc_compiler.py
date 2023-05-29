import distutils.spawn
import subprocess
import tempfile
import os

_CLANG_EXEC = distutils.spawn.find_executable("clang")
_CLANGPP_EXEC = distutils.spawn.find_executable("clang++")
_LLVM_AR_EXEC = distutils.spawn.find_executable("llvm-ar")
_WASM_LD_EXEC = distutils.spawn.find_executable("wasm-ld")


_MINISTL_ROOT = os.path.abspath(os.path.join(
    __file__,
    "..",
    "..",
    "_source",
    "ministl"
))

MINISTL_INCLUDE_DIR = os.path.join(
    _MINISTL_ROOT,
    "include"
)

MINISTL_SIMPLE_MALLOC_STATIC_LIB = os.path.join(
    _MINISTL_ROOT,
    "ministl_simplemalloc.lib"
)



def _check_call(cmd):
    """Run subprocess.check_call, but actually print out the cmdline if
    it fails.

    Args:
        cmd (list[str]): Cmd to execute
    """
    try:
        subprocess.check_call(cmd)
    except Exception as err:
        print("ERROR Executing:\n{0}\n".format(subprocess.list2cmdline(cmd)))
        raise err


def _tuple_if_str(value):
    """Tupleify a value if it's a string.

    Args:
        value (object): Object to test.

    Returns:
        tuple: Tuple of object if it's a string, else the original object.
    """
    if isinstance(value, str):
        return (value,)
    return value


def validate_has_c_executables():
    """Validate the local machine has the relevant executables needed.

    Raises:
        RuntimeError: Executables not found.
    """
    if not _CLANG_EXEC:
        raise RuntimeError(
            "clang is needed to compile c "
            "(install LLVM)"
        )


def validate_has_cpp_executables():
    """Validate the local machine has the relevant executables needed.

    Raises:
        RuntimeError: Executables not found.
    """
    if not _CLANGPP_EXEC:
        raise RuntimeError(
            "clang++ is needed to compile c++ "
            "(install LLVM)"
        )


def validate_has_link_executables():
    """Validate the local machine has the relevant executables needed.

    Raises:
        RuntimeError: Executables not found.
    """
    if not _WASM_LD_EXEC:
        raise RuntimeError(
            "wasm-ld is needed to link "
            "(install LLVM)"
        )


def validate_has_static_lib_executables():
    """Validate the local machine has the relevant executables needed.

    Raises:
        RuntimeError: Executables not found.
    """
    if not _LLVM_AR_EXEC:
        raise RuntimeError(
            "llvm-ar is needed to create static libraries "
            "(install LLVM)"
        )


def _get_compile_obj_args(
        executable,
        filepath,
        out_file,
        include_paths=None,
        extra_args=None):
    """Compiles c or c++ into a wasm object object file.

    Args:
        executable(str): Executable to use.
        filepath(str): Filepath of c/c++ source to compile.
        out_file(str): Filepath to write the object file too.
        include_paths(iterable[str]): Extra paths to include (Default: None)
        extra_args(iterable[str]): Extra args to pass to clang.
            (Default: None)

    Returns:
        list[str]: Arguments to execute.
    """
    args = [
        executable,
        "-c",
        "--target=wasm32",
        "-mbulk-memory",
        "-flto",
        "-O3",
        "-ffast-math",
    ]

    if extra_args:
        args.extend(_tuple_if_str(extra_args))

    if include_paths:
        for path in include_paths:
            args.extend(("-I", path))
    args.extend((filepath, "-o", out_file))
    return args


def get_compile_c_args(
        filepath,
        out_file,
        include_paths=None,
        extra_args=None):
    """Compiles c into a wasm object object file.

    Args:
        filepath(str): Filepath of c source to compile.
        out_file(str): Filepath to write the object file too.
        include_paths(iterable[str]): Extra paths to include (Default: None)
        extra_args(iterable[str]): Extra args to pass to clang.
            (Default: None)

    Returns:
        list[str]: Arguments to execute.
    """
    validate_has_c_executables()
    return _get_compile_obj_args(
        _CLANG_EXEC,
        filepath,
        out_file,
        include_paths=include_paths,
        extra_args=extra_args
    )


def get_compile_cpp_args(
        filepath,
        out_file,
        include_paths=None,
        extra_args=None):
    """Compiles cpp into a wasm object object file.

    Args:
        filepath(str): Filepath of c source to compile.
        out_file(str): Filepath to write the object file too.
        include_paths(iterable[str]): Extra paths to include (Default: None)
        extra_args(iterable[str]): Extra args to pass to clang.
            (Default: None)

    Returns:
        list[str]: Arguments to execute.
    """
    validate_has_c_executables()
    return _get_compile_obj_args(
        _CLANG_EXEC,
        filepath,
        out_file,
        include_paths=include_paths,
        extra_args=extra_args
    )


def get_static_lib_args(
        files,
        out_file,
        extra_args=None):
    """Create a static library from object files..

    Args:
        files(str): Filepaths to link.
        out_file(str): Filepath to write the archive file too.
        extra_args(iterable[str]): Extra args to pass to clang.
            (Default: None)

    Returns:
        list[str]: Arguments to execute.
    """
    validate_has_static_lib_executables()
    args = [
        _LLVM_AR_EXEC,
        "rc",
        out_file
    ]

    if extra_args:
        args.extend(_tuple_if_str(extra_args))

    args.extend(files)
    return args


def get_linker_args(
        files,
        out_file,
        stack_size=None,
        extra_args=None):
    """Links object/static libs into a .wasm file.

    Args:
        files(str): Filepaths to link.
        out_file(str): Filepath to write the wasm file too.
        stack_size(int or NoneType): Override the stack size,
            default is one page, if you have no recursion this
            can be set to 0. (Default: None)
        extra_args(iterable[str]): Extra args to pass to clang.
            (Default: None)

    Returns:
        list[str]: Arguments to execute.
    """
    validate_has_link_executables()
    args = [
        _WASM_LD_EXEC,

        # Default base is 1024, which rather wasteful
        # 16 is chosen as it prevents ever having a
        # 0 address and should align to all known
        # __BIGGEST_ALIGNMENT__ values.
        "--global-base=16",

        "--no-entry",
        "--strip-all",
        "--export-dynamic",
        "--gc-sections",
        "--lto-O3",
        "-O3",
    ]

    if stack_size is not None:
        args.extend("-z", "stack-size={0}".format(stack_size))

    if extra_args:
        args.extend(_tuple_if_str(extra_args))

    args.extend(files)
    args.extend(("-o", out_file))
    return args


####


def compile_c(
        filepath,
        out_file,
        include_paths=None,
        extra_args=None):
    """Compiles c into a wasm object object file.

    Args:
        filepath(str): Filepath of c source to compile.
        out_file(str): Filepath to write the object file too.
        include_paths(iterable[str]): Extra paths to include (Default: None)
        extra_args(iterable[str]): Extra args to pass to clang.
            (Default: None)
    """
    _check_call(get_compile_c_args(
        filepath,
        out_file,
        include_paths=include_paths,
        extra_args=extra_args
    ))


def compile_cpp(
        filepath,
        out_file,
        include_paths=None,
        extra_args=None):
    """Compiles cpp into a wasm object object file.

    Args:
        filepath(str): Filepath of c source to compile.
        out_file(str): Filepath to write the object file too.
        include_paths(iterable[str]): Extra paths to include (Default: None)
        extra_args(iterable[str]): Extra args to pass to clang.
            (Default: None)
    """
    _check_call(get_compile_cpp_args(
        filepath,
        out_file,
        include_paths=include_paths,
        extra_args=extra_args
    ))


def make_static_lib(
        files,
        out_file,
        extra_args=None):
    """Create a static library from object files..

    Args:
        files(str): Filepaths to link.
        out_file(str): Filepath to write the archive file too.
        extra_args(iterable[str]): Extra args to pass to clang.
            (Default: None)
    """
    _check_call(get_static_lib_args(
        files,
        out_file,
        extra_args=extra_args
    ))


def link(
        files,
        out_file,
        stack_size=None,
        extra_args=None):
    """Links object/static libs into a .wasm file.

    Args:
        files(str): Filepaths to link.
        out_file(str): Filepath to write the wasm file too.
        stack_size(int or NoneType): Override the stack size,
            default is one page, if you have no recursion this
            can be set to 0. (Default: None)
        extra_args(iterable[str]): Extra args to pass to clang.
            (Default: None)
    """
    _check_call(get_linker_args(
        files,
        out_file,
        stack_size=stack_size,
        extra_args=extra_args
    ))
