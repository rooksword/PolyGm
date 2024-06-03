/// @desc Draw vertex buffer

var _selected = PolyGmEditor.shape_selected == id;

if vbuff_empty == false
{
	var _darken = (mouse_over_shape and !_selected) or (hover_shape and moving_point == -1);
	if _darken shader_set(sh_darken);
	vertex_submit(vbuff, pr_trianglelist, texture);
	if _darken shader_reset();
}

if drawing or _selected
{
	#region Debug
	
	for (var i = 0; i < array_length(array); i++;)
	{
		var _point = array[i];
	
		draw_set_colour(c_white);
		if hover_point == _point draw_set_colour(c_aqua);
		draw_rectangle(_point.x - point_size, _point.y - point_size, _point.x + point_size, _point.y + point_size, false);
	
		if hover_point == -1 and mouse_point != -1
		{
			draw_set_colour(c_blue);
			draw_line_width(nearest_point0.x, nearest_point0.y, nearest_point1.x, nearest_point1.y, 2);
			
			draw_set_colour(c_lime);
			draw_rectangle(mouse_point.x - point_size, mouse_point.y - point_size, mouse_point.x + point_size, mouse_point.y + point_size, false);
		}
	}
	
	draw_set_colour(c_orange);
	draw_line(left,  top,    right, top);
	draw_line(left,  bottom, right, bottom);
	draw_line(left,  top,    left,  bottom);
	draw_line(right, top,    right, bottom);
	
	draw_set_colour("a" == hover_handle ? c_red : c_orange);
	draw_circle(a.x, a.y, handle_size, false);
	draw_set_colour("b" == hover_handle ? c_red : c_orange);
	draw_circle(b.x, b.y, handle_size, false);
	draw_set_colour("c" == hover_handle ? c_red : c_orange);
	draw_circle(c.x, c.y, handle_size, false);
	draw_set_colour("d" == hover_handle ? c_red : c_orange);
	draw_circle(d.x, d.y, handle_size, false);
	draw_set_colour("e" == hover_handle ? c_red : c_orange);
	draw_circle(e.x, e.y, handle_size, false);
	draw_set_colour("f" == hover_handle ? c_red : c_orange);
	draw_circle(f.x, f.y, handle_size, false);
	draw_set_colour("g" == hover_handle ? c_red : c_orange);
	draw_circle(g.x, g.y, handle_size, false);
	draw_set_colour("h" == hover_handle ? c_red : c_orange);
	draw_circle(h.x, h.y, handle_size, false);
	
	draw_set_colour(c_white);
	draw_text(a.x, a.y, "A");
	draw_text(b.x, b.y, "B");
	draw_text(c.x, c.y, "C");
	draw_text(d.x, d.y, "D");
	draw_text(e.x, e.y, "E");
	draw_text(f.x, f.y, "F");
	draw_text(g.x, g.y, "G");
	draw_text(h.x, h.y, "H");

	#endregion
}