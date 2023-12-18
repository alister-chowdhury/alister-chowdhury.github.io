import os
import json
from glob import iglob
from pathlib import Path

from ._cache import _fhash


def install_file(source_file, dest_file, settings):
    """Install a single file, which includes minifying css/html/js if allowed.

    Args:
        source_file (str or pathlib.Path): Source file.
        dest_file (str or pathlib.Path): Dest file.
        settings (tuple(str, str) or dict): Settings.

    Returns:
        bool: If the file was changed.
    """
    if source_file == dest_file:
        raise RuntimeError(
            "Error: Attempting to copy over the same file! {0}".format(
                source_file
            )
        )

    if isinstance(source_file, str):
        source_file = Path(source_file)

    if isinstance(dest_file, str):
        dest_file = Path(dest_file)

    if not isinstance(settings, dict):
        settings = dict(settings)

    existing_hash = (
        _fhash(dest_file.read_bytes())
        if dest_file.is_file()
        else None
    )

    dest_file.parent.mkdir(parents=True, exist_ok=True)

    copied = False

    if settings.get("minify", True):
        ext = source_file.suffix.lower()
        if ext == ".css":
            from .minify.minify_css import minify_css
            data = minify_css(
                source_file.read_text("utf8"),
                allow_toptol = settings.get("allow_toptol", False)
            )
            dest_file.write_text(data, "utf8")
            copied = True

        elif ext == ".html":
            from .minify.minify_html import minify_html
            data = minify_html(
                source_file.read_text("utf8"),
                css_allow_toptol = settings.get("css_allow_toptol", False),
                js_allow_toptol = settings.get("js_allow_toptol", True),
                js_has_consistent_semicolons = settings.get(
                    "js_has_consistent_semicolons", True
                )
            )
            dest_file.write_text(data, "utf8")
            copied = True

        elif ext == ".js":
            from .minify.minify_js import minify_js
            data = minify_js(
                source_file.read_text("utf8"),
                allow_toptol = settings.get("allow_toptol", True),
                has_consistent_semicolons = settings.get(
                    "has_consistent_semicolons",
                    True
                )
            )
            dest_file.write_text(data, "utf8")
            copied = True

        elif ext in (".vert", ".frag", ".glsl"):
            from .minify.minify_glsl import minify_glsl
            data = minify_glsl(source_file.read_text("utf8"))
            dest_file.write_text(data, "utf8")
            copied = True

        elif ext in (".wgsl",):
            from .minify.minify_wgsl import minify_wgsl
            data = minify_wgsl(source_file.read_text("utf8"))
            dest_file.write_text(data, "utf8")
            copied = True

    if copied:
        return _fhash(dest_file.read_bytes()) != existing_hash

    data = source_file.read_bytes()
    if _fhash(data) == existing_hash:
        return False
    dest_file.write_bytes(data)
    return True


def _install_file_dispatch(arg):
    """Multithreading dispatcher for install file.

    Args:
        arg (tuple): Arguments to pass to install_file.

    Returns:
        bool: If the file was copied.
    """
    return install_file(*arg)


def install_files(source_dir, dest_dir, pattern, settings, thread_copy=True):
    """Install a single file, which includes minifying css/html/js if allowed.

    Args:
        source_dir (str): Source directory.
        dest_dir (str): Dest directory.
        pattern (str): Glob pattern to use.
        settings (dict): Settings.
        thread_copy(bool): Whether or not to use multiple threads.
            (Default: True)

    Returns:
        dict[str, bool]: List of relative files and if they were copied.
    """
    if source_dir == dest_dir:
        raise RuntimeError(
            "Error: Attempting to copy over the same file! {0}".format(
                source_dir
            )
        )

    source_files = [
        source_file
        for source_file in iglob(
            os.path.join(source_dir, pattern),
            recursive=True
        )
        if os.path.isfile(source_file)
    ]

    rel_files = [
        os.path.relpath(source_file, source_dir)
        for source_file in source_files
    ]

    dest_files = [
        os.path.join(dest_dir, rel)
        for rel in rel_files
    ]

    result = {}

    if thread_copy:
        settings = tuple(settings.items())
        from multiprocessing import Pool, cpu_count
        with Pool(cpu_count()) as thread_pool:
            copied = thread_pool.map(
                _install_file_dispatch,
                ((src, dst, settings) for src, dst in zip(
                    source_files,
                    dest_files
                ))
            )
            for rel, flag in zip(rel_files, copied):
                result[rel] = flag
    else:
        for src, dst, rel in zip(source_files, dest_files, rel_files):
            result[rel] = install_file(src, dst, settings)
    return result


def install_project_files(path_filter=None, thread_copy=False):
    """Install files within the _source folder, using _install.json as
    an anchor point.

    Args:
        path_filter (str): Glob filter, to target specific files.
            e.g: "*bluenoise*/**" (Default: None)
        thread_copy(bool): Whether or not to use multiple threads.
            (Default: False)

    Returns:
        dict[str, bool]: List of relative files and if they were copied.
    """
    repo_root = os.path.abspath(
        os.path.join(
            __file__,
            "..",
            "..",
        )
    )
    source_dir = os.path.join(repo_root, "_source")
    build_dir = os.path.join(repo_root, "_build")

    if not path_filter:
        path_filter = "_install.json"

    anchor_files = (
        Path(anchor_file)
        for anchor_file in iglob(
            os.path.join(source_dir, "**", path_filter),
            recursive=True
        )
    )

    # Only keep _install.json files
    anchor_files = [
        anchor_file
        for anchor_file in anchor_files
        if anchor_file.name == "_install.json"
    ]

    source_root = Path(source_dir)
    build_root = Path(build_dir)

    updates = {}

    for anchor in anchor_files:
        src_dir = anchor.parent
        rel_path = src_dir.relative_to(source_root)
        dst_dir = build_root / rel_path
        for rule, settings in json.loads(anchor.read_text("utf8")).items():
            installed = install_files(
                src_dir,
                dst_dir,
                rule,
                settings,
                thread_copy=thread_copy
            )
            for path, copied in installed.items():
                updates[(rel_path / path).as_posix()] = copied

    return updates
