/// @desc Draw vertex buffer

var _selected = PolyGmEditor.shape_selected == id;

if vbuff_empty == false
{
	var _darken = ((mouse_over_shape and !_selected) or (hover_shape and moving_point == -1)) * 0.33;
	shader_set(sh_colour);
	shader_set_uniform_f_array(shader_get_uniform(sh_colour, "colour"), [
		colour_get_red(colour)   / 255 - _darken,
		colour_get_green(colour) / 255 - _darken,
		colour_get_blue(colour)  / 255 - _darken, (alpha * layer_hover) / 255]);
	vertex_submit(vbuff, pr_trianglelist, texture);
	shader_reset();
}

if !locked and PolyGmEditor.state == EDITOR_STATES.SELECT
{
	for (var i = 0; i < array_length(array); i++;)
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
	for (var i = 0; i < array_length(array); i++;)
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
	
	for (var i = 0; i < array_length(array); i++;)
	{
		var _point = array[i];
		
		draw_set_colour(c_white);
		if drawing and i < array_length(array) - 1
		{
			draw_line(_point.x, _point.y, array[i + 1].x, array[i + 1].y);	
		}
		
		if hover_point == _point draw_set_colour(c_aqua);
		draw_rectangle(_point.x - global.point_size, _point.y - global.point_size, _point.x + global.point_size, _point.y + global.point_size, false);
		
		if drawing and global.auto_draw_circles
		{
			draw_set_alpha(0.25);
			draw_circle(_point.x, _point.y, PolyGmEditor.auto_draw, true);
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
	
		for (var i = 0; i < array_length(handles); i++;)
		{
			draw_set_colour(hover_handle == i ? c_red : c_orange);
			draw_circle(handles[i].x, handles[i].y, global.handle_size, false);
		}
	}
	
	#endregion
}