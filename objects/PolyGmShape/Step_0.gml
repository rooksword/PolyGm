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
	
	if _len > 3 // Not first point
	and point_distance(mouse_x, mouse_y, _first_point.x, _first_point.y) < point_size // Close to first point
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
	mouse_over_shape = PointInPolygon(mouse_x, mouse_y, PolygonToTriangles(array));
	
	#region Reset bounding box
	
	right  = array[0].x;
	left   = array[0].x;
	top    = array[0].y;
	bottom = array[0].y;
	
	#endregion
	
	hover_point = -1;
	
	nearest_point0 = array[0];
	nearest_point0_index = 0;
	
	var _xsum = 0;
	var _ysum = 0;
	var _len = array_length(array);
	
	for (var i = 0; i < _len; i++;)
	{
		var _point = array[i];
		
		#region Set bounding box
		
		if _point.x < left   left   = _point.x;
		if _point.x > right  right  = _point.x;
		if _point.y < top    top    = _point.y;
		if _point.y > bottom bottom = _point.y;
		
		#endregion

		_xsum += _point.x;
		_ysum += _point.y;
		
		if point_in_rectangle(mouse_x, mouse_y, _point.x - point_size, _point.y - point_size, _point.x + point_size, _point.y + point_size)
		{
			hover_point = _point;	
		}
		
		var _p = array[i];
		var _d0 = point_distance(mouse_x, mouse_y, nearest_point0.x, nearest_point0.y);
		var _d1 = point_distance(mouse_x, mouse_y, _p.x,             _p.y);
		if _d1 < _d0
		{
			nearest_point0 = array[i];
			nearest_point0_index = i;
		}
	}
	
	var _next = nearest_point0_index < array_length(array) - 1 ? nearest_point0_index + 1 : 0;
	var _prev = nearest_point0_index > 0 ? nearest_point0_index - 1 : array_length(array) - 1;
	var _a = array[_next];
	var _b = array[_prev];
	
	if point_distance(mouse_x, mouse_y, _a.x, _a.y) < point_distance(mouse_x, mouse_y, _b.x, _b.y)
	{
		nearest_point1 = _a;
		nearest_point1_index = _next;
	}
	else
	{
		nearest_point1 = _b;
		nearest_point1_index = _prev;
	}
	
	x = _xsum / _len;
	y = _ysum / _len;
	
	hover_shape = hover_point == -1 and distance_to_nearest_line >= distance_to_nearest_line_min and mouse_over_shape;

	#region Mouse point
		
	var _numerator = abs((nearest_point1.y - nearest_point0.y) * mouse_x - (nearest_point1.x - nearest_point0.x) * mouse_y + nearest_point1.x * nearest_point0.y - nearest_point1.y * nearest_point0.x);
	var _denominator = sqrt(sqr(nearest_point1.y - nearest_point0.y) + sqr(nearest_point1.x - nearest_point0.x));
	distance_to_nearest_line = _numerator / _denominator;
		
	var _dx = nearest_point1.x - nearest_point0.x;
	var _dy = nearest_point1.y - nearest_point0.y;
	if _dx == 0 and _dy == 0
	{
		mouse_point = new Vec2(nearest_point1.x, nearest_point1.y);
	}
	else
	{
		var _t = ((mouse_x - nearest_point1.x) * _dx + (mouse_y - nearest_point1.y) * _dy) / (_dx * _dx + _dy * _dy)
		mouse_point = new Vec2(nearest_point1.x + _t * _dx, nearest_point1.y + _t * _dy);
	}
	
	if distance_to_nearest_line > distance_to_nearest_line_min mouse_point = -1;
		
	#endregion
	
	if mouse_check_button_pressed(mb_left)
	{
		if mouse_over_shape
		{
			PolyGmEditor.shape_selected = id;	
		}
		
		if hover_point != -1
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

	if moving_point != -1
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
	
	if keyboard_check_pressed(vk_space)
	{
		scale += 0.1;
		for (var i = 0; i < array_length(array); i++;)
		{
			var _p = array[i];
			var _o = new Vec2(left, mean(top, bottom));
			_p.x = _o.x + scale * (_p.x - _o.x);
			_p.y = _o.y + scale * (_p.y - _o.y);
		}
		ArrayUpdate();
	}
}