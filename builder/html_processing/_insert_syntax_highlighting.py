from ._transformer_base import _BaseHtmlTransformer


_STYLESHEET_LINK = (
    '<link rel="stylesheet" href="/thirdparty/highlight.js.css">\n'
)


class _HtmlInsertSyntaxHighlighting(_BaseHtmlTransformer):
    """Helper parser to help with inserting syntax highlighting blocks."""

    def __init__(self):
        """Initializer."""
        super().__init__()
        self._used_languages = set()
        self._end_of_head_tag = None

    def handle_starttag(self, tag, attrs):
        """Handle the start of a tag e.g: <div id="main">.

        Args:
            tag (str): HTML tag.
            attrs (list[tuple[str, str]]): Attributes.
        """
        if tag == "code":
            code_class = next(
                (
                    value
                    for key, value in attrs
                    if key == "class"
                ),
                None
            )
            if code_class and code_class.startswith("language-"):
                self._used_languages.add(code_class[len("language-"):])
        super().handle_starttag(tag, attrs)

    def handle_endtag(self, tag):
        """Handle the end of a tag e.g: </div>.

        Args:
            tag (str): HTML tag.
        """
        if tag == "head":
            self._end_of_head_tag = len(self._parsed_data)

        elif tag == "body" and self._used_languages:
            if self._end_of_head_tag is not None:
                self._parsed_data.insert(
                    self._end_of_head_tag,
                    _STYLESHEET_LINK
                )
            self._insert(
                """
<script>
async function _hsInit(...langs){{
    for(const lang of langs)
    {{
        let script = document.createElement("script");
        script.src = "/thirdparty/languages/" + lang +".min.js";
        script.async = true;
        script.onload = function(l){{
            return function()
            {{
                document.querySelectorAll("pre code.language-" + l)
                .forEach(hljs.highlightElement);
            }};
        }}
        (lang);
        document.body.appendChild(script);
    }}
}}
</script>
<script async src="/thirdparty/highlight.min.js" onload="_hsInit({0});">
</script>""".format(",".join(
                    "'{0}'".format(lang)
                    for lang in sorted(self._used_languages)
                ))
            )

        super().handle_endtag(tag)


def insert_syntax_highlighting(source):
    """Insert syntax highlighting.

    Args:
        source (str): Source HTML, should already have been rendered with
            markdown.

    Returns:
        str: Rendered HTML.
    """
    if "code" not in source:
        return source
    if "language-" not in source:
        return source
    renderer = _HtmlInsertSyntaxHighlighting()
    renderer.feed(source)
    return renderer.get()
