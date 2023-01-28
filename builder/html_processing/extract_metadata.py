import html.parser


class _HtmlExtractMetadata(html.parser.HTMLParser):
    """Helper parser to help with extraction."""

    def __init__(self):
        """Initializer."""
        super().__init__(convert_charrefs=False)
        self.metadata = {}
        self.title = ""
        self._in_title = False

    def handle_startendtag(self, tag, attrs):
        """Handle a startendtag e.g: <div id="main">.

        Args:
            tag (str): HTML tag.
            attrs (list[tuple[str, str]]): Attributes.
        """
        self.handle_starttag(tag, attrs)

    def handle_starttag(self, tag, attrs):
        """Handle the start of a tag e.g: <div id="main">.

        Args:
            tag (str): HTML tag.
            attrs (list[tuple[str, str]]): Attributes.
        """
        if tag == "meta":
            mapping = dict(attrs)
            name = mapping.get("name")
            content = mapping.get("content")
            if name is not None and content is not None:
                self.metadata[name] = content
        elif tag == "title":
            self._in_title = True

    def handle_data(self, data):
        """Handle data between tags (contents of script etc).

        Args:
            data (str): Inner data.
        """
        if self._in_title:
            self.title += data

    def handle_endtag(self, tag):
        """Handle the end of a tag e.g: </div>.

        Args:
            tag (str): HTML tag.
        """
        if tag == "title":
            self._in_title = False


def extract_metadata(source):
    """Extract metadata from a HTML document.

    Args:
        source (str): Source HTML.

    Returns:
        str, dict[str,str]: title, meta tags.
    """
    extractor = _HtmlExtractMetadata()
    extractor.feed(source)
    return extractor.title, extractor.metadata
