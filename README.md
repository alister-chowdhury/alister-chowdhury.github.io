# alister-chowdhury.github.io

Repo that builds: `alister-chowdhury.github.io`.

Uses a custom static site generator (which lives under `builder`).

## Dependencies
* python (Been using 3.13.1)
* * mako (Been using 1.3.10)
* * mistune (Been using 3.2.0)
* * xxhash (Optional)
* nodejs (Been using 24.12.0, optional, Latex won't be prerendered without it)
* LLVM (Been using 21.1.8), optional to compile C/C++
* VulkanSDK (Been using 1.4.328.1), optional to compile to WebGPU and WGSL
* tint, optional to compile to WGSL (needs SPIRV reader and WGSL writer options enabled).
* naga, optional to compile to WSGL (been using 28.0.0).


## Layout
* `_source` is basically the working area.
* `_build` is where the final built site lives.
* `_template` is where the header and footer that gets injected live.
* `builder` is the python library that manages all the building / installing / updating.

Posts live under `_source/posts/YYYYMMDD-name` and should have their own `_index.html` which will be compiled when building.

There are `_install.json` files sprinkled about, these are basically descriptors for what to copy from `_source` to `_build` and whether or not to minify things during the copying process.


## Building

```
python build.py --help
----------------------
usage: build.py [-h] [-b] [-i] [-v] [-s REBUILD_SITEMAP] [-f FILTER]

optional arguments:
  -h, --help            show this help message and exit
  -b, --build           Build template (_index.html) file(s) in _source.
  -i, --install         Install files from _source into _build.
  -v, --verbose         Enable verbosity.
  -s REBUILD_SITEMAP, --rebuild-sitemap REBUILD_SITEMAP
                        Regenerate the sitemap. (on by default with --install).
  -f FILTER, --filter FILTER
                        Apply a glob filter with --build and --install. (e.g **bluenoise/**)
```

General workflow is:
```
python build -b "**newthing/**"
```

Until everything is looking legit, then when it comes to releasing.

```
python build -bi
```
You want to ensure the `posts/index.html` gets updated, hence the blanket rebuild.


## Deploying

The site is live on the `gh-pages` branch and uses `git worktree` to map it to `_build`.
Updating should basically be:

```
cd _build
git add --all
git commit -m "Deploy on gh-pages updated"
git push origin gh-pages
```

Reference: https://stackoverflow.com/a/75129084

