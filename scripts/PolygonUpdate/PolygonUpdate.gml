/// @desc Calculates the bounding box, center, nearest line, nearest point, mouse over point, shape, or handle
function PolygonUpdate()
{
	hover_point = -1;
	
	#region Reset bounding box
	
	right  = array[0].x;
	left   = array[0].x;
	top    = array[0].y;
	bottom = array[0].y;
	
	#endregion
	
	#region Initialize nearest point
	
	nearest_point0 = array[0];
	nearest_point0_index = 0;
	
	#endregion
	
	var _len = array_length(array);
	var _min_distance = infinity;
	
	#region Calculate center (step 1 / 3)
	
	var _xsum = 0;
	var _ysum = 0;
	
	#endregion
	
	for (var i = 0; i < _len; i++;)
	{
		var _point = array[i];
		
		#region Nearest line
		
		var _mx = PolyGmEditor.mouse_xc;
		var _my = PolyGmEditor.mouse_yc;
		var _index = (i + 1) mod _len;
		var _q = array[_index];
		
		var _distance = DistancePointToSegment(_mx, _my, _point.x, _point.y, _q.x, _q.y);
		if _distance < _min_distance
		{
			_min_distance = _distance;
			if point_distance(_mx, _my, _point.x, _point.y) < point_distance(_mx, _my, _q.x, _q.y)
			{
				nearest_point0 = _point;
				nearest_point0_index = i;
				nearest_point1 = _q;
				nearest_point1_index = _index;
			}
			else
			{
				nearest_point0 = _q;
				nearest_point0_index = _index;
				nearest_point1 = _point;
				nearest_point1_index = i;
			}
		}
		
		#endregion
		
		#region Set bounding box
		
		if _point.x < left   left   = _point.x;
		if _point.x > right  right  = _point.x;
		if _point.y < top    top    = _point.y;
		if _point.y > bottom bottom = _point.y;
		
		#endregion
		
		#region Calculate center (step 2 / 3)
		
		_xsum += _point.x;
		_ysum += _point.y;
		
		#endregion
		
		#region Is mouse over point
		
		if point_in_rectangle(PolyGmEditor.mouse_xc, PolyGmEditor.mouse_yc, _point.x - global.point_size, _point.y - global.point_size, _point.x + global.point_size, _point.y + global.point_size)
		{
			hover_point = _point;	
		}
		
		#endregion
	}
	
	#region Calculate center (step 3 / 3)
	
	x = _xsum / _len;
	y = _ysum / _len;
	
	#endregion
	
	#region Handles
	
	SetHandles();
	
	hover_handle = -1;
	for (var i = 0; i < array_length(handles); i++;)
	{
		if point_in_circle(PolyGmEditor.mouse_xc, PolyGmEditor.mouse_yc, handles[i].x, handles[i].y, global.handle_size) hover_handle = i;	
	}

	#endregion

	if hover_point == -1                                         // Mouse not over point
	and hover_handle = -1                                        // Mouse not over handle
	and distance_to_nearest_line >= distance_to_nearest_line_min // Mouse not near line
	and mouse_over_shape                                         // Mouse is over shape
	{
		hover_shape = true;
	}
	else
	{
		hover_shape = false;	
	}

	#region Mouse point
	
	var _numerator = abs((nearest_point1.y - nearest_point0.y) * PolyGmEditor.mouse_xc - (nearest_point1.x - nearest_point0.x) * PolyGmEditor.mouse_yc + nearest_point1.x * nearest_point0.y - nearest_point1.y * nearest_point0.x);
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
		var _t = ((PolyGmEditor.mouse_xc - nearest_point1.x) * _dx + (PolyGmEditor.mouse_yc - nearest_point1.y) * _dy) / (_dx * _dx + _dy * _dy)
		mouse_point = new Vec2(nearest_point1.x + _t * _dx, nearest_point1.y + _t * _dy);
	}
	
	if distance_to_nearest_line > distance_to_nearest_line_min mouse_point = -1;
		
	#endregion
}