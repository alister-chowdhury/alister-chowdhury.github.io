import os

# TODO: Inline this into the project?
import mako.template
from ._transformer_base import _BaseHtmlTransformer


_REPO_ROOT = os.path.abspath(
    os.path.join(
        __file__,
        "..",
        "..",
        "..",
    )
)

_SOURCE_ROOT = os.path.join(_REPO_ROOT, "_source")
_BUILD_ROOT = os.path.join(_REPO_ROOT, "_build")


class _HtmlMakoRenderer(_BaseHtmlTransformer):
    """Helper parser to help with rendering inline <mako>."""

    def __init__(self, mako_variables):
        """Initializer."""
        super().__init__()
        self._mako_variables = mako_variables
        self._in_mako = False
        self._mako_data = None
        self._source_in_comment = False

    def handle_data(self, data):
        """Handle data between tags (contents of script etc).

        Args:
            data (str): Inner data.
        """
        if self._in_mako:
            self._mako_data += data
        else:
            super().handle_data(data)

    def handle_charref(self, data):
        """Handle HTML charref declaration e.g: &#XXX;.

        Args:
            data (str): charref.
        """
        if self._in_mako:
            self._mako_data += "&#{0};".format(data)
        else:
            super().handle_charref(data)

    def handle_entityref(self, data):
        """Handle HTML entity ref declaration e.g: &thing;.

        Args:
            data (str): entity ref.
        """
        if self._in_mako:
            self._mako_data += "&{0};".format(data)
        else:
            super().handle_entityref(data)


    def handle_startendtag(self, tag, attrs):
        """Handle a startendtag e.g: <div id="main">.

        Args:
            tag (str): HTML tag.
            attrs (list[tuple[str, str]]): Attributes.
        """
        if self._in_mako:
            self._mako_data += self.get_starttag_text()
        else:
            super().handle_startendtag(tag, attrs)

    def handle_comment(self, comment):
        """Handle a comment e.g <!-- blah -->.

        Args:
            comment (str): Comment.
        """
        if self._in_mako:
            if self._source_in_comment:
                self._mako_data += comment
            else:
                self._mako_data += "<!--{0}-->".format(comment)
        else:
            super().handle_comment(comment)

    def handle_starttag(self, tag, attrs):
        """Handle the start of a tag e.g: <div id="main">.

        Args:
            tag (str): HTML tag.
            attrs (list[tuple[str, str]]): Attributes.
        """
        if tag == "mako":
            self._in_mako = True
            self._mako_data = ""
            source_in_comment = next(
                (
                    value
                    for key, value in attrs
                    if key == "source_in_comment"
                ),
                "0"
            )
            self._source_in_comment = (
                source_in_comment in ("1", "true", "True")
            )
        elif self._in_mako:
            self._mako_data += self.get_starttag_text()
        else:
            super().handle_starttag(tag, attrs)

    def handle_endtag(self, tag):
        """Handle the end of a tag e.g: </div>.

        Args:
            tag (str): HTML tag.
        """
        if tag == "mako" and self._in_mako:
            self._insert(
                mako.template.Template(self._mako_data).render(
                    REPO_ROOT = _REPO_ROOT,
                    SOURCE_ROOT = _SOURCE_ROOT,
                    BUILD_ROOT = _BUILD_ROOT,
                    **self._mako_variables
                )
            )
            self._in_mako = False
        elif self._in_mako:
            self._mako_data += "</{0}>".format(tag)
        else:
            super().handle_endtag(tag)


def inline_mako_render(source, **mako_variables):
    """Render mako nested inside html source code.

    Args:
        source (str): Source HTML, mako should be inside of mako tags.
        **mako_variables: Variables to pass directly to mako.

    Returns:
        str: Rendered HTML.
    """
    if "mako" not in source:
        return source
    renderer = _HtmlMakoRenderer(mako_variables)
    renderer.feed(source)
    return renderer.get()
