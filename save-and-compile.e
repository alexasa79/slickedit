#include "slick.sh"
_command save_and_compile() name_info(','VSARG2_MACRO|VSARG2_MARK|VSARG2_REQUIRES_MDI_EDITORCTL)
{
    project_compile();
    toggle_build();
}
