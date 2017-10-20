#include "slick.sh"

// Based on aligncustom.e from here:
// https://community.slickedit.com/index.php/topic,15632.msg59735.html#msg59735

static int max_col;
static _str alignStr;

static _str find_max_eq_filter(s)
{
    int first_char = pos("[^[:blank:]]", s, 1, "R");
    if (first_char == 0) {
        return s
    }

    next_space = pos("[[:blank:]]", s, first_char, "R")
    if (next_space > max_col) {
        max_col = next_space;
    }

    return s;
}

static _str align_eq_filter(s)
{
    if (max_col == 0 || length(s) == 0) {
        return s;
    }

    int first_char = pos("[^[:blank:]]", s, 1, "R");
    if (first_char == 0) {
        return s;
    }

    next_space = pos("[[:blank:]]", s, first_char, "R")
    _str prefix = substr(s, 1, next_space - 1);
    _str postfix = substr(s, next_space);

    while (next_space < max_col) {
        prefix = prefix :+ ' ';
        next_space++;
    }

    return prefix :+ postfix;
}

static void do_align()
{
    max_col = 0;
    filter_selection(find_max_eq_filter);

    if (max_col == 0) {
        return;
    }

    filter_selection(align_eq_filter);
    _free_selection("");
}

_command void align() name_info(','VSARG2_MARK|VSARG2_REQUIRES_EDITORCTL)
{
    if (_select_type() == "" || _select_type() != "CHAR") {
        message("A line selection is required for this function");
        return;
    }

    do_align();
}
