import os
from numpy import float32
import re
import shutil

# Use glsl reserved words as a basis
from .._cache import _test_cache, _insert_cache
from ._string_aware_strip import (
    _string_aware_comment_strip,
    _string_aware_generic_strip
)
from ._wgsl_reserved import _WGSL_RESERVED


_SINGLE_LINE_COMMENT_RE = re.compile(r"//.*")
_MULTI_LINE_COMMENT_RE = re.compile(r"/\*[\s\S]*?\*/")
_CACHE_DIR = os.path.abspath(os.path.join(__file__, "..", ".cache", "wgsl"))
_DEBUGGING = False

if _DEBUGGING:
    if os.path.isdir(_CACHE_DIR):
        shutil.rmtree(_CACHE_DIR)

def _strip_comments(source):
    """Strip comments from Javascript source.

    Args:
        source (str): Input WGSL.

    Returns:
        str: Stripped source.
    """
    source = _string_aware_comment_strip(_SINGLE_LINE_COMMENT_RE, source)
    source = _string_aware_comment_strip(_MULTI_LINE_COMMENT_RE, source)
    return source


def _minify_shader_name_generator():
    """Generate shader variable names.

    Yields:
        str: Variable name.
    """
    remap_first_chars = "_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    remap_other_chars = "_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    next_id = 0
    
    while True:
        current_id = next_id
        next_id += 1
        current_name = remap_first_chars[current_id % len(remap_first_chars)]
        current_id = current_id // len(remap_first_chars)
        
        while current_id:
            current_name += remap_other_chars[current_id % (len(remap_other_chars) + 1) - 1]
            current_id //= len(remap_other_chars) + 1

        if current_name.lower().startswith("gl"):
            continue

        if "__" in current_name:
            continue

        if current_name not in _WGSL_RESERVED:
            yield current_name


def _minify_names(minified):
    """Minify names used.

    Args:
        minified (str): Input WGSL.

    Returns:
        str: Output wgsl.
    """
    name_generator = _minify_shader_name_generator()
    rename_mapping = {}

    def _rename_variable(match):
        """Fetch or create a corresponding minified variable name.

        Args:
            match (re.Match): Regex match object.

        Returns:
            str: Minified variable name.
        """
        var_name = match.group(1)

        if var_name in _WGSL_RESERVED:
            return var_name
 
        if var_name in rename_mapping:
            return rename_mapping[var_name]

        new_name = next(name_generator)
        rename_mapping[var_name] = new_name
        return new_name
    
    # Ensure @builtin(...) has no whitespace between
    # the brackets
    minified = re.sub(
        r"@builtin\(([^)]+)\)",
        lambda x: "@builtin({0})".format(x.group(1).strip()),
        minified
    )

    # Ignore @... and @builtin(...)
    minified = re.sub(
        r"\b((?<!@)(?<!builtin\()[A-Za-z_][A-Za-z_0-9]*)",
        _rename_variable,
        minified
    )

    if _DEBUGGING:
        for k,v in rename_mapping.items():
            print(k,"=>",v)

    return minified


def minify_wgsl(source):
    """Minify WGSL shader.

    Args:
        source (str): spirv-cross emitted shader source.

    Returns:
        str: Minified shader.
    """

    if not _DEBUGGING:
        found, cached = _test_cache(_CACHE_DIR, source)
        if found:
            return cached

    minified = source

    minified = _strip_comments(minified)
    minified = _minify_names(minified)

    # Replace vecX<Y> and matNxM<Y> values
    for r, p in (
            ("f32", "f"),
            ("i32", "i"),
            ("u32", "u"),
            ("f16", "h")
    ):
        minified = re.sub(
            r"\bvec(\d)<\s*{0}\s*>".format(r),
            lambda x: "vec{0}{1}".format(x.group(1), p),
            minified
        )
        minified = re.sub(
            r"\bmat(\d)x(\d)<\s*{0}\s*>".format(r),
            lambda x: "mat{0}x{1}{2}".format(
                x.group(1),
                x.group(2),
                p
            ),
            minified
        )

    # Minify numbers which have needless precision
    # e.g: 1.2000000476837158203125 => 1.2
    minified = re.sub(
        r"([+\-]?\d+\.\d+)f?",
        lambda x: str(float32(x.group(1))),
        minified
    )

    # Remove 0 suffixes from floats
    # 0.0 => 0.
    # 1.0 => 1.
    minified = re.sub(r"(\d+\.)0+(?!\d)", lambda x: x.group(1), minified)

    # Remove 0 prefixes from floats
    # 0.01 => .01
    # 0.1 => .1
    minified = re.sub(r"(?<!\d)0+(\.\d+)", lambda x: x.group(1), minified)

    # remove excessive whitespace
    minified = re.sub("\n+", "\n", minified)
    minified = re.sub(r" +", " ", minified)

    # NB removing `-`, naga seems to have parse issues:
    # https://github.com/gfx-rs/wgpu/issues/4941
    minified = re.sub(
        r"\s*([\[\]+\*\^|&<>{};:\?\=,\(\)\!\~/])\s*",
        lambda x: x.group(1),
        minified
    )

    # Explicit subtract for names
    minified = re.sub(
        r"\s*-\s*([A-Za-z_])",
        lambda x: "-{0}".format(x.group(1)),
        minified
    )

    if not _DEBUGGING:
        _insert_cache(_CACHE_DIR, source, minified)

    return minified
