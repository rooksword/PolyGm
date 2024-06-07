/// @desc Draw and move shape

#region Drawing on create

if drawing
{
	var _len = array_length(array);
	var _first_point = array[0];
	var _last_point = array[_len - 1];
	
	// New point
	
	var _dist = point_distance(PolyGmEditor.mouse_xc, PolyGmEditor.mouse_yc, _last_point.x, _last_point.y);
	if (PolyGmEditor.auto_draw == 0 and mouse_check_button_pressed(mb_left))
	or (PolyGmEditor.auto_draw > 0 and (_dist > PolyGmEditor.auto_draw or (keyboard_check(vk_lshift) and (PolyGmEditor.mouse_xc != PolyGmEditor.mouse_xprevious or PolyGmEditor.mouse_yc != PolyGmEditor.mouse_yprevious))))
	{
		array_push(array, new Vec2(PolyGmEditor.mouse_xc, PolyGmEditor.mouse_yc));
	}
	
	// Finish shape
	
	if _len > 2 // Not first point
	and point_distance(PolyGmEditor.mouse_xc, PolyGmEditor.mouse_yc, _first_point.x, _first_point.y) < (PolyGmEditor.auto_draw == 0 ? 32 : PolyGmEditor.auto_draw) // Close to first point
	{
		drawing = false; // Stop drawing shape
		
		if PolygonIsCounterclockwise(array) array = array_reverse(array); // Reverse shape if not clockwise
		
		right  = array[0].x;
		left   = array[0].x;
		top    = array[0].y;
		bottom = array[0].y;
		
		for (var i = 0; i < _len; i++;)
		{
			var _point = array[i];
			if _point.x < left   left   = _point.x;
			if _point.x > right  right  = _point.x;
			if _point.y < top    top    = _point.y;
			if _point.y > bottom bottom = _point.y;
		}
		
		ArrayUpdate();
		vbuff_empty = false;
	}
}

#endregion

if vbuff_empty == false and PolyGmEditor.state = EDITOR_STATES.EDIT
{
	PolygonUpdate();
	
	if PolyGmEditor.mouse_xc != PolyGmEditor.mouse_xprevious
	or PolyGmEditor.mouse_yc != PolyGmEditor.mouse_yprevious
	{
		mouse_over_shape = PointInPolygon(PolyGmEditor.mouse_xc, PolyGmEditor.mouse_yc, array_tri);	
	}
	
	if PolyGmEditor.shape_selected == id
	{		
		if mouse_check_button_pressed(mb_left) // Set moving to hover
		{
			if hover_handle != -1
			{
				moving_handle = hover_handle;
			}
			else if hover_point != -1
			{
				moving_point = hover_point;	
			}
			else if mouse_point != -1 // Insert point
			{
				var _index = (nearest_point0_index > nearest_point1_index) ? nearest_point1_index + 1 : nearest_point0_index + 1;
				
				if nearest_point0_index == 0
				{
					if nearest_point1_index == 1 array_insert(array, 1, mouse_point);
					else array_push(array, mouse_point);
				}
				else
				{
					if nearest_point1_index == 0
					{
						if nearest_point0_index == 1 array_insert(array, 1, mouse_point);
						else array_push(array, mouse_point);
					}
					else array_insert(array, _index, mouse_point);
				}
				
				moving_point = mouse_point;
				
				ArrayUpdate();
			}
			else if hover_shape
			{
				moving_shape = true;
			}
		}
	
		if mouse_check_button_pressed(mb_right) // Delete point
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

		if moving_handle != -1 // Scale shape
		{
			var _m = [4, 5, 6, 7, 0, 1, 2, 3];
			var _o = _m[moving_handle];
		
			var _x0 = handles_real[moving_handle].x - handles_real[_o].x;
			var _y0 = handles_real[moving_handle].y - handles_real[_o].y;
			var _x1 = (PolyGmEditor.mouse_xc > right ? PolyGmEditor.mouse_xc - 16 : PolyGmEditor.mouse_xc + 16) - handles_real[_o].x;
			var _y1 = (PolyGmEditor.mouse_yc > bottom ? PolyGmEditor.mouse_yc - 16 : PolyGmEditor.mouse_yc + 16) - handles_real[_o].y;
		
			for (var i = 0; i < array_length(array); i++;)
			{
				var _p = array[i];
			
				if handles_real[moving_handle].x != handles_real[_o].x // If mouse handle x is not equal to opposite handle x
				{
					_p.x = handles_real[_o].x + ((_x1 / _x0) * (_p.x - handles_real[_o].x)); // Opposite.x + (ratio * difference between point and opposite handle)
				}
			
				if handles_real[moving_handle].y != handles_real[_o].y
				{
					_p.y = handles_real[_o].y + ((_y1 / _y0) * (_p.y - handles_real[_o].y));
				}
			}
			ArrayUpdate();
		
			if mouse_check_button_released(mb_left)
			{
				moving_handle = -1;	
			}
		}
		else if moving_point != -1 // Move point
		{
			moving_point.x += PolyGmEditor.mouse_xc - PolyGmEditor.mouse_xprevious;
			moving_point.y += PolyGmEditor.mouse_yc - PolyGmEditor.mouse_yprevious;
			ArrayUpdate();

			if mouse_check_button_released(mb_left)
			{
				moving_point = -1;	
			}
		}
		else if moving_shape // Move shape
		{
			for (var i = 0; i < array_length(array); i++;)
			{
				var _p = array[i];
				_p.x += PolyGmEditor.mouse_xc - PolyGmEditor.mouse_xprevious;
				_p.y += PolyGmEditor.mouse_yc - PolyGmEditor.mouse_yprevious;
			}
			ArrayUpdate();
	
			if mouse_check_button_released(mb_left)
			{
				moving_shape = false;	
			}
		}
	}
}