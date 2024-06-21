/// @desc Draw GUI

function PolyGmEditorDrawGUI()
{
	var _m = PosGui(mouse_xc, mouse_yc);
	
	draw_set_font(fnt_poly);
	
	if keyboard_check(vk_lshift)
	{
		draw_sprite_tiled_ext(spr_grid, -1, -camera_get_view_x(view_camera[0]), -camera_get_view_y(view_camera[0]), global.grid_size / sprite_get_width(spr_grid), global.grid_size / sprite_get_height(spr_grid), c_white, 0.1);
	}
	
	var _select = false;
	with PolyGmShape
	{
		if mouse_over_shape or hover_point != -1 or hover_handle != -1 or mouse_point != -1
		{
			_select = true;
		}
	}
	
	if shape_selected != -1 and shape_selected.object_index == PolyGmObject
	{
		if shape_selected.mo
		or shape_selected.mt
		or position_meeting(mouse_xc, mouse_yc, shape_selected)
		{
			_select = true;
		}
	}

	if shape_selected != -1 // Shape is selected
	and !_select // Not interacting with shape
	and mouse_check_button_pressed(mb_left) // LMB pressed
	and active
	{
		shape_selected = -1;	
	}

	if active draw_sprite(spr_cursor, -1, _m[0], _m[1]);
}

if global.draw_editor PolyGmEditorDrawGUI();