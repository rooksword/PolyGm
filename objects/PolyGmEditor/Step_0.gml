/// @desc Create PolyGmShape

switch state
{
	case EDITOR_STATES.IDLE:
		break;
	case EDITOR_STATES.CREATE:
		var _can_draw = true;

		with PolyGmShape
		{
			if drawing
			or hover_shape
			or hover_point != -1
			or distance_to_nearest_line < distance_to_nearest_line_min
			{
				_can_draw = false;
			}
		}

		if _can_draw and mouse_check_button_pressed(mb_left)
		{
			instance_create_layer(mouse_x, mouse_y, "Instances", PolyGmShape);	
		}
		break;
}