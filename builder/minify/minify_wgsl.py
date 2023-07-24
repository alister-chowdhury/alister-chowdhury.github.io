import os
from numpy import float32
import re

from .._cache import _test_cache, _insert_cache
from ._string_aware_strip import (
    _string_aware_comment_strip,
    _string_aware_generic_strip
)


_SINGLE_LINE_COMMENT_RE = re.compile(r"//.*")
_MULTI_LINE_COMMENT_RE = re.compile(r"/\*[\s\S]*?\*/")


_CACHE_DIR = os.path.abspath(os.path.join(__file__, "..", ".cache", "wgsl"))


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


def minify_wgsl(source):
    """Minify WGSL shader.

    Args:
        source (str): spirv-cross emitted shader source.

    Returns:
        str: Minified shader.
    """
    found, cached = _test_cache(_CACHE_DIR, source)
    if found:
        return cached

    minified = source

    minified = _strip_comments(minified)

    # Remove 0 prefixes from floats
    # 0.01 => .01
    # 0.1 => .1
    minified = re.sub(r"(?<!\d)0+(\.\d+)", lambda x: x.group(1), minified)

    # remove excessive whitespace
    minified = re.sub("\n+", "\n", minified)
    minified = re.sub(r" +", " ", minified)

    # TODO: Should probably explicitly ignore any line that starts with "#"
    minified = re.sub(
        r"\s*([\[\]+\-\*^|&<>{};:\?\=,\(\)\!\~/])\s*",
        lambda x: x.group(1),
        minified
    )

    _insert_cache(_CACHE_DIR, source, minified)

    return minified
