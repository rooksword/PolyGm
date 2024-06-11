function PolygonDuplicate(_polygon, _x_offset, _y_offset)
{
	var _new_shape = instance_create_layer(_polygon.x, _polygon.y, _polygon.layer, PolyGmShape);
	_new_shape.right = _polygon.right;
	_new_shape.left = _polygon.left;
	_new_shape.top = _polygon.top;
	_new_shape.bottom = _polygon.bottom;
	_new_shape.colour = _polygon.colour;
	_new_shape.alpha = _polygon.alpha;
	_new_shape.array = [];
	
	for (var j = 0; j < array_length(_polygon.array); j++;)
	{
		var _p = _polygon.array[j];
		array_push(_new_shape.array, new Vec2(_p.x, _p.y));
	}
	
	with _new_shape
	{			
		drawing = false;
		for (var i = 0; i < array_length(array); i++;)
		{
			var _point = array[i];
			_point.x += _x_offset;
			_point.y += _y_offset;
		}
		PolygonSprite(_polygon.sprite);
		vbuff_empty = false;
	}
}