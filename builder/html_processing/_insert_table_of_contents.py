import re
import json
import string
from ._transformer_base import _BaseHtmlTransformer


# Ignoring h1, since it's used for the title
_HEADING_TYPES = {"h2", "h3", "h4", "h5", "h6"}


class _HeaderIdGenerator(object):
    """Helper for generating ids."""

    def __init__(self, existing_ids):
        """Initializer.

        Args:
            existing_ids (set[str]): Existing HTML ids.
        """
        self._existing_ids = existing_ids

    def get(self, header_text):
        """Get a non-conflicting id, give a headings inner text.

        Args:
            header_text (str): Text used in heading.

        Returns:
            str: Derived id.
        """
        # Keep everything lower case
        header_text = header_text.strip().lower()

        # Strip punctuation
        header_text = re.sub(
            "[{0}]".format(re.escape(string.punctuation)),
            "",
            header_text
        )

        # Replace whitespace or any exotic characters with dashes
        header_text = re.sub(
            r"[^a-z0-9]+",
            "-",
            header_text
        )

        # Id is free, yay.
        if header_text not in self._existing_ids:
            self._existing_ids.add(header_text)
            return header_text

        # Keep trying different numbers until it's fine.
        n = 2
        while True:
            new_header_text = "{0}{1}".format(header_text, n)
            if new_header_text not in self._existing_ids:
                self._existing_ids.add(new_header_text)
                return new_header_text
            n += 1


class _HtmlFindExistingIds(_BaseHtmlTransformer):
    """Helper parser to find existing ids, within the source."""

    def __init__(self):
        """Initializer."""
        super().__init__()
        self.existing_ids = set()
        self.handle_starttag = self.handle_startendtag

    def handle_startendtag(self, tag, attrs):
        """Handle a startendtag e.g: <div id="main">.

        Args:
            tag (str): HTML tag.
            attrs (list[tuple[str, str]]): Attributes.
        """
        found_id = next(
            (value for key, value in attrs if key == "id"),
            None
        )
        if found_id:
            self.existing_ids.add(found_id)


class _HtmlInsertMissingIds(_BaseHtmlTransformer):
    """Helper parser to add id attrs to headings."""

    def __init__(self, existing_ids):
        """Initializer."""
        super().__init__()
        self._id_generator = _HeaderIdGenerator(existing_ids)
        self._inside_heading_to_fill = False
        self._heading_attrs = None
        self._heading_data = None

    def _insert(self, data):
        """Insert parsed data into the buffer.

        Args:
            data (str): Data to enqueue.
        """
        if self._inside_heading_to_fill:
            self._heading_data += data
        else:
            super()._insert(data)

    def handle_starttag(self, tag, attrs):
        """Handle the start of a tag e.g: <div id="main">.

        Args:
            tag (str): HTML tag.
            attrs (list[tuple[str, str]]): Attributes.
        """
        if tag in _HEADING_TYPES:
            found_id = next(
                (key == "id" for key, _ in attrs),
                None
            )
            if not found_id:
                self._inside_heading_to_fill = True
                self._heading_attrs = list(attrs)
                self._heading_data = ""
                return
        
        super().handle_starttag(tag, attrs)

    def handle_endtag(self, tag):
        """Handle the end of a tag e.g: </div>.

        Args:
            tag (str): HTML tag.
        """
        if self._inside_heading_to_fill:
            if tag in _HEADING_TYPES:
                self._inside_heading_to_fill = False
                attrs = self._heading_attrs
                attrs.append((
                    "id",
                    self._id_generator.get(self._heading_data)
                ))
                tag_prefix = "<{0} {1}>".format(
                    tag,
                    " ".join(
                        "{0}={1}".format(
                            key,
                            json.dumps(value)
                        )
                        for key, value in attrs
                    )
                )
                super()._insert(tag_prefix)
                super()._insert(self._heading_data)
                self._heading_attrs = None
                self._heading_data = None
        super().handle_endtag(tag)


