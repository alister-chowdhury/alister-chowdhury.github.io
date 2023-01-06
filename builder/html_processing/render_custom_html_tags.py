

def render_custom_html_tags(source, source_file):
    """This 'renders' custom html tags (such as <markdown>, <latex>).

    Args:
        source (str): HTML source.
        source_file (str): Filepath this html data represents.

    Returns:
        str: Rendered HTML.
    """
    from ._inline_mako_render import inline_mako_render
    from ._inline_markdown_render import inline_markdown_render
    from ._inline_latex_render import inline_latex_render
    from ._insert_syntax_highlighting import insert_syntax_highlighting
    source = inline_mako_render(source, source_file=source_file)
    source = inline_markdown_render(source)
    source = inline_latex_render(source)
    source = insert_syntax_highlighting(source)
    return source
