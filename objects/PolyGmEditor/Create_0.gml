/// @desc Initialize

gpu_set_texrepeat(true);

enum EDITOR_STATES
{
	EDIT,
	DRAW
}

state = EDITOR_STATES.EDIT;

auto_draw = 64;

shape_selected = -1;
hover_on_button = false;

mouse_xprevious = mouse_x;
mouse_yprevious = mouse_y;