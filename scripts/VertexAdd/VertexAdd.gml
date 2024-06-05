function VertexAdd(_vbuff, _position, _uvs, _sprite, _colour, _alpha)
{
	var _wid = (_uvs[2] - _uvs[0]);
	var _hei = (_uvs[3] - _uvs[1]);
	var _w = _wid / sprite_get_width(_sprite);
	var _h = _hei / sprite_get_height(_sprite);
	
	vertex_position_3d(_vbuff, _position.x,      _position.y, 0);
	vertex_texcoord(_vbuff, _position.x * _w, _position.y * _h);
	vertex_colour(_vbuff, _colour, _alpha);
	vertex_float4(_vbuff, _wid, _hei, _uvs[0] / _w, _uvs[1] / _h);
}