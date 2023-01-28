import argparse
import os
import sys
from pathlib import Path


_REPO_ROOT = os.path.abspath(
    os.path.join(
        __file__,
        "..",
    )
)

sys.path.insert(0, _REPO_ROOT)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-b", "--build",
        help="Build template (_index.html) file(s) in _source.",
        action="store_true"
    )
    parser.add_argument(
        "-i", "--install",
        help="Install files from _source into _build.",
        action="store_true"
    )
    parser.add_argument(
        "-v", "--verbose",
        help="Enable verbosity.",
        action="store_true"
    )
    parser.add_argument(
        "-s", "--rebuild-sitemap",
        help="Regenerate the sitemap. (on by default with --install).",
        type=int,
        default=-1
    )
    parser.add_argument(
        "-f", "--filter",
        help=(
            "Apply a glob filter with --build and --install."
            " (e.g **bluenoise/**)"
        ),
        default=""
    )
    
    args = parser.parse_args()

    did_anything = False

    if args.build:
        from builder.build import build_project_html_files
        print("\nBuilding:")
        for path in build_project_html_files(args.filter):
            print(path)
        did_anything = True

    if args.install:
        from builder.install import install_project_files
        print("\nInstalling:")
        result = sorted(
            install_project_files(args.filter).items(),
            key=lambda x:(x[0].count("/"), x[0])
        )
        if args.verbose and result:
            ljust = max(len(path) for path, _ in result)
            for path, installed in result:
                print(path.ljust(ljust, "."), installed)
        else:
            for path, installed in result:
                if installed:
                    print(path)
        did_anything = True

    rebuild_sitemap = args.install
    if args.rebuild_sitemap >= 0:
        rebuild_sitemap = args.rebuild_sitemap != 0

    if rebuild_sitemap:
        from builder.sitemap import update_sitemap
        print("\nUpdating Sitemap")
        update_sitemap()
        did_anything = True

    if not did_anything:
        parser.print_help()
