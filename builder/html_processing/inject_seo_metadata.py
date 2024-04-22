import os
import json
from pathlib import Path
from datetime import datetime

from .extract_metadata import extract_metadata
from .html_merge import HtmlSections, merge_html


_WEBSITE_ROOT = "https://alister-chowdhury.github.io"

_REPO_ROOT = os.path.abspath(
    os.path.join(
        __file__,
        "..",
        "..",
        "..",
    )
)
_SOURCE_ROOT = os.path.join(_REPO_ROOT, "_source")


def inject_seo_metadata(source, source_file):
    """Inject metatags based upon the existing keywords and tags.

    Args:
        source (str): Source HTML.
        source_file (str or pathlib.Path): Path this corresponds too.

    Returns:
        str: Rendered HTML.
    """
    if isinstance(source_file, str):
        source_file = Path(source_file)

    target = source_file

    thumbnail_file_path = target.parent / "thumbnail.png"
    if thumbnail_file_path.exists():
        thumbnail_url = "{0}/{1}".format(
            _WEBSITE_ROOT,
            thumbnail_file_path.relative_to(_SOURCE_ROOT).as_posix()
        )
    else:
        thumbnail_url = "{0}/res/favicon.png".format(
            _WEBSITE_ROOT
        )

    # Sanatise the name etc
    add_url_slash = False
    if target.name in ("_index.html", "index.html"):
        target = target.parent
        add_url_slash = True

    url = target.relative_to(_SOURCE_ROOT).as_posix()
    if add_url_slash and not url.endswith("/"):
        url = "{0}/".format(url)

    if url in (".", "./", ".\\"):
        url = ""

    content_type = "website"
    
    is_post = url.startswith("posts/") and (len(url) > len("posts/"))
    if is_post:
        content_type = "article"



    # Standard gubbins
    title, metatags = extract_metadata(source)
    full_url = "{0}/{1}".format(_WEBSITE_ROOT, url)

    head_to_inject = """
    <link rel="canonical" href="{url}">
    <meta property="og:title" content="{title}">
    <meta property="og:url" content="{url}">
    <meta property="og:type" content="{content_type}">\n""".format(
        title=title,
        url=full_url,
        content_type=content_type
    )

    # Duplicate meta description
    if "description" in metatags:
        head_to_inject += (
            '    <meta property="og:description" content="{0}">\n'.format(
                metatags["description"]
            )
        )

    head_to_inject += (
        '    <meta property="og:image" content="{0}">\n'
        .format(thumbnail_url)
    )

    # Add tags and publish time to posts
    if is_post:

        schema = {
            "@context": "http://schema.org",
            "@type": "Article",
            "author": [{"@type": "Person", "name": "By Alister Chowdhury"}],
            "name": title,
            "url": full_url,
        }

        if "description" in metatags:
            schema["description"] = metatags["description"]

        schema["thumbnailUrl"] = thumbnail_url

        # Extract the posttime from the url itself
        article_url = url[len("posts/"):]
        url_split = article_url.split("-", 1)
        if url_split and url_split[0].isdigit():
            timestamp = url_split[0]
            post_date = datetime.strptime(timestamp, "%Y%m%d").isoformat()
            publish_tag = (
                '    <meta property="og:article:published_time"'
                ' content="{0}">\n'
                .format(post_date)
            )
            schema["datePublished"] = post_date

            head_to_inject += publish_tag

        for tag in metatags.get("keywords", "").split(","):
            article_tag = (
                '    <meta property="og:article:tag" content="{0}">\n'.format(
                    tag.strip()
                )
            )
            head_to_inject += article_tag

        head_to_inject += (
            '<script data-rh="true" type="application/ld+json">'
            '{0}'
            '</script>\n'
        ).format(
            json.dumps(schema, separators=(",", ":"))
        )

    section_to_merge = HtmlSections(head=head_to_inject)
    return merge_html(source, section_to_merge)
