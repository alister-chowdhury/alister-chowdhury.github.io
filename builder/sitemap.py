from datetime import datetime
from glob import iglob
from pathlib import Path
from xml.etree import ElementTree
import hashlib
import json
import os


WEBSITE_ROOT = "https://alister-chowdhury.github.io"
_REPO_ROOT = os.path.abspath(
    os.path.join(
        __file__,
        "..",
        "..",
    )
)

_BUILD_ROOT = os.path.join(_REPO_ROOT, "_build")
_SITEMAP_XML = os.path.join(_BUILD_ROOT, "sitemap.xml")
_SITEMAP_MAP = os.path.join(_REPO_ROOT, "sitemap.json")


def _apply_indent(elem, level=0):
    """Apply indentation to an XML tree.

    Originally from: Based upon: https://stackoverflow.com/a/33956544

    Args:
        elem (Element): Node to apply indentation too.
        level (int): Current node depth (Default: 0)
    """
    i = "\n" + level*" "
    if len(elem):
        if not elem.text or not elem.text.strip():
            elem.text = i + " "
        if not elem.tail or not elem.tail.strip():
            elem.tail = i
        for child in elem:
            _apply_indent(child, level+1)
        if not child.tail or not child.tail.strip():
            child.tail = i
    else:
        if level and (not elem.tail or not elem.tail.strip()):
            elem.tail = i


def _build_sitemap(html_file_maps):
    """Build a sitemap xml.

    Args:
        html_file_maps (list[dict]): Mapping of HTML files.
            must contain the following keys:
                * loc
                * lastmod

    Returns:
        str: Generated XML
    """
    root = ElementTree.Element("urlset")
    root.set("xmlns", "http://www.sitemaps.org/schemas/sitemap/0.9")
    for url in html_file_maps:
        url_node = ElementTree.SubElement(root, "url")
        location = url["loc"]
        if location.endswith("index.html"):
            location = location[:-len("index.html")]
        location = location.strip("/")
        ElementTree.SubElement(url_node, "loc").text = "/".join((
            WEBSITE_ROOT,
            location
        )).rstrip("/")
        ElementTree.SubElement(url_node, "lastmod").text = url["lastmod"]
    _apply_indent(root)
    return ElementTree.tostring(
        root,
        encoding="utf8",
        method="xml",
    ).decode("utf8")


def update_sitemap():
    """Build a sitemap xml."""
    html_files = (
        Path(source_file)
        for source_file in iglob(
            os.path.join(_BUILD_ROOT, "**", "*.html"),
            recursive=True
        )
    )

    current_mapping = {}
    sitemap_map = Path(_SITEMAP_MAP)

    def filter_entry(entry):
        """Helper function to filter out invalid entries.

        Args:
            entry (dict): Sitemap map entry.

        Returns:
            bool: If the entry should be kept.
        """
        return (
            all(key in entry for key in ("hash", "loc", "lastmod"))
            and os.path.isfile(os.path.join(_BUILD_ROOT, entry["loc"]))
        )

    if sitemap_map.is_file():
        loaded_entries = json.loads(
            sitemap_map.read_text("utf8")
        ).get("data", [])
        
        current_mapping = {
            entry["loc"]: entry
            for entry in loaded_entries
            if filter_entry(entry)
        }

    now_timestamp = datetime.today().strftime("%Y-%m-%d")

    mapping = []
    for html_file in html_files:
        file_hash = hashlib.md5(html_file.read_bytes()).hexdigest()
        rel_path = html_file.relative_to(_BUILD_ROOT).as_posix()
        existing = current_mapping.get(rel_path)
        if existing and existing["hash"] == file_hash:
            mapping.append(existing)
        else:
            mapping.append({
                "lastmod": now_timestamp,
                "loc": rel_path,
                "hash": file_hash,
            })

    mapping.sort(key = lambda x: x["loc"])

    sitemap_map.write_text(
        json.dumps(
            {"data": mapping},
            indent=1
        ),
        "utf8"
    )

    Path(_SITEMAP_XML).write_text(
        _build_sitemap(mapping),
        "utf8"
    )
