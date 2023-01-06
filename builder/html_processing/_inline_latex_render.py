import html
import distutils.spawn
import os
import subprocess

from ._transformer_base import _BaseHtmlTransformer
from .._cache import _test_cache, _insert_cache


_CACHE_DIR = os.path.abspath(os.path.join(__file__, "..", ".cache", "katex"))
_NODE_EXEC = distutils.spawn.find_executable("node")
_KATEX_DIR_PATH = os.path.abspath(os.path.join(
    __file__,
    "..",
    "..",
    "..",
    "_source",
    "thirdparty"
))
_RENDER_COMMAND = (
    "const katex = require('./katex.min.js');"
    "console.log(katex.renderToString(process.argv[1], "
    "{output: 'html', throwOnError: false, displayMode: true, strict: 'ignore'}))"
)

_STYLESHEET_LINK = (
    '<link rel="stylesheet" href="/thirdparty/katex.min.css">\n'
)


class _HtmlKatexReduction(_BaseHtmlTransformer):
    """Helper parser to help with reducing KaTeX."""

    def __init__(self):
        """Initializer."""
        super().__init__()
        self._class_chain = []
        self._class_sizes = []
        self._should_keep_chain = []

    def handle_starttag(self, tag, attrs):
        """Handle the start of a tag e.g: <div id="main">.

        Args:
            tag (str): HTML tag.
            attrs (list[tuple[str, str]]): Attributes.
        """
        classes_used = []
        custom_style = None
        
        # Initial pass where we peek into the styling
        # properties of the span.
        for key, value in attrs:
            if key == "style":
                custom_style = value
            elif key == "class":
                while "  " in value:
                    value = value.replace("  ", " ")
                classes_used = value.split(" ")

        # This is a bit confusing to look at, but as an example dry run:
        #
        #  classes_used = ["A", "B", "C"]
        #   if last_buffer.endswith(["A", "B", "C"]):
        #       classes_used = []
        #
        #   elif last_buffer.endswith(["A", "B"]):
        #       classes_used = ["C"]
        #
        #   elif last_buffer.endswith(["A"]):
        #       classes_used = ["B", "C"]
        #
        for i in range(len(classes_used), 0, -1):
            match_a = self._class_chain[-i:]
            match_b = classes_used[:i]
            if match_a == match_b:
                classes_used = classes_used[i:]
                break

        # Remove katex-display, it's been purposefully removed
        # from the css, cus big integrals and sums are desirable
        # but we don't want it to just start centering everytthing,
        # that can be controlled externally.
        classes_used = [
            katex_class
            for katex_class in classes_used
            if katex_class != "katex-display"
        ]

        result = "<{0}".format(tag)
        for key, value in attrs:
            value = html.escape(value)
            if key == "class":
                if not classes_used:
                    continue
                value = " ".join(classes_used)
            result = "{0} {1}=\"{2}\"".format(
                result, key, value
            )

        # We treat inline styles as if they are a class,
        # this makes it easier to back track through
        # the chain and invalidate false overrideables
        if custom_style:
            classes_used.append(custom_style)
        self._class_sizes.append(len(classes_used))
        self._class_chain.extend(classes_used)

        result = "{0}>".format(result)

        # Strip spans which contribute nothing.
        should_keep = result != "<span>"
        self._should_keep_chain.append(should_keep)

        if should_keep:
            self._insert(result)

    def handle_endtag(self, tag):
        """Handle the end of a tag e.g: </div>.

        Args:
            tag (str): HTML tag.
        """
        num_classes = self._class_sizes.pop()
        self._class_chain = self._class_chain[:-num_classes]
        if self._should_keep_chain.pop():
            super().handle_endtag(tag)


def _katex_reduce_html(source):
    """Remove redundancies from prerendered KaTeX.

    This removes excess class attributes, such as:
    ```html
        <span class="mord">
            <span class="mord mathnormal">x</span>
        </span>
        <span class="mord mathnormal">
            <span class="mord mathnormal">y</span>
        </span>
    ```

    into

    ```html
    <span class="mord">
        <span class="mathnormal">x</span>
    <span>
    <span class="mord mathnormal">
        <span>y</span>
    <span>
    ```

    Args:
        source (type): [description]

    Returns:
        str: Reduced HTML.
    """
    renderer = _HtmlKatexReduction()
    renderer.feed(source)
    return renderer.get()


def _render_katex(equation):
    """Render an equation to HTML using KaTex

    Args:
        equation (str): Equation to evaluate.

    Returns:
        str: Rendered equation.
    """
    found, cached = _test_cache(_CACHE_DIR, equation)
    if found:
        return cached
    result = subprocess.check_output(
        (
            _NODE_EXEC,
            "-e",
            _RENDER_COMMAND,
            equation
        ),
        cwd=_KATEX_DIR_PATH
    )
    if not isinstance(result, str):
        result = result.decode("utf8")
    result = _katex_reduce_html(result)
    _insert_cache(_CACHE_DIR, equation, result)
    return result


class _HtmlResolveLatex(_BaseHtmlTransformer):
    """Helper parser to help with inserting latex blocks."""

    def __init__(self):
        """Initializer."""
        super().__init__()
        self._needs_latex = False
        self._needs_latex_js = False
        self._latex_buffer = ""
        self._in_latex = False
        self._end_of_head_tag = None

    def handle_data(self, data):
        """Handle data between tags (contents of script etc).

        Args:
            data (str): Inner data.
        """
        if self._in_latex:
            self._latex_buffer += data
        else:
            super().handle_data(data)

    def handle_starttag(self, tag, attrs):
        """Handle the start of a tag e.g: <div id="main">.

        Args:
            tag (str): HTML tag.
            attrs (list[tuple[str, str]]): Attributes.
        """
        if tag == "latex":
            self._needs_latex = True
            prerender = next(
                (
                    value
                    for key, value in attrs
                    if key == "prerender"
                ),
                "1"
            )
            if _NODE_EXEC and prerender in ("1", "true", "True"):
                self._in_latex = True
                self._latex_buffer = ""
            else:
                self._insert('<!--minify-off-->\n<span class="rtlatex">')
                self._needs_latex_js = True
        else:
            super().handle_starttag(tag, attrs)

    def handle_endtag(self, tag):
        """Handle the end of a tag e.g: </div>.

        Args:
            tag (str): HTML tag.
        """
        if tag == "head":
            self._end_of_head_tag = len(self._parsed_data)

        elif tag == "latex":
            if self._in_latex:
                self._in_latex = False
                self._insert(_render_katex(self._latex_buffer))
            else:
                self._insert("</span>\n<!--minify-on-->")
            return


        elif tag == "body" and self._needs_latex:
            if self._end_of_head_tag is not None:
                self._parsed_data.insert(
                    self._end_of_head_tag,
                    _STYLESHEET_LINK
                )

            if self._needs_latex_js:
                self._insert("""
<script>
async function _ktxInit()
{
    document.querySelectorAll("span.rtlatex").forEach(
        function(v)
        {
            katex.render(
                v.innerText,
                v,
                {output: 'html', throwOnError: false, displayMode: true, strict: 'ignore'}
            );
        }
    );
}
</script>
<script async src="/thirdparty/katex.min.js" onload="_ktxInit();"></script>
""")

        super().handle_endtag(tag)


def inline_latex_render(source):
    """Render latex nested inside html source code.

    Args:
        source (str): Source HTML, Markdown should be inside of latex tags.

    Returns:
        str: Rendered HTML.
    """
    if "latex" not in source:
        return source
    renderer = _HtmlResolveLatex()
    renderer.feed(source)
    return renderer.get()
