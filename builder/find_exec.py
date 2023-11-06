import shutil
import os


def find_executable(exec_name, env_override=None):
    """Find an executables path.

    Args:
        exec_name (str): Exec name.
        env_override (str): Envvar to override (Default: None).

    Returns:
        str or None: Path to the executable or None if not found
    """
    found = None
    which_path = None
    if env_override:
        found_env = os.getenv(env_override)
        if found_env:
            if os.path.isfile(found_env):
                found = found_env
            else:
                which_path = found_env

    if not found:
        found = shutil.which(exec_name, path=which_path)

    if found:
        found = os.path.abspath(found)

    return found
