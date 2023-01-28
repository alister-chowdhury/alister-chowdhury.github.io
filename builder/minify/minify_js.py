import os
import re
import requests

from .._cache import _test_cache, _insert_cache
from ._string_aware_strip import (
    _string_aware_comment_strip,
    _string_aware_generic_strip
)


_CACHE_DIR = os.path.abspath(os.path.join(__file__, "..", ".cache", "js"))
_TOPTAL_CACHE_DIR = os.path.join(_CACHE_DIR, "toptal")

_SINGLE_LINE_COMMENT_RE = re.compile(r"//.*")
_MULTI_LINE_COMMENT_RE = re.compile(r"/\*[\s\S]*?\*/")
_EXTRA_NEWLINES_RE = re.compile(r"\n{2,}")
_EXTRA_SPACES_RE = re.compile(r" {2,}")
_EXTRA_TABS_RE = re.compile(r"\t{2,}")


def _strip_comments(source):
    """Strip comments from Javascript source.

    Args:
        source (str): Input Javascript.

    Returns:
        str: Stripped source.
    """
    source = _string_aware_comment_strip(_SINGLE_LINE_COMMENT_RE, source)
    source = _string_aware_comment_strip(_MULTI_LINE_COMMENT_RE, source)
    return source


def _strip_whitespace(source, has_consistent_semicolons=True):
    """Strip excessive whitespace.

    Args:
        source (str): Input Javascript.
        has_consistent_semicolons (bool): If the source code
            has consistent semicolons. (Default: True)

    Returns:
        str: Stripped source.
    """
    base_op_characters = "[+-*^|&<>{;:?=,(!~/"
    semicolon_fragile_characters = ")]"
    if has_consistent_semicolons:
        base_op_characters += "}"
    else:
        semicolon_fragile_characters += "}"
    all_op_characters = semicolon_fragile_characters + base_op_characters

    # 1 + 2 + 3 => 1+2+3
    base_strip = re.compile(
        r"\s*([" + re.escape(base_op_characters) + r"])\s*"
    )

    # hello ] => hello]
    prefix_fragile_strip = re.compile(
        r"\s+([" + re.escape(semicolon_fragile_characters) + r"])"
    )

    # [ [ ] ] => [[]]
    sequential_operator_strip = re.compile(
        r"(["+ re.escape(all_op_characters) + r"])"
        r"\s+(?=[" + re.escape(all_op_characters) + r"])"
    )
    # )\n\n\nthing => )\nthing
    fragile_semicolon_strip = re.compile(
        r"\s*(["+ re.escape(semicolon_fragile_characters) + r"])\s+"
    )

    source = _string_aware_generic_strip(base_strip, lambda x: x.group(1), source)
    source = _string_aware_generic_strip(sequential_operator_strip, lambda x: x.group(1), source)
    source = _string_aware_generic_strip(prefix_fragile_strip, lambda x: "{0}\n".format(x.group(1)), source)
    source = _string_aware_generic_strip(fragile_semicolon_strip, lambda x: "{0}\n".format(x.group(1)), source)
    source = _string_aware_generic_strip(_EXTRA_NEWLINES_RE, lambda x: "\n", source)
    source = _string_aware_generic_strip(_EXTRA_SPACES_RE, lambda x: " ", source)
    source = _string_aware_generic_strip(_EXTRA_TABS_RE, lambda x: "\t", source)
    source = source.strip()
    return source


def _request_toptal_minify_js(source):
    """Request minifaction from Toptal.

    Args:
        source (str): Javascript to minify.

    Returns:
        tuple(bool, str): Success flag, minified text.
    """
    try:
        found, cached = _test_cache(_TOPTAL_CACHE_DIR, source)
        if found:
            return True, cached
        response = requests.post(
            "https://www.toptal.com/developers/javascript-minifier/api/raw",
            data={"input": source}
        )
        if response.ok:
            _insert_cache(_TOPTAL_CACHE_DIR, source, response.text)
            return True, response.text
    except Exception:
        pass
    return False, ""


def _minify_js(source, has_consistent_semicolons=True):
    """Minify Javascript source with custom minifier.

    Args:
        source (str): Javascript to minify.
        has_consistent_semicolons (bool): If the source code
            has consistent semicolons. (Default: True)

    Returns:
        str: Minified Javascript.
    """
    found, cached = _test_cache(_CACHE_DIR, source)
    if found:
        return cached
    minified = source
    minified = _strip_comments(minified)
    minified = _strip_whitespace(minified, has_consistent_semicolons)
    _insert_cache(_CACHE_DIR, source, minified)
    return minified


def minify_js(source, allow_toptol=True, has_consistent_semicolons=True):
    """Minify Javascript source.

    Args:
        source (str): Javascript to minify.
        allow_toptol (bool): Allow the use of www.toptol.com to
            minify (Default: True)
        has_consistent_semicolons (bool): If the source code
            has consistent semicolons. (Default: True)

    Returns:
        str: Minified Javascript.
    """
    source = source.strip()
    if not source:
        return source
    if allow_toptol:
        ok, minified = _request_toptal_minify_js(source)
        if ok:
           return minified
    return _minify_js(source, has_consistent_semicolons)
