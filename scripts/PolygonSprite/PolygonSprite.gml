/// @desc Sets the texture of the instance of PolyGmShape from which the function is called and updates its texture and uv values
/// @param {Asset.GMSprite} _sprite Texture
function PolygonSprite(_sprite)
{
	sprite  = _sprite;
	texture = sprite_get_texture(sprite, frame);
	uvs     = sprite_get_uvs(sprite, frame);
	if array_length(array) > 1 ArrayUpdate();
}