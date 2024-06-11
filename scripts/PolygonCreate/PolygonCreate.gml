function PolygonCreate(_x, _y, _layer, _colour, _alpha, _sprite)
{
	var _inst = instance_create_layer(_x, _y, _layer, PolyGmShape);
	with _inst
	{
		colour = _colour;
		alpha = _alpha;
		
		PolygonSprite(_sprite);
	}
}