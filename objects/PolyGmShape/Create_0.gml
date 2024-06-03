/// @desc Variables

#region Movement

hover_shape = false;
hover_point = -1;

moving_shape = false;
moving_point = -1;

mouse_over_shape = false;

scale = 1;

#endregion

#region Drawing

drawing = true;
point_size = 4;

right = 0;
left = 0;
top = 0;
bottom = 0;

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

#endregion