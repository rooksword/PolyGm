/// @desc Draw and move shape

#region Drawing on create

if drawing
{
	var _len = array_length(array);
	var _first_point = array[0];
	var _last_point = array[_len - 1];
	
	// New point
	
	if (PolyGmEditor.auto_draw == 0 and mouse_check_button_pressed(mb_left))
	or (PolyGmEditor.auto_draw > 0 and point_distance(mouse_x, mouse_y, _last_point.x, _last_point.y) > PolyGmEditor.auto_draw)
	{
		array_push(array, new Vec2(mouse_x, mouse_y));
	}
	
	// Finish shape
	
	if _len > 2 // Not first point
	and point_distance(mouse_x, mouse_y, _first_point.x, _first_point.y) < (PolyGmEditor.auto_draw == 0 ? 32 : PolyGmEditor.auto_draw) // Close to first point
	{
		drawing = false; // Stop drawing shape
		
		if PolygonIsCounterclockwise(array) array = array_reverse(array); // Reverse shape if not clockwise
		
		ArrayUpdate();
		vbuff_empty = false;
	}
}

#endregion

if vbuff_empty == false
{
	if mouse_x != PolyGmEditor.mouse_xprevious
	or mouse_y != PolyGmEditor.mouse_yprevious
	{
		mouse_over_shape = PointInPolygon(mouse_x, mouse_y, array_tri);	
	}
	
	PolygonUpdate();
	
	if mouse_check_button_pressed(mb_left)
	{
		if mouse_over_shape
		{
			PolyGmEditor.shape_selected = id;	
		}
		
		if hover_handle != -1
		{
			moving_handle = hover_handle;
		}
		else if hover_point != -1
		{
			moving_point = hover_point;	
		}
		else if mouse_point != -1
		{
			var _index = nearest_point0_index > nearest_point1_index ? nearest_point0_index : nearest_point1_index;
			array_insert(array, _index, mouse_point);
			moving_point = array[_index];
			ArrayUpdate();
		}
		else if hover_shape
		{
			moving_shape = true;
		}
	}
	
	if mouse_check_button_pressed(mb_right)
	{
		if hover_point != -1
		{
			var _d = function(_element, _index)
			{
				return (_element == hover_point);
			}
			array_delete(array, array_find_index(array, _d), 1);
			ArrayUpdate();
		}
	}

	if moving_handle != -1
	{
		var _m, _o;
		if moving_handle == "a" _m = a;
		if moving_handle == "b" _m = b;
		if moving_handle == "c" _m = c;
		if moving_handle == "d" _m = d;
		if moving_handle == "e" _m = e;
		if moving_handle == "f" _m = f;
		if moving_handle == "g" _m = g;
		if moving_handle == "h" _m = h;
		
		if moving_handle == "a" _o = e;
		if moving_handle == "b" _o = f;
		if moving_handle == "c" _o = g;
		if moving_handle == "d" _o = h;
		if moving_handle == "e" _o = a;
		if moving_handle == "f" _o = b;
		if moving_handle == "g" _o = c;
		if moving_handle == "h" _o = d;
		
		var _d0 = point_distance(_m.x, _m.y, _o.x, _o.y);
		var _d1 = point_distance(mouse_x, mouse_y, _o.x, _o.y);
		
		var _scale = (_d1 / _d0);
		
		for (var i = 0; i < array_length(array); i++;)
		{
			var _p = array[i];
			if _m.x != _o.x _p.x = _o.x + _scale * (_p.x - _o.x);
			if _m.y != _o.y _p.y = _o.y + _scale * (_p.y - _o.y);
		}
		ArrayUpdate();
		
		if mouse_check_button_released(mb_left)
		{
			moving_handle = -1;	
		}
	}
	else if moving_point != -1
	{
		moving_point.Add(new Vec2(mouse_x - PolyGmEditor.mouse_xprevious, mouse_y - PolyGmEditor.mouse_yprevious));
		ArrayUpdate();

		if mouse_check_button_released(mb_left)
		{
			moving_point = -1;	
		}
	}
	else if moving_shape
	{
		for (var i = 0; i < array_length(array); i++;)
		{
			var _p = array[i];
			_p.Add(new Vec2(mouse_x - PolyGmEditor.mouse_xprevious, mouse_y - PolyGmEditor.mouse_yprevious)); 
		}
		ArrayUpdate();
	
		if mouse_check_button_released(mb_left)
		{
			moving_shape = false;	
		}
	}
}