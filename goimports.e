#include "slick.sh"

_command void goimports() name_info(',')
{
    save()
    cmd = "goimports -w " :+ p_buf_name
    shell(cmd, "Q")
    revert_or_refresh();
}
