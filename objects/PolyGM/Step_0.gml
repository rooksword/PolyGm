/// @desc Add points

if mouse_check_button_pressed(mb_left)
{
	drawing = true;
	array_push(array, []);	
	array_push(array[array_length(array) - 1], new Vec2(mouse_x, mouse_y));	
}

if drawing
{
	var _array = array[array_length(array) - 1];
	var _len = array_length(_array);
	var _first_point = _array[0];
	var _last_point = _array[_len - 1];
	
	if point_distance(mouse_x, mouse_y, _last_point.x, _last_point.y) > 5
	{
		array_push(_array, new Vec2(mouse_x, mouse_y));
	}
	else if point_distance(mouse_x, mouse_y, _first_point.x, _first_point.y) < 5 and _len > 3
	{
		array_push(_array, _array[0]);
		drawing = false;
		
		ArrayUpdate();
		vbuff_empty = false;
	}
}

if keyboard_check(vk_right)
{
	fidelity++;
	ArrayUpdate();
}

if keyboard_check(vk_left) and fidelity > 4
{
	fidelity--;
	ArrayUpdate();
}