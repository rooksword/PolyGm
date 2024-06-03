function VertexAdd(_vbuff, _position, _uvs, _sprite, _colour, _alpha)
{
	var _w = (_uvs[2] - _uvs[0]) / sprite_get_width(_sprite);
	var _h = (_uvs[3] - _uvs[1]) / sprite_get_height(_sprite);
	
	vertex_position(_vbuff, _position.x,      _position.y);
	vertex_texcoord(_vbuff, _position.x * _w, _position.y * _h);
	vertex_colour(_vbuff, _colour, _alpha);
}