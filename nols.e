#include "slick.sh"

#pragma option(strictsemicolons,on)
#pragma option(strict,on)
#pragma option(autodecl,off)
#pragma option(strictparens,on)

_command void find_symbol_in_current_file() name_info(',')
{
   _control ctl_lookin;
   _control ctl_substring;
   int wid = activate_tool_window('_tbfind_symbol_form', true, 'ctl_search_for');
   wid.ctl_lookin.p_text = '<Current File>';
   wid.ctl_substring.p_value = 1;
}

_command void find_symbol_in_current_project() name_info(',')
{
   _control ctl_lookin;
   _control ctl_substring;
   int wid = activate_tool_window('_tbfind_symbol_form', true, 'ctl_search_for');
   wid.ctl_lookin.p_text = '<Current Project>';
   wid.ctl_substring.p_value = 0;
}

