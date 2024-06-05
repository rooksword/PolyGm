/// @desc Create PolyGmShape

#region Snap mouse to grid

mouse_xc = mouse_x;
mouse_yc = mouse_y;
if keyboard_check(vk_lshift)
{
	mouse_xc = floor(mouse_x / 32) * 32;	
	mouse_yc = floor(mouse_y / 32) * 32;
}

#endregion

switch state
{
	case EDITOR_STATES.EDIT:
		break;
	case EDITOR_STATES.DRAW:
		var _can_draw = true;

		with PolyGmShape
		{
			if drawing
			or hover_shape == true
			or hover_point != -1
			or hover_handle != -1
			or mouse_point != -1
			{
				_can_draw = false;
			}
		}
		
		if !hover_on_button and _can_draw and mouse_check_button_pressed(mb_left)
		{
			instance_create_layer(mouse_xc, mouse_yc, "Instances", PolyGmShape);	
		}
		break;
}

instance_activate_object(PolyGmShape);


var _cam = PolyGmCamera.cam;

with PolyGmShape
{
	if !drawing
	and !(
	   point_in_rectangle(left, top, _cam.x, _cam.y, _cam.x + _cam.w, _cam.y + _cam.h)
	or point_in_rectangle(right, top, _cam.x, _cam.y, _cam.x + _cam.w, _cam.y + _cam.h)
	or point_in_rectangle(right, bottom, _cam.x, _cam.y, _cam.x + _cam.w, _cam.y + _cam.h)
	or point_in_rectangle(left, bottom, _cam.x, _cam.y, _cam.x + _cam.w, _cam.y + _cam.h)
	)
	{
		instance_deactivate_object(id);	
	}
}

show_debug_message(instance_number(PolyGmShape));