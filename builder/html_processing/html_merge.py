from ._transformer_base import _BaseHtmlTransformer


class HtmlSections(object):
    """Wrapper around different sections to insert."""

    def __init__(
            self,
            pre_head="",
            head="",
            head_to_body="",
            body="",
            post_body=""):
        """Initializer.

        Args:
            pre_head (str): Data before the head tag. (Default: "")
            head (str): Data in the head tag. (Default: "")
            head_to_body (str): Data between the head and body tag.
                (Default: "")
            body (str): Data in the body. (Default: "")
            post_body (str): Data after the body. (Default: "")
        """
        self.pre_head = pre_head
        self.head = head
        self.head_to_body = head_to_body
        self.body = body
        self.post_body = post_body


class _HtmlExtractSections(_BaseHtmlTransformer):
    """Helper parser to help with extracting sections."""

    def __init__(self):
        """Initializer."""
        super().__init__()
        self._pre_head = []
        self._head = []
        self._head_to_body = []
        self._body = []
        self._post_body = []
        self._parsed_data = self._pre_head

    def get(self):
        """Get the collected sections.

        Returns:
            HtmlSections: Gathered sections.
        """
        return HtmlSections(
            "".join(self._pre_head),
            "".join(self._head),
            "".join(self._head_to_body),
            "".join(self._body),
            "".join(self._post_body)
        )

    def handle_starttag(self, tag, attrs):
        """Handle the start of a tag e.g: <div id="main">.

        Args:
            tag (str): HTML tag.
            attrs (list[tuple[str, str]]): Attributes.
        """
        if tag == "head":
            self._parsed_data = self._head
        elif tag == "body":
            self._parsed_data = self._body
        else:
            super().handle_starttag(tag, attrs)

    def handle_endtag(self, tag):
        """Handle the end of a tag e.g: </div>.

        Args:
            tag (str): HTML tag.
        """
        if tag == "head":
            self._parsed_data = self._head_to_body

        elif tag == "body":
            self._parsed_data = self._post_body
        else:
            super().handle_endtag(tag)



class _HtmlInsertBeforeSections(_BaseHtmlTransformer):
    """Helper parser to help with inserting sections before existing code.

        e.g for header templates.
    """

    def __init__(self, html_sections):
        """Initializer."""
        super().__init__()
        self._html_sections = html_sections
        self._insert(html_sections.pre_head)


    def handle_starttag(self, tag, attrs):
        """Handle the start of a tag e.g: <div id="main">.

        Args:
            tag (str): HTML tag.
            attrs (list[tuple[str, str]]): Attributes.
        """
        super().handle_starttag(tag, attrs)
        if tag == "head":
            self._insert(self._html_sections.head)
        elif tag == "body":
            self._insert(self._html_sections.body)

    def handle_endtag(self, tag):
        """Handle the end of a tag e.g: </div>.

        Args:
            tag (str): HTML tag.
        """
        super().handle_endtag(tag)
        if tag == "head":
            self._insert(self._html_sections.head_to_body)
        elif tag == "body":
            self._insert(self._html_sections.post_body)


class _HtmlInsertAfterSections(_BaseHtmlTransformer):
    """Helper parser to help with inserting sections after existing code.

        e.g for footer templates.
    """

    def __init__(self, html_sections):
        """Initializer."""
        super().__init__()
        self._html_sections = html_sections

    def get(self):
        """Get the rendered result.

        Returns:
            str: Rendered HTML.
        """
        return "{0}{1}".format(
            super().get(),
            self._html_sections.post_body
        )

    def handle_starttag(self, tag, attrs):
        """Handle the start of a tag e.g: <div id="main">.

        Args:
            tag (str): HTML tag.
            attrs (list[tuple[str, str]]): Attributes.
        """
        if tag == "head":
            self._insert(self._html_sections.pre_head)
        elif tag == "body":
            self._insert(self._html_sections.head_to_body)
        super().handle_starttag(tag, attrs)

    def handle_endtag(self, tag):
        """Handle the end of a tag e.g: </div>.

        Args:
            tag (str): HTML tag.
        """
        if tag == "head":
            self._insert(self._html_sections.head)
        elif tag == "body":
            self._insert(self._html_sections.body)
        super().handle_endtag(tag)


def extract_html_sections(source):
    """Extract HTML sections.

    Args:
        source (str): Source HTML.

    Returns:
        HtmlSections: Extracted sections.
    """
    renderer = _HtmlExtractSections()
    renderer.feed(source)
    return renderer.get()


def merge_html(source, html_sections, after_existing=False):
    """Merged extracted HTML sections into existing HTML source.

    Args:
        source (str): Source HTML.
        html_sections (HtmlSections): Sections to insert.
        after_existing (bool): Whether or not to insert after existing code
            (e.g inserting a footer). (Default: False).

    Returns:
        HtmlSections: Extracted sections.
    """
    renderer_cls = (
        _HtmlInsertAfterSections
        if after_existing
        else _HtmlInsertBeforeSections
    )
    renderer = renderer_cls(html_sections)
    renderer.feed(source)
    return renderer.get()
