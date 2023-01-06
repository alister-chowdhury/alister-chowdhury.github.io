import re

# TODO: Inline this into the project?
import mistune
_markdown_render = mistune.html

from ._transformer_base import _BaseHtmlTransformer


class _HtmlMarkdownRenderer(_BaseHtmlTransformer):
    """Helper parser to help with rendering inline <markdown>."""

    def __init__(self):
        """Initializer."""
        super().__init__()
        self._in_markdown = False
        self._markdown_data = None

    def handle_data(self, data):
        """Handle data between tags (contents of script etc).

        Args:
            data (str): Inner data.
        """
        if self._in_markdown:
            self._markdown_data += data
        else:
            super().handle_data(data)

    def handle_charref(self, data):
        """Handle HTML charref declaration e.g: &#XXX;.

        Args:
            data (str): charref.
        """
        if self._in_markdown:
            self._markdown_data += "&#{0};".format(data)
        else:
            super().handle_charref(data)

    def handle_entityref(self, data):
        """Handle HTML entity ref declaration e.g: &thing;.

        Args:
            data (str): entity ref.
        """
        if self._in_markdown:
            self._markdown_data += "&{0};".format(data)
        else:
            super().handle_entityref(data)


    def handle_startendtag(self, tag, attrs):
        """Handle a startendtag e.g: <div id="main">.

        Args:
            tag (str): HTML tag.
            attrs (list[tuple[str, str]]): Attributes.
        """
        if self._in_markdown:
            self._markdown_data += self.get_starttag_text()
        else:
            super().handle_startendtag(tag, attrs)

    def handle_comment(self, comment):
        """Handle a comment e.g <!-- blah -->.

        Args:
            comment (str): Comment.
        """
        if self._in_markdown:
            self._markdown_data += "<!--{0}-->".format(comment)
        else:
            super().handle_comment(comment)

    def handle_starttag(self, tag, attrs):
        """Handle the start of a tag e.g: <div id="main">.

        Args:
            tag (str): HTML tag.
            attrs (list[tuple[str, str]]): Attributes.
        """
        if tag == "markdown":
            self._in_markdown = True
            self._markdown_data = ""
        elif self._in_markdown:
            self._markdown_data += self.get_starttag_text()
        else:
            super().handle_starttag(tag, attrs)

    def handle_endtag(self, tag):
        """Handle the end of a tag e.g: </div>.

        Args:
            tag (str): HTML tag.
        """
        if tag == "markdown" and self._in_markdown:
            self._insert(_markdown_render(self._markdown_data))
            self._in_markdown = False
        elif self._in_markdown:
            self._markdown_data += "</{0}>".format(tag)
        else:
            super().handle_endtag(tag)


def inline_markdown_render(source):
    """Render markdown nested inside html source code.

    Args:
        source (str): Source HTML, Markdown should be inside of markdown tags.

    Returns:
        str: Rendered HTML.
    """
    if "markdown" not in source:
        return source
    renderer = _HtmlMarkdownRenderer()
    renderer.feed(source)
    return renderer.get()
