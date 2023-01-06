import html.parser


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
        self._insert("&{0};".format(data))

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
