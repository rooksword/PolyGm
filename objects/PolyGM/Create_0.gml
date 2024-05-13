/// @desc Initialize

gpu_set_texrepeat(true);

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

array = [];

#endregion

#region Drawing

drawing = false;
fidelity = 8;

#endregion