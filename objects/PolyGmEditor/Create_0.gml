/// @desc Initialize

window_set_cursor(cr_none); // Remove default windows cursor
						    
gpu_set_texrepeat(true);    // Set all textures to repeat infinitely
						    
enum EDITOR_STATES          // States control what buttons and actions are available
{						    
	EDIT,			    
	DRAW,
	SELECT,
	EDIT_SELECT
}						    
						    
state = EDITOR_STATES.EDIT; // Set the default state to 'edit'
						    
auto_draw = 64;             // The distance between points when drawing in freehand mode
						    
shape_selected = -1;        // Holds a reference to the currently selected shape
hover_on_button = false;    // Is the mouse hovering over a button?
						    
mouse_xc = mouse_x;         // Current mouse_x (can be snapped)
mouse_yc = mouse_y;         // Current mouse_y (can be snapped)
mouse_xprevious = mouse_x;  // Previous mouse_x (can be snapped)
mouse_yprevious = mouse_y;  // Previous mouse_y (can be snapped)

layers = layer_get_all();
layers_locked = [];
layer_index = 0;

select_array = [];
selection = [];