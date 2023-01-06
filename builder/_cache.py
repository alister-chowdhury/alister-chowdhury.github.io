import os
import zlib

try:
    from xxhash import xxh128_hexdigest
    _fhash = xxh128_hexdigest

except ImportError:
    def _fhash(data):
        """Backup fast hash used when xxh128 is unavailable.

        Args:
            data (bytes): Data to hash.

        Returns:
            str: Hex digest
        """
        h0 = hash(data) & 0xffffffffffffffff
        h1 = zlib.adler32(data)
        return "{0:08x}{0:016x}".format(h0, h1)


def _get_cache_path(cache_dir, source):
    """Get a hash to use when inserting into the cache.

    Args:
        cache_dir (str): Cache directory.
        source (str): Source.

    Returns:
        str: Cache filepath.
    """
    if not isinstance(source, bytes):
        source = source.encode("utf8")
    key = _fhash(source)
    return os.path.join(cache_dir, key)


def _test_cache(cache_dir, source, as_bytes=False):
    """Test if source has been cached.

    Args:
        cache_dir (str): Cache directory.
        source (str): Source.
        as_bytes (bool): Return back the result as bytes. (Default: False)

    Returns:
        tuple(bool, str): Found, minified.
    """
    cache_path = _get_cache_path(cache_dir, source)
    if os.path.isfile(cache_path):
        try:
            with open(cache_path, "rb") as in_fp:
                result = zlib.decompress(in_fp.read())
                if not as_bytes:
                    result = result.decode("utf8")
                return True, result
        except Exception:
            try:
                os.unlink(cache_path)
            except Exception:
                pass
    return False, ""


def _insert_cache(cache_dir, source, minified):
    """Insert source code into a cache.

    Args:
        cache_dir (str): Cache directory.
        source (str):  Source.
        minified (str): Minified source.
    """
    if not isinstance(source, bytes):
        source = source.encode("utf8")
    if not isinstance(minified, bytes):
        minified = minified.encode("utf8")
    cache_path = _get_cache_path(cache_dir, source)
    try:
        if not os.path.isdir(cache_dir):
            os.makedirs(cache_dir)
        with open(cache_path, "wb") as in_fp:
            in_fp.write(zlib.compress(minified))
    except Exception:
        try:
            os.unlink(cache_path)
        except Exception:
            pass
