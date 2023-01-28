import os
from glob import iglob
from pathlib import Path


_REPO_ROOT = os.path.abspath(
    os.path.join(
        __file__,
        "..",
        "..",
    )
)

_HEADER_SECTION = None
_FOOTER_SECTION = None


def build_html(template_file, out_file=None):
    """Build a template html file.

    This includes adding footers, headers and rendering custom html elements.

    Args:
        template_file (str or pathlib.Path): Input template file (e.g: _index.html)
        out_file (str or pathlib.Path): Output file, will resolve to the template file
            without a leading underscore if not provided.
            e.g: _index.html => index.html.
            (Default: None)

    Returns:
        bool: If the file was changed.

    Raises:
        ValueError: template_file doesn't start with an underscore, meaning
            auto resolving an out_file isn't possible.
        RuntimeError: template_file and out_file are the same.
    """
    from .html_processing.render_custom_html_tags import (
        render_custom_html_tags
    )
    from .minify.minify_html import minify_html
    from .html_processing.html_merge import (
        extract_html_sections,
        merge_html
    )

    global _HEADER_SECTION
    global _FOOTER_SECTION
    if _HEADER_SECTION is None or _FOOTER_SECTION is None:
        _HEADER_SECTION = extract_html_sections(
            Path(os.path.join(
                _REPO_ROOT, "_templates", "_header.html"
            )).read_text("utf8")
        )
        _FOOTER_SECTION = extract_html_sections(
            Path(os.path.join(
                _REPO_ROOT, "_templates", "_footer.html"
            )).read_text("utf8")
        )

    if isinstance(template_file, str):
        template_file = Path(template_file)
    
    if isinstance(out_file, str):
        out_file = Path(out_file)

    if out_file is None:
        if not template_file.name.startswith("_"):
            raise ValueError(
                "Source file doesn't start with a _ prefix, "
                "cannot autoresolve out filepath {0}".format(
                    template_file.as_posix()
                )
            )
        out_file = template_file.parent / template_file.name[1:]

    if template_file == out_file:
        raise RuntimeError(
            "Error: Attempting to build over the same file! {0}".format(
                template_file.as_posix()
            )
        )

    source = template_file.read_text("utf8")
    source = merge_html(source, _HEADER_SECTION)
    source = merge_html(source, _FOOTER_SECTION, True)
    source = render_custom_html_tags(
        source,
        source_file=template_file.as_posix()
    )

    if out_file.is_file():
        if out_file.read_text("utf8") == source:
            return False

    out_file.write_text(source, "utf8")
    return True


def build_project_html_files(path_filter=None):
    """Build template html files within the _source folder.

    This will only target files which start with an underscore
    and are html files.
    e.g:
        _source/thing/_index.html

    Args:
        path_filter (str): Glob filter, to target specific files.
            e.g: "**bluenoise/**" (Default: None)

    Returns:
        list[Path]: HTML files that were built.
    """
    source_dir = os.path.join(_REPO_ROOT, "_source")
    thirdparty_dir = os.path.join(source_dir, "thirdparty")

    if not path_filter:
        path_filter = "_*.html"

    source_files = (
        Path(source_file)
        for source_file in set(iglob(
            os.path.join(source_dir, "**", path_filter),
            recursive=True
        ))
        if (
            os.path.isfile(source_file)
            and not source_file.startswith(thirdparty_dir)
        )
    )

    # Only keep _*.html files
    source_files = [
        source_file
        for source_file in source_files
        if source_file.name.startswith("_") and source_file.suffix == ".html"
    ]

    # Process child sources first, the reason for this is because
    # it means /posts/_index.html and /_index.html will be evaluated
    # after all children have.
    source_files.sort(key=lambda x: len(str(x)), reverse=True)

    for source_file in source_files:
        build_html(source_file)

    return source_files
