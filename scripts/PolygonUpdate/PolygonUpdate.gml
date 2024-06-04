function PolygonUpdate()
{
	hover_point = -1;
	
	#region Reset bounding box
	
	right  = array[0].x;
	left   = array[0].x;
	top    = array[0].y;
	bottom = array[0].y;
	
	#endregion
	
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
	
	SetHandles();
	
		hover_handle = -1;
	if point_in_circle(mouse_x, mouse_y, a.x, a.y, handle_size) hover_handle = "a";
	if point_in_circle(mouse_x, mouse_y, b.x, b.y, handle_size) hover_handle = "b";
	if point_in_circle(mouse_x, mouse_y, c.x, c.y, handle_size) hover_handle = "c";
	if point_in_circle(mouse_x, mouse_y, d.x, d.y, handle_size) hover_handle = "d";
	if point_in_circle(mouse_x, mouse_y, e.x, e.y, handle_size) hover_handle = "e";
	if point_in_circle(mouse_x, mouse_y, f.x, f.y, handle_size) hover_handle = "f";
	if point_in_circle(mouse_x, mouse_y, g.x, g.y, handle_size) hover_handle = "g";
	if point_in_circle(mouse_x, mouse_y, h.x, h.y, handle_size) hover_handle = "h";

	hover_shape =
		hover_point == -1
	and hover_handle = -1
	and distance_to_nearest_line >= distance_to_nearest_line_min
	and mouse_over_shape;

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
}