class _HtmlTableOfContentsPrepass(_BaseHtmlTransformer):
    """Helper parser to build hierachies for table of contents."""

    def __init__(self):
        """Initializer."""
        super().__init__()
        self.toc_hierachies = []
        self._toc_depth = None
        self._current_toc_hierachy = []
        self._heading_id = None
        self._heading_text = None
        self._tag_chain = []
        self._skipping = set()

    def _insert(self, data):
        """Insert parsed data into the buffer.

        Args:
            data (str): Data to enqueue.
        """
        if self._heading_id is not None:
            self._heading_text += data
        super()._insert(data)

    def finish_recording_toc(self):
        """Cleanup whatever table of contents remain."""
        if self._toc_depth is not None:
            self._toc_depth = None
            self.toc_hierachies.append(
                self._current_toc_hierachy
            )
            self._current_toc_hierachy = []

    def handle_startendtag(self, tag, attrs):
        """Handle a startendtag e.g: <div id="main">.

        Args:
            tag (str): HTML tag.
            attrs (list[tuple[str, str]]): Attributes.
        """
        if tag == "table_of_contents":
            self.finish_recording_toc()
            self._toc_depth = len(self._tag_chain)
            found_skipping = next(
                (value for key, value in attrs if key == "skip"),
                None
            )
            if found_skipping:
                self._skipping = set(
                    x.strip()
                    for x in found_skipping.split(",")
                )
            else:
                self._skipping = set()
        else:
            super().handle_startendtag(tag, attrs)

    def handle_starttag(self, tag, attrs):
        """Handle the start of a tag e.g: <div id="main">.

        Args:
            tag (str): HTML tag.
            attrs (list[tuple[str, str]]): Attributes.
        """
        self._tag_chain.append(tag)
        super().handle_starttag(tag, attrs)

        if self._toc_depth is not None:
            if tag in _HEADING_TYPES and tag not in self._skipping:
                # Assume this is always possible
                # because we fill in ids in a previous pass
                found_id = next(
                    value
                    for key, value in attrs
                    if key == "id"
                )
                self._heading_id = found_id
                self._heading_text = ""

    def handle_endtag(self, tag):
        """Handle the end of a tag e.g: </div>.

        Args:
            tag (str): HTML tag.
        """

        # Pop the chain, stomping over un-ended tags
        # e.g br
        while self._tag_chain:
            if self._tag_chain.pop() == tag:
                break

        # End of table of contents parent
        if self._toc_depth is not None:
            if self._toc_depth > len(self._tag_chain):
                self.finish_recording_toc()
        
            if tag in _HEADING_TYPES and tag not in self._skipping:
                if self._heading_id and self._heading_text:
                    self._current_toc_hierachy.append({
                        "tag": tag,
                        "id": self._heading_id,
                        "text": self._heading_text.strip()
                    })
                self._heading_id = None
                self._heading_text = None

        super().handle_endtag(tag)


class _RootTreeChainNode(object):
    """Root node for building up a list chain."""

    def __init__(self, level):
        """Initializer.

        Args:
            level (int): Heading level.
        """
        self.level = level
        self.children = []

    def render(self):
        """Render this node.

        Returns:
            str: Rendered HTML.
        """
        padding = ("  " * self.level)
        children_text = ""

        if self.children:
            children_text = "\n".join(
                child.render()
                for child in self.children
            )

        return "{0}<ul>\n{1}\n{0}</ul>\n".format(
            padding,
            children_text
        )


class _EmptyTreeChainNode(object):
    """Empty node for building up a list chain."""

    def __init__(self, parent, level):
        """Initializer.

        Args:
            parent (object): Parent node.
                Can be:
                    * _RootTreeChainNode
                    * _EmptyTreeChainNode
                    * _DataTreeChainNode
            level (int): Heading level.
        """
        self.level = level
        self.parent = parent
        self.children = []
        if parent:
            parent.children.append(self)

    def get_text(self):
        """Get inner text to render under a list level."""
        return ""

    def render(self):
        """Render this node.

        Returns:
            str: Rendered HTML.
        """
        padding = ("  " * self.level)
        children_text = ""

        if self.children:
            children_text = "\n".join(
                child.render()
                for child in self.children
            )
            children_text = (
                    "\n{0}  <ul>\n{1}\n{0}  </ul>\n{0}".format(
                    padding,
                    children_text
                )
            )

        return "{0}<li>{1}{2}</li>".format(
            padding,
            self.get_text(),
            children_text
        )


