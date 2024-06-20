/// @desc Draw vertex buffer

function ShapeDrawDebug()
{
	var _selected = PolyGmEditor.shape_selected == id;

	if !locked and PolyGmEditor.state == EDITOR_STATES.SELECT
	{
		var _len = array_length(array);
		for (var i = 0; i < _len; i++;)
		{
			var _point = array[i];
			draw_set_colour(c_white);
			if InArray(_point, PolyGmEditor.select_array)
			{
				draw_set_colour(c_blue);	
			}
			draw_rectangle(_point.x - global.point_size, _point.y - global.point_size, _point.x + global.point_size, _point.y + global.point_size, false);
		}
	}

	if PolyGmEditor.state == EDITOR_STATES.EDIT_SELECT
	{
		var _len = array_length(array);
		for (var i = 0; i < _len; i++;)
		{
			var _point = array[i];
			if InArray(_point, PolyGmEditor.select_array)
			{
				draw_set_colour(c_blue);	
				draw_rectangle(_point.x - global.point_size, _point.y - global.point_size, _point.x + global.point_size, _point.y + global.point_size, false);
			}
		}
	}

	if drawing or (_selected and PolyGmEditor.state == EDITOR_STATES.EDIT)
	{
		#region Debug
	
		var _len = array_length(array);
		for (var i = 0; i < _len; i++;)
		{
			var _point = array[i];
		
			draw_set_colour(c_white);
			if drawing and i < array_length(array) - 1
			{
				draw_line(_point.x, _point.y, array[i + 1].x, array[i + 1].y);	
			}
		
			if hover_point == _point draw_set_colour(c_aqua);
			draw_rectangle(_point.x - global.point_size, _point.y - global.point_size, _point.x + global.point_size, _point.y + global.point_size, false);
		
			if drawing and global.auto_draw_circles > 0 and i == _len - 1
			{
				draw_set_alpha(0.25);
			
				if global.auto_draw_circles == 1 draw_circle(_point.x, _point.y, global.auto_draw, true);
				if global.auto_draw_circles == 2
				{
					var _dir = point_direction(_point.x, _point.y, PolyGmEditor.mouse_xc, PolyGmEditor.mouse_yc);
					var _dist = global.auto_draw;
					draw_line(_point.x, _point.y, _point.x + lengthdir_x(_dist, _dir), _point.y + lengthdir_y(_dist, _dir));
				}
			
				draw_set_alpha(1);
			}
	
			if hover_point == -1 and mouse_point != -1
			{
				draw_set_colour(c_blue);
				draw_line_width(nearest_point0.x, nearest_point0.y, nearest_point1.x, nearest_point1.y, 2);
			
				draw_set_colour(c_lime);
				draw_rectangle(mouse_point.x - global.point_size, mouse_point.y - global.point_size, mouse_point.x + global.point_size, mouse_point.y + global.point_size, false);
			}
		
			draw_set_colour(c_white);
			draw_text(_point.x, _point.y, i);
		}
	
		if !drawing
		{
			draw_set_colour(c_orange);
			draw_rectangle(left, top, right, bottom, true);
	
			var _len_handles = array_length(handles);
			for (var i = 0; i < _len_handles; i++;)
			{
				draw_set_colour(hover_handle == i ? c_red : c_orange);
				draw_circle(handles[i].x, handles[i].y, global.handle_size, false);
			}
		}
	
		#endregion
	}
}