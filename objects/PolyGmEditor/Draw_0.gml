/// @desc Draw select rectangle

switch state
{
	case EDITOR_STATES.SELECT:
		draw_set_colour(c_blue);
		var _len = array_length(selection);
		for (var i = 0; i < _len; i++;)
		{
			var _p = selection[i];
			var _q = i < _len - 1 ? selection[i + 1] : selection[0];
			draw_line(_p.x, _p.y, _q.x, _q.y);
		}
		break;
	case EDITOR_STATES.BEZIER:
		if active
		{
			with PolyGmBezier BezierDrawDebug();
		}
		break;
	case EDITOR_STATES.EDIT_OBJECT:
		var _l = shape_selected.bbox_left;
		var _t = shape_selected.bbox_top;
		var _r = shape_selected.bbox_right;
		var _b = shape_selected.bbox_bottom;
		draw_set_colour(c_orange);
		draw_rectangle(_l, _t, _r, _b, true);
		break;
}