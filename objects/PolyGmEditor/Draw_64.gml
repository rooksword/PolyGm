/// @desc Draw GUI

global.bb_mousex = device_mouse_x_to_gui(0);
global.bb_mousey = device_mouse_y_to_gui(0);

switch state
{
	case EDITOR_STATES.IDLE:
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);

		var _b = new Button("Create shape");
		_b.DefineTL(32, 32, string_width(_b.text), string_height(_b.text));
		_b.Draw();
		if _b.Pressed()
		{
			state = EDITOR_STATES.CREATE;	
		}
		
		var _moving = -1;
		with PolyGmShape
		{
			if moving_shape _moving = id;	
		}

		if _moving != -1
		{
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
	
			var _b = new Button("Bin");
			_b.DefineC(room_width - 64, room_height - 64, 64, 64);
			_b.Draw();
			if _b.Released()
			{
				instance_destroy(_moving);
			}
	
			if instance_exists(_moving) and mouse_check_button_released(mb_left)
			{
				_moving.moving_shape = false;	
			}
		}
		break;
}