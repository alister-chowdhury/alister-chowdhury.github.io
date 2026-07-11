import re
import html.parser

# Based off entityref in html.parser itsel.
_TRUE_ENTITY_REF_RE = re.compile('^&([a-zA-Z][-.a-zA-Z0-9]*);')

def _detect_true_entityref(parser):
    """Detect if the currently parsed entityref has the form "&xxx;".

    Because of the way the parser works, it's liable to trigger for:
    ```
        memcpy(&z, ...) => memcpy(&z;, ...)
    ```
    Which isn't what you'd really want.

    Args:
        parser (html.parser.HTMLParser): Parser currently
            handling `handle_entityref`.

    Returns:
        bool: True if true entity ref.
    """
    current_line, current_offset = parser.getpos()
    # Line seems to randomly be offset by 1, no idea why
    line = parser.rawdata.split("\n", current_line)[-2]
    # Move to the relevant part
    line = line[current_offset:]
    if not line.startswith("&"):
        raise ValueError("entityref doesn't start with &!")
    return bool(_TRUE_ENTITY_REF_RE.match(line))

def _gen_entityref(parser, data):
    """Handle entityrefs consistently, by accounting for impartial matches.

    Args:
        parser (html.parser.HTMLParser): Parser currently
            handling `handle_entityref`.
        data (str): Data fed into `handle_entityref`.

    Returns:
        str: Formatted text.
    """
    if not _detect_true_entityref(parser):
        return "&{0}".format(data)
    else:
        return "&{0};".format(data)

class _BaseHtmlTransformer(html.parser.HTMLParser):
    """Base HTML transformer, used for other rendering ops."""

    def __init__(self):
        """Initializer."""
        super().__init__(convert_charrefs=False)
        self._parsed_data = []

    def get(self):
        """Get the rendered result.

        Returns:
            str: Rendered HTML.
        """
        return "".join(self._parsed_data)

    def _insert(self, data):
        """Insert parsed data into the buffer.

        Args:
            data (str): Data to enqueue.
        """
        self._parsed_data.append(data)

    def handle_startendtag(self, tag, attrs):
        """Handle a startendtag e.g: <div id="main">.

        Args:
            tag (str): HTML tag.
            attrs (list[tuple[str, str]]): Attributes.
        """
        self._insert(self.get_starttag_text())

    def handle_comment(self, comment):
        """Handle a comment e.g <!-- blah -->.

        Args:
            comment (str): Comment.
        """
        self._insert("<!--{0}-->".format(comment))

    def handle_data(self, data):
        """Handle data between tags (contents of script etc).

        Args:
            data (str): Inner data.
        """
        self._insert(data)

    def handle_decl(self, data):
        """Handle HTML doctype declaration e.g: <!DOCTYPE html>.

        Args:
            data (str): Decleration.
        """
        self._insert("<!{0}>".format(data))

    def handle_pi(self, data):
        """Handle processing instructions e.g: <?proc color='red'>.

        Args:
            data (str): Processing instruction.
        """
        self._insert("<?{0}>".format(data))

    def handle_charref(self, data):
        """Handle HTML charref declaration e.g: &#XXX;.

        Args:
            data (str): charref.
        """
        self._insert("&#{0};".format(data))

    def handle_entityref(self, data):
        """Handle HTML entity ref declaration e.g: &thing;.

        Args:
            data (str): entity ref.
        """
        self._insert(_gen_entityref(self, data))

    def handle_starttag(self, tag, attrs):
        """Handle the start of a tag e.g: <div id="main">.

        Args:
            tag (str): HTML tag.
            attrs (list[tuple[str, str]]): Attributes.
        """
        self._insert(self.get_starttag_text())

    def handle_endtag(self, tag):
        """Handle the end of a tag e.g: </div>.

        Args:
            tag (str): HTML tag.
        """
        self._insert("</{0}>".format(tag))
