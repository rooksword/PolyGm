/// @desc Initialize

gpu_set_texrepeat(true);

enum EDITOR_STATES
{
	IDLE,
	CREATE
}

state = EDITOR_STATES.IDLE;

shape_selected = -1;

mouse_xprevious = mouse_x;
mouse_yprevious = mouse_y;

auto_draw = 64; // 64