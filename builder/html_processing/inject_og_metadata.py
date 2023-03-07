import os
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


def inject_og_metadata(source, source_file):
    """Inject 'og:xxx' metatags based upon the existing keywords and tags.

    Args:
        source (str): Source HTML.
        source_file (str or pathlib.Path): Path this corresponds too.

    Returns:
        str: Rendered HTML.
    """
    if isinstance(source_file, str):
        source_file = Path(source_file)

    target = source_file

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
    head_to_inject = """
    <meta property="og:title" content="{title}">
    <meta property="og:url" content="{url}">
    <meta property="og:type" content="{content_type}">\n""".format(
        title=title,
        url="{0}/{1}".format(_WEBSITE_ROOT, url),
        content_type=content_type
    )

    # Duplicate meta description
    if "description" in metatags:
        head_to_inject += (
            '    <meta property="og:description" content="{0}">\n'.format(
                metatags["description"]
            )
        )

    # Add tags and publish time to posts
    if is_post:

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
            head_to_inject += publish_tag

        for tag in metatags.get("keywords", "").split(","):
            article_tag = (
                '    <meta property="og:article:tag" content="{0}">\n'.format(
                    tag.strip()
                )
            )
            head_to_inject += article_tag

    section_to_merge = HtmlSections(head=head_to_inject)
    return merge_html(source, section_to_merge)
