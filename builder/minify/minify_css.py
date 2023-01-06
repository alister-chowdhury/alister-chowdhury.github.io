import os
import re
import requests

from .._cache import _test_cache, _insert_cache
from ._string_aware_strip import (
    _string_aware_comment_strip,
    _string_aware_generic_strip
)


_CACHE_DIR = os.path.abspath(os.path.join(__file__, "..", ".cache", "css"))
_TOPTAL_CACHE_DIR = os.path.join(_CACHE_DIR, "toptal")

_MULTI_LINE_COMMENT_RE = re.compile(r"/\*[\s\S]*?\*/")
_OPERATOR_WHITESPACE_RE = re.compile(
    r"\s*([\[\]+\-\*^|&<>{};:\?\=,\(\)\!\~/])\s*"
)
_RGBA_CODE_RE = re.compile(r"rgba\((\d{1,3}),(\d{1,3}),(\d{1,3}),(\d{1,3})\)")
_RGB_CODE_RE = re.compile(r"rgb\((\d{1,3}),(\d{1,3}),(\d{1,3})\)")
_LAST_PROPERTY_SEMICOLON_RE = re.compile(r";\s*\}")
_LAST_PROPERTY_SEMICOLON_INLINE_RE = re.compile(r";\s*\Z")
_FLOAT_LEADING_ZEROS_RE = re.compile(r"(\d+)\.0+(?!\d)")
_FLOAT_TRAILING_ZEROS_RE = re.compile(r"(?<!\d)0+(\.\d+)")


_EMPTY_RULE_RE = re.compile(r"[^}]+{\s*}")


def _request_toptal_minify_css(source):
    """Request minifaction from Toptal.

    Args:
        source (str): CSS to minify.

    Returns:
        tuple(bool, str): Success flag, minified text.
    """
    try:
        found, cached = _test_cache(_TOPTAL_CACHE_DIR, source)
        if found:
            return True, cached
        response = requests.post(
            "https://www.toptal.com/developers/cssminifier/api/raw",
            data={"input": source}
        )
        if response.ok:
            _insert_cache(_TOPTAL_CACHE_DIR, source, response.text)
            return True, response.text
    except Exception:
        pass
    return False, ""


def _minify_css(source):
    """Minify CSS source with custom minifier.

    Args:
        source (str): CSS to minify.

    Returns:
        str: Minified CSS.
    """
    found, cached = _test_cache(_CACHE_DIR, source)
    if found:
        return cached

    minified = source
    minified = _string_aware_comment_strip(_MULTI_LINE_COMMENT_RE, minified)
    minified = _string_aware_generic_strip(_OPERATOR_WHITESPACE_RE, lambda x: x.group(1), minified)

    # rgba(1,2,3,4) => '#01020304'
    def rgba_to_hex_helper(match):
        try:
            r = int(match.group(1))
            g = int(match.group(2))
            b = int(match.group(3))
            a = int(match.group(4))
            if max(r, g, b, a) <= 255:
                return "#{0:02x}{1:02x}{2:02x}{3:02x}".format(r, g, b, a)
        except ValueError:
            pass
        return match.group(0)
    minified = _string_aware_generic_strip(_RGBA_CODE_RE, rgba_to_hex_helper, minified)

    # rgb(1,2,3) => '#010203'
    def rgb_to_hex_helper(match):
        try:
            r = int(match.group(1))
            g = int(match.group(2))
            b = int(match.group(3))
            if max(r, g, b) <= 255:
                return "#{0:02x}{1:02x}{2:02x}".format(r, g, b)
        except ValueError:
            pass
        return match.group(0)
    minified = _string_aware_generic_strip(_RGB_CODE_RE, rgb_to_hex_helper, minified)

    # Could reduce hex codes (#ffffff => #fff)
    # Could also strip colours (black => #000 etc)

    minified = _string_aware_generic_strip(_FLOAT_LEADING_ZEROS_RE, lambda x: x.group(1), minified)
    minified = _string_aware_generic_strip(_FLOAT_TRAILING_ZEROS_RE, lambda x: x.group(1), minified)
    minified = _string_aware_generic_strip(_LAST_PROPERTY_SEMICOLON_RE, lambda x: "}", minified)
    minified = _string_aware_generic_strip(_LAST_PROPERTY_SEMICOLON_INLINE_RE, lambda x: "", minified)
    minified = _string_aware_generic_strip(_EMPTY_RULE_RE, lambda x: "", minified)

    _insert_cache(_CACHE_DIR, source, minified)

    return minified


def minify_css(source, allow_toptol=False):
    """Minify CSS source.

    Args:
        source (str): CSS to minify.
        allow_toptol (bool): Allow the use of www.toptol.com to
            minify (Default: False)

    Returns:
        str: Minified CSS.
    """
    source = source.strip()
    if not source:
        return source
    if allow_toptol:
        ok, minified = _request_toptal_minify_css(source)
        if ok:
           return minified
    return _minify_css(source)
