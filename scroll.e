#include "slick.sh"

_command void scroll_move_up() name_info(',')
{
   scroll_line_up();
   cursor_up(1);
}

_command void scroll_move_down() name_info(',')
{
   scroll_line_down();
   cursor_down(1);
}
