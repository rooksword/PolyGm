/// @desc Creates a new PolyGmShape instance
/// @param {real} _x X position of instance
/// @param {real} _y Y position of instance
/// @param {real} _layer The layer on which to make the instance
/// @param {real} _colour Colour (i.e. c_white or make_colour_rgb(255, 255, 255))
/// @param {real} _alpha Alpha (0-255)
/// @param {Asset.GMSprite} _sprite Texture or -1 (if the polygon doesn't have an array yet)
function PolygonCreate(_x, _y, _layer, _colour, _alpha, _sprite)
{
	var _inst = instance_create_layer(_x, _y, _layer, PolyGmShape);
	with _inst
	{
		colour = _colour;
		alpha = _alpha;
		
		if _sprite != -1 PolygonSprite(_sprite);
	}
	
	array_push(PolyGmShapeDraw.shapes, _inst);
	if array_length(PolyGmShapeDraw.shapes) > 1
	{
		array_sort(PolyGmShapeDraw.shapes, function(_elm1, _elm2)
		{
		    return _elm2.depth - _elm1.depth;
		});
	}
	
	return _inst;
}