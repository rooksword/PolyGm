/// @desc Draw vertex buffer

if vbuff_empty == false vertex_submit(vbuff, pr_trianglelist, texture);

for (var i = 0; i < array_length(array); i++;)
{
	var _array = array[i];
	var _left = _array[0].x;
	var _right = _array[0].x;
	var _top = _array[0].y;
	var _bottom = _array[0].y;
	
	for (var j = 0; j < array_length(_array); j += fidelity;)
	{
		var _point = _array[j];
		
		var _size = 2;
		draw_set_colour(c_white);
		draw_rectangle(_point.x - _size, _point.y - _size, _point.x + _size, _point.y + _size, false);
		
		if _point.x < _left   _left   = _point.x;
		if _point.x > _right  _right  = _point.x;
		if _point.y < _top    _top    = _point.y;
		if _point.y > _bottom _bottom = _point.y;
	}
	
	draw_set_colour(c_orange);
	draw_line(_left,  _top,    _right, _top);
	draw_line(_left,  _bottom, _right, _bottom);
	draw_line(_left,  _top,    _left,  _bottom);
	draw_line(_right, _top,    _right, _bottom);
}