/// @desc Move point

if PolyGmEditor.state == EDITOR_STATES.BEZIER
{
	if point_hold == -1
	{
		point_hover = -1;
		var _len = array_length(line);
		for (var i = 0; i < _len; i++;)
		{
			var _p = line[i];
			if point_distance(mouse_x, mouse_y, _p.x, _p.y) < 20
			{
				point_hover = i;
			}
		}
	}

	if point_hover != -1 and mouse_check_button_pressed(mb_left)
	{
		point_hold = point_hover;
	}

	if point_hold != -1
	{
		line[point_hold] = new Vec2(mouse_x, mouse_y);
	
		if mouse_check_button_released(mb_left)
		{
			point_hold = -1;	
		}
	}
	
	if (point_hover != -1 or point_hold != -1) and keyboard_check_pressed(vk_backspace)
	{
		instance_destroy();	
	}
}

time += 0.006;