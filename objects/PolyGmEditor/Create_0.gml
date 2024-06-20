/// @desc Initialize

window_set_cursor(cr_none); // Remove default windows cursor
						    
gpu_set_texrepeat(true);    // Set all textures to repeat infinitely
				
//show_debug_overlay(true);

texturegroup_unload("texgroup1");

enum EDITOR_STATES          // States control what buttons and actions are available
{						    
	EDIT_POLY,			    
	DRAW_POLY,
	SELECT,
	EDIT_SELECT,
	BEZIER,
	EDIT_OBJECT,
	DRAW_OBJECT
}
						    
state = EDITOR_STATES.EDIT_POLY; // Set the default state to 'edit'
						    
shape_selected = -1;        // Holds a reference to the currently selected shape
hover_on_button = false;    // Is the mouse hovering over a button?
						    
mouse_xc = mouse_x;         // Current mouse_x (can be snapped)
mouse_yc = mouse_y;         // Current mouse_y (can be snapped)
mouse_xprevious = mouse_x;  // Previous mouse_x (can be snapped)
mouse_yprevious = mouse_y;  // Previous mouse_y (can be snapped)

layer_index = 0;

select_array = [];
selection = [];

spr_index = 0;
colour = c_white;
alpha = 255;

active = false;

deactivated = [];