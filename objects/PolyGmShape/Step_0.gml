/// @desc Draw and move shape

#region Drawing on create

if drawing
{
	var _len = array_length(array);
	var _first_point = array[0];
	var _last_point = array[_len - 1];
	
	// New point
	
	if point_distance(mouse_x, mouse_y, _last_point.x, _last_point.y) > draw_distance
	{
		array_push(array, new Vec2(mouse_x, mouse_y));
	}
	
	// Finish shape
	
	else if _len > 1 // Not first point
	and point_distance(mouse_x, mouse_y, _first_point.x, _first_point.y) < (draw_distance / 2) // Close to first point
	{
		drawing = false; // Stop drawing shape
		
		if PolygonIsCounterclockwise(array) array = array_reverse(array); // Reverse shape if not clockwise
		
		ArrayUpdate();
		vbuff_empty = false;
		
		PolyGmEditor.state = EDITOR_STATES.IDLE;
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
	
	#region Find nearest points
	
	var _arr = [];
	array_copy(_arr, 0, array, 0, array_length(array));
	array_sort(_arr, function(_p, _q)
	{
	    return point_distance(mouse_x, mouse_y, _p.x, _p.y) - point_distance(mouse_x, mouse_y, _q.x, _q.y);
	});
	
	nearest_point0 = _arr[0];
	nearest_point1 = _arr[1];
	
	#endregion
	
	for (var i = 0; i < array_length(array); i++;)
	{
		var _point = array[i];
		
		#region Set bounding box
		
		if _point.x < left   left   = _point.x;
		if _point.x > right  right  = _point.x;
		if _point.y < top    top    = _point.y;
		if _point.y > bottom bottom = _point.y;
		
		#endregion
		
		if point_in_rectangle(mouse_x, mouse_y, _point.x - point_size, _point.y - point_size, _point.x + point_size, _point.y + point_size)
		{
			hover_point = _point;	
		}
	}
	
	hover_shape = hover_point == -1 and distance_to_nearest_line >= distance_to_nearest_line_min and mouse_over_shape;
}

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
	
var _n0 = function(_element, _index)
{
	return (_element == nearest_point0);
}
nearest_point0_index = array_find_index(array, _n0);
var _n1 = function(_element, _index)
{
	return (_element == nearest_point1);
}
nearest_point1_index = array_find_index(array, _n1);

if distance_to_nearest_line > distance_to_nearest_line_min mouse_point = -1;
		
#endregion

if mouse_check_button_pressed(mb_left) and mouse_over_shape
{
	PolyGmEditor.shape_selected = id;	
}

if mouse_check_button_pressed(mb_left)
{
	if hover_point
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
}

if hover_shape
{
	var _m = keyboard_check(vk_left) - keyboard_check(vk_right);
	if (keyboard_check(vk_left) and !keyboard_check(vk_right)) or (keyboard_check(vk_right) and !keyboard_check(vk_left))
	{
		for (var i = 0; i < array_length(array); i++;)
		{
			var _p = array[i];
			var _pos = new Vec2(mouse_x, mouse_y);
			var _dist = point_distance(_p.x, _p.y, _pos.x, _pos.y);
			var _dir = point_direction(_p.x, _p.y, _pos.x, _pos.y) + (2 * _m);
					
			_p.x = _pos.x - dcos(_dir) * _dist;
			_p.y = _pos.y + dsin(_dir) * _dist;
		}
		ArrayUpdate();
	}
}