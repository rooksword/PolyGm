/// @desc Variables

#region Movement

hover_shape = false;
hover_point = -1;
hover_handle = -1;

moving_shape = false;
moving_point = -1;
moving_handle = -1;

mouse_over_shape = false;

#endregion

#region Drawing

drawing = true;
point_size = 4;
handle_size = 8;

right = 0;
left = 0;
top = 0;
bottom = 0;

/*
a-b-c
h   d
g-f-e
*/

function SetHandles()
{
	var _o = 16;
	a = new Vec2(left - _o, top - _o);
	c = new Vec2(right + _o, top - _o);
	e = new Vec2(right + _o, bottom + _o);
	g = new Vec2(left - _o, bottom + _o);
	
	b = new Vec2(mean(left, right), top - _o);
	d = new Vec2(right + _o, mean(top, bottom));
	f = new Vec2(mean(left, right), bottom + _o);
	h = new Vec2(left - _o, mean(top, bottom));
}
SetHandles();

nearest_point0 = -1;
nearest_point0_index = -1;
nearest_point1 = -1;
nearest_point1_index = -1;
mouse_point = -1;
distance_to_nearest_line = 0;
distance_to_nearest_line_min = 16;

#endregion

#region Texture

sprite  = spr_rock;
frame   = 0;
texture = sprite_get_texture(sprite, frame);
uvs     = sprite_get_uvs(sprite, frame);

#endregion

#region Vertex format and buffer

vertex_format_begin();

vertex_format_add_position();
vertex_format_add_texcoord();
vertex_format_add_color();

format = vertex_format_end();
vbuff = vertex_create_buffer();
vbuff_empty = true;

#endregion

#region Array

array = [new Vec2(mouse_x, mouse_y)];
array_tri = [];

#endregion