class _DataTreeChainNode(_EmptyTreeChainNode):
    """Node for building up a list chain."""

    def __init__(self, parent, level, html_id, text):
        """Initializer.

        Args:
            parent (object): Parent node.
                Can be:
                    * _RootTreeChainNode
                    * _EmptyTreeChainNode
                    * _DataTreeChainNode
            level (int): Heading level.
            html_id (str): HTML id
            text (str): Display text.
        """    
        super().__init__(parent, level)
        self.text = "<a href=\"#{0}\">{1}</a>".format(
            html_id,
            text
        )

    def get_text(self):
        """Get inner text to render under a list level."""
        return self.text


class _HtmlTableOfContentsInsert(_BaseHtmlTransformer):
    """Helper parser to insert table of contents."""

    def __init__(self, prepass):
        """Initializer."""
        super().__init__()
        self._prepass = prepass
        self._toc_index = 0

    def handle_startendtag(self, tag, attrs):
        """Handle a startendtag e.g: <div id="main">.

        Args:
            tag (str): HTML tag.
            attrs (list[tuple[str, str]]): Attributes.
        """
        if tag == "table_of_contents":

            # Prepass index will be the same, since
            # it encounters the same table of contents
            # in the same order.
            hierachy = self._prepass[self._toc_index]
            self._toc_index += 1

            self._insert("<div class=\"toc\">\n")

            root_node = _RootTreeChainNode(1)
            current_node = root_node
            
            for entry in hierachy:

                # strip h to get a decent level
                level = int(entry["tag"][1:])

                # Walk up to find a node < in level
                while current_node.level >= level:
                    current_node = current_node.parent

                # Potentially add a bunch of dummies
                # for cases where you have like
                #
                # <h2> Thing </h2>
                # <h4> thing </h4>
                #
                # With no h3 in between
                while current_node.level < (level - 1):
                    current_node = _EmptyTreeChainNode(
                        current_node,
                        current_node.level + 1
                    )

                current_node = _DataTreeChainNode(
                    current_node,
                    level,
                    entry["id"],
                    entry["text"]
                )

            self._insert(root_node.render())
            self._insert("</div>\n")

        else:
            super().handle_startendtag(tag, attrs)

def _get_existing_ids(source):
    """Get a list of used ids.

    Args:
        source (str): Source HTML.

    Returns:
        set[str]: Used ids.
    """
    fetcher = _HtmlFindExistingIds()
    fetcher.feed(source)
    return fetcher.existing_ids


def _insert_missing_heading_ids(source):
    """Insert ids into headers that are missing them.

    Args:
        source (str): Source HTML.

    Returns:
        set[str]: Used ids.
    """
    # Insert ids to heading, so they can be linked.
    insert_missing_ids = _HtmlInsertMissingIds(
        _get_existing_ids(source)
    )
    insert_missing_ids.feed(source)
    return insert_missing_ids.get()


def insert_table_of_contents(source):
    """Insert table of contents.

    This will add a table of contents inside of <table_of_contents />.
    Args:
        source (str): Source HTML, should already have been rendered with
            markdown.

    Returns:
        str: Rendered HTML.
    """
    if "table_of_contents" not in source:
        return source

    # Insert ids to heading, so they can be linked.
    source = _insert_missing_heading_ids(source)

    # Prepass to fetch info and stuff
    prepass = _HtmlTableOfContentsPrepass()
    prepass.feed(source)
    prepass.finish_recording_toc()
    toc_hierachies = prepass.toc_hierachies

    inserter = _HtmlTableOfContentsInsert(toc_hierachies)
    inserter.feed(source)

    return inserter.get()
