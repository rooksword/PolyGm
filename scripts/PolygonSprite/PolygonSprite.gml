function PolygonSprite(_sprite)
{
	sprite  = _sprite;
	texture = sprite_get_texture(sprite, frame);
	uvs     = sprite_get_uvs(sprite, frame);
	ArrayUpdate();
}