/// @desc Draw select rectangle

if state == EDITOR_STATES.SELECT
{
	draw_set_colour(c_blue);
	for (var i = 0; i < array_length(selection); i++;)
	{
		var _p = selection[i];
		var _q = i < array_length(selection) - 1 ? selection[i + 1] : selection[0];
		draw_line(_p.x, _p.y, _q.x, _q.y);
	}
}