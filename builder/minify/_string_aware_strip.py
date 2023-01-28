import re

_BACKTICK_CAPTURE_RE = re.compile(r"\`(?:[^\`\\]|\\.)*\`")
_SINGLE_QUOTES_CAPTURE_RE = re.compile(r"\'(?:[^\'\\]|\\.)*\'")
_DOUBLE_QUOTES_CAPTURE_RE = re.compile(r"\"(?:[^\"\\]|\\.)*\"")
_STRING_RANGES = (
    _BACKTICK_CAPTURE_RE,
    _SINGLE_QUOTES_CAPTURE_RE,
    _DOUBLE_QUOTES_CAPTURE_RE
)


def _string_aware_comment_strip(expr, source):
    """Subsistution routine to strip comments, which will ignore strings.

    Args:
        expr (re.Pattern): Expression to match.
        source (str): Input source.

    Returns:
        str: Stripped source.
    """
    run_another_round = True
    while run_another_round:
        run_another_round = False
        string_ranges = [
            match.span()
            for string_expr in _STRING_RANGES
            for match in string_expr.finditer(source)
        ]

        # Not terribly efficient, could probably use a binary
        # search or something, assuming the spans are always
        # sorted.
        def substitue(match):
            # A previous subsitution may have invalidated
            # subsequent matches, don't replace anything,
            # we're just going to have to start again.
            nonlocal run_another_round

            if run_another_round:
                return match.group(0)

            span = match.span()
            for leave_alone in string_ranges:
                if (span[1] <= leave_alone[0] or leave_alone[1] <= span[0]):
                    continue
                # If the expression is removing comments and a string is
                # within a comment, we are free to remove it but will need to start again.
                # e.g:
                # "I'm" would imply the start of a sting, so would totally break
                # all subsequent matches
                if span[0] < leave_alone[0]:
                    run_another_round = True
                    return ""
                return match.group(0)
            return ""

        source = expr.sub(substitue, source)

    return source


def _string_aware_generic_strip(expr, replacement, source):
    """Generic subsistution routine, which will ignore strings.

    Args:
        expr (re.Pattern): Expression to match.
        replacement (function(re.Match) => str): Replacer function.
        source (str): Input source.

    Returns:
        str: Stripped source.
    """
    string_ranges = [
        match.span()
        for string_expr in _STRING_RANGES
        for match in string_expr.finditer(source)
    ]

    # Not terribly efficient, could probably use a binary
    # search or something, assuming the spans are always
    # sorted.
    def substitue(match):
        span = match.span()
        for leave_alone in string_ranges:
            if (span[1] <= leave_alone[0] or leave_alone[1] <= span[0]):
                continue
            return match.group(0)
        return replacement(match)

    return expr.sub(substitue, source)
