import html

from ._transformer_base import _BaseHtmlTransformer


def _rebuild_start_tag(tag, attrs):
    result = "<{}".format(tag)
    for key, value in attrs:
        if value is None:
            result += " {}".format(key)
        else:
            escaped = html.escape(value, quote=False).replace('"', "&quot;")
            result += ' {}="{}"'.format(key, escaped)
    result += ">"
    return result


class _ExternalLinkFixer(_BaseHtmlTransformer):

    def _fix_anchor(self, tag, attrs):
        if tag != "a":
            return None
        target = next((v for k, v in attrs if k == "target"), None)
        if target != "_blank":
            return None
        new_attrs = []
        has_rel = False
        for k, v in attrs:
            if k == "rel":
                rel_parts = set(v.split()) if v else set()
                rel_parts |= {"noopener", "noreferrer"}
                new_attrs.append(("rel", " ".join(sorted(rel_parts))))
                has_rel = True
            else:
                new_attrs.append((k, v))
        if not has_rel:
            new_attrs.append(("rel", "noopener noreferrer"))
        return _rebuild_start_tag(tag, new_attrs)

    def handle_starttag(self, tag, attrs):
        fixed = self._fix_anchor(tag, attrs)
        self._insert(fixed if fixed is not None else self.get_starttag_text())

    def handle_startendtag(self, tag, attrs):
        fixed = self._fix_anchor(tag, attrs)
        self._insert(fixed if fixed is not None else self.get_starttag_text())


def fix_external_links(source):
    """Add rel="noopener noreferrer" to all <a target="_blank"> tags.

    Args:
        source (str): Source HTML.

    Returns:
        str: HTML with fixed external links.
    """
    fixer = _ExternalLinkFixer()
    fixer.feed(source)
    return fixer.get()
