import html
import html.parser
import re

from .minify_css import minify_css
from .minify_js import minify_js


_NO_STRIP_TAGS = {
    "pre",
    "code",
    "textarea"
}

_ATTR_CHARS_THAT_NEED_QUOTES = (
    "'",
    '"',
    "`",
    "=",
    "<",
    ">",
    " ",
    "\n",
    "\t"
)

_WHITESPACE_STRIP = re.compile(r"\s+")


class _HtmlMinifierParser(html.parser.HTMLParser):
    """Helper parser to perform minifaction."""

    def __init__(
            self,
            css_allow_toptol,
            js_allow_toptol,
            js_has_consistent_semicolons):
        """Initializer.

        Args:
            css_allow_toptol (bool): Allow the use of www.toptol.com to
                minify inline CSS.
            js_allow_toptol (bool): Allow the use of www.toptol.com to
                minify inline Javascript.
            js_has_consistent_semicolons (bool): If the inline Javascript
                has consistent semicolons.
        """
        super().__init__(convert_charrefs=False)
        self._no_strip_depth = 0
        self._in_js_tag = False
        self._in_css_tag = False
        self._keep_comments = False
        self._parsed_data = []
        self._css_allow_toptol = css_allow_toptol
        self._js_allow_toptol = js_allow_toptol
        self._js_has_consistent_semicolons = js_has_consistent_semicolons
        self._in_body = False

    def get(self):
        """Get the parsed and minified result.

        Returns:
            str: Minified HTML.
        """
        return "".join(self._parsed_data)

    def _insert(self, data):
        """Insert parsed data into the buffer.

        The contents may be automatically stripped dependings on
        what tags wrap around it.

        Args:
            data (str): Data to enqueue.
        """
        if self._no_strip_depth <= 0:
            if self._in_body:
                data = _WHITESPACE_STRIP.sub(" ", data)
            else:
                data = data.strip()

        if data:
            self._parsed_data.append(data)

    def handle_comment(self, comment):
        """Handle a comment e.g <!-- blah -->.

        Args:
            comment (str): Comment.
        """
        comment_stripped = comment.strip()

        if comment_stripped.startswith("!minify-html:"):
            command = comment_stripped[len("!minify-html:"):].lstrip()
            if command == "minify-off":
                self._no_strip_depth += 1
            elif command == "minify-on":
                self._no_strip_depth -= 1
            elif command == "keep-comments-on":
                self._keep_comments = True
            elif command == "keep-comments-off":
                self._keep_comments = False

        elif self._keep_comments:
            self._insert("<!--{0}-->".format(comment))

    def handle_data(self, data):
        """Handle data between tags (contents of script etc).

        Args:
            data (str): Inner data.
        """
        if self._in_js_tag:
            data = minify_js(
                data,
                self._js_allow_toptol,
                self._js_has_consistent_semicolons
            )

        elif self._in_css_tag:
            data = minify_css(data, self._css_allow_toptol)

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
        """Handle HTML charref declaration e.g: &thing;.

        Args:
            data (str): charref.
        """
        self._insert("&{0};".format(data))

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

    def _minify_start_tag(self, tag, attrs, is_end):
        """Minify a start tag definition.

        This includes removing quotes if possible and minifying css.

        Args:
            tag (str): Target HTML tag.
            attrs (list[tuple[str, str]]): Attributes.
            is_end (bool): If it's a startend tag.

        Returns:
            str: Minified start tag.
        """
        result = "<{0}".format(tag)

        for key, value in attrs:
            if key == "style":
                value = minify_css(value, self._css_allow_toptol)

            # Empty values don't require key=value and can be totally ommited
            if not value:
                result = "{0} {1}".format(result, key)
                continue

            value = html.escape(value, False)

            # Don't need to wrap quotes if there aren't any
            # of the reserved characters.
            if not any(c in value for c in _ATTR_CHARS_THAT_NEED_QUOTES):
                result = "{0} {1}={2}".format(result, key, value)

            # We can flip between both type of quotes if
            # there is only one type
            elif '"' not in value:
                result = "{0} {1}=\"{2}\"".format(result, key, value)

            elif "'" not in value:
                result = "{0} {1}='{2}'".format(result, key, value)

            # Value has BOTH kinds of quotes in it!
            # Pick which ever quote is less frequent
            else:
                num_single = value.count("'")
                num_double = value.count('"')
                if num_single >= num_double:
                    value = value.replace('"', "&quot;")
                    result = "{0} {1}=\"{2}\"".format(result, key, value)
                else:
                    value = value.replace("'", "&#x27;")
                    result = "{0} {1}='{2}'".format(result, key, value)

        if is_end:
            result = "{0}\\>".format(result)
        else:
            result = "{0}>".format(result)

        return result

    def handle_startendtag(self, tag, attrs):
        """Handle a startendtag e.g: <div id="main">.

        Args:
            tag (str): HTML tag.
            attrs (list[tuple[str, str]]): Attributes.
        """
        self._insert(self._minify_start_tag(
            tag,
            attrs,
            False
        ))

    def handle_starttag(self, tag, attrs):
        """Handle the start of a tag e.g: <div id="main">.

        Args:
            tag (str): HTML tag.
            attrs (list[tuple[str, str]]): Attributes.
        """
        if tag in _NO_STRIP_TAGS:
            self._no_strip_depth += 1

        elif tag == "script":
            script_type = next(
                (value for key, value in attrs if key == "type"),
                None
            )
            # Should probably pop the type attribute if it's
            # "text/javascript", since it's not needed.
            if script_type in ("text/javascript", "module", None):
                self._in_js_tag = True

        elif tag == "style":
            self._in_css_tag = True

        elif tag == "body":
            self._in_body = True

        self._insert(self._minify_start_tag(
            tag,
            attrs,
            False
        ))

    def handle_endtag(self, tag):
        """Handle the end of a tag e.g: </div>.

        Args:
            tag (str): HTML tag.
        """
        if tag in _NO_STRIP_TAGS:
            self._no_strip_depth -= 1

        elif tag == "script":
            self._in_js_tag = False

        elif tag == "style":
            self._in_css_tag = False

        elif tag == "body":
            self._in_body = False

        self._insert("</{0}>".format(tag))


def minify_html(
        source,
        css_allow_toptol=False,
        js_allow_toptol=True,
        js_has_consistent_semicolons=True):
    """Minify html source code.

    Args:
        source (str): Source HTML.
        css_allow_toptol (bool): Allow the use of www.toptol.com to
            minify inline CSS.(Default: False)
        js_allow_toptol (bool): Allow the use of www.toptol.com to
            minify inline Javascript.(Default: True)
        js_has_consistent_semicolons (bool): If the inline Javascript
            has consistent semicolons. (Default: True)

    Returns:
        str: Minified HTML.
    """
    minifier = _HtmlMinifierParser(
        css_allow_toptol,
        js_allow_toptol,
        js_has_consistent_semicolons
    )
    minifier.feed(source)
    return minifier.get()
