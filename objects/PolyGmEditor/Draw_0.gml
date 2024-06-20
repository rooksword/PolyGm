/// @desc Draw select rectangle

if state == EDITOR_STATES.SELECT
{
	draw_set_colour(c_blue);
	var _len = array_length(selection);
	for (var i = 0; i < _len; i++;)
	{
		var _p = selection[i];
		var _q = i < _len - 1 ? selection[i + 1] : selection[0];
		draw_line(_p.x, _p.y, _q.x, _q.y);
	}
}

if active and state == EDITOR_STATES.BEZIER
{
	with PolyGmBezier BezierDrawDebug();
}