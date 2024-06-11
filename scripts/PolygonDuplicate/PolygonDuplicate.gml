function PolygonDuplicate(_polygon, _x_offset, _y_offset)
{
	var _new_shape = instance_create_layer(0, 0, _polygon.layer, PolyGmShape);	
	_new_shape.array = [];
	for (var j = 0; j < array_length(_polygon.array); j++;)
	{
		var _p = _polygon.array[j];
		array_push(_new_shape.array, new Vec2(_p.x, _p.y));
	}
	with _new_shape
	{
		sprite  = _polygon.sprite;
		texture = sprite_get_texture(sprite, frame);
		uvs     = sprite_get_uvs(sprite, frame);
						
		drawing = false;
		for (var j = 0; j < array_length(array); j++;)
		{
			var _point = array[j];
			_point.x += _x_offset;
			_point.y += _y_offset;
		}
		ArrayUpdate();
		vbuff_empty = false;
	}
}