/// @desc Create PolyGmShape

switch state
{
	case EDITOR_STATES.EDIT:
		break;
	case EDITOR_STATES.DRAW:
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
		
		if !hover_on_button and _can_draw and mouse_check_button_pressed(mb_left)
		{
			instance_create_layer(mouse_x, mouse_y, "Instances", PolyGmShape);	
		}
		break;
}

instance_activate_all();
var _cam = PolyGmCamera.cam;
instance_deactivate_region(_cam.x, _cam.y, _cam.w, _cam.h, false, true);
instance_activate_object(PolyGmCamera);