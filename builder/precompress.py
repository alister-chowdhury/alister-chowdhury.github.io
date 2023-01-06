from pathlib import Path

import gzip


# NB: Not using this, as it seems github pages doesn't
# really vibe precompression.

def precompress_asset(filepath):
    """Precompress an asset with a gzip variant.

    Args:
        filepath (str or pathlib.Path): Path to compress.
    """
    if isinstance(filepath, str):
        filepath = Path(filepath)

    data = filepath.read_bytes()
    compressed = gzip.compress(data, 9)

    # Don't bother writing a compressed version if
    # there's no real saving
    if len(compress)/len(data) < 0.9:
        gzip_file = filepath.with_suffix(
            "{0}.gz".format(filepath.suffix)
        )
        gzip_file.write_bytes(compressed)
