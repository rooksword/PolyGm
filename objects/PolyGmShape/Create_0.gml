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

colour = c_white;
alpha = 255;

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
	handles = [];
	handles_real = [];
	var _o = 16;
	array_push(handles, 
		new Vec2(left - _o, top - _o),
		new Vec2(mean(left, right), top - _o),
		new Vec2(right + _o, top - _o),
		new Vec2(right + _o, mean(top, bottom)),
		new Vec2(right + _o, bottom + _o),
		new Vec2(mean(left, right), bottom + _o),
		new Vec2(left - _o, bottom + _o),
		new Vec2(left - _o, mean(top, bottom))
	);
	
	array_push(handles_real, 
		new Vec2(left, top),
		new Vec2(mean(left, right), top),
		new Vec2(right, top),
		new Vec2(right, mean(top, bottom)),
		new Vec2(right, bottom),
		new Vec2(mean(left, right), bottom),
		new Vec2(left, bottom),
		new Vec2(left, mean(top, bottom))
	);
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

spr_index = 0;
sprite  = global.textures[spr_index];
frame   = 0;
texture = sprite_get_texture(sprite, frame);
uvs     = sprite_get_uvs(sprite, frame);

#endregion

#region Vertex format and buffer

vertex_format_begin();

vertex_format_add_position_3d();
vertex_format_add_texcoord();
vertex_format_add_color();
vertex_format_add_custom( vertex_type_float4, vertex_usage_textcoord);

format = vertex_format_end();
vbuff = vertex_create_buffer();
vbuff_empty = true;

#endregion

#region Array

array = [new Vec2(PolyGmEditor.mouse_xc, PolyGmEditor.mouse_yc)];
array_tri = [];

#endregion