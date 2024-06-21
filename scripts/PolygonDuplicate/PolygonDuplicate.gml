/// @desc Creates a new instance of PolyGmShape which is a duplicate of the selected instances
/// @param {Id.Instance} _shape Instance of PolyGmShape
/// @param {real} _x_offset Pixels to horizontally offset the new shape by
/// @param {real} _y_offset Pixels to vertically offset the new shape by
function PolygonDuplicate(_polygon, _x_offset, _y_offset)
{
	var _new_shape = PolygonCreate(_polygon.x, _polygon.y, _polygon.layer, _polygon.colour, _polygon.alpha, -1);
	
	_new_shape.right = _polygon.right;
	_new_shape.left = _polygon.left;
	_new_shape.top = _polygon.top;
	_new_shape.bottom = _polygon.bottom;
	
	_new_shape.array = variable_clone(_polygon.array);
	
	with _new_shape
	{			
		drawing = false;
		var _len = array_length(array);
		for (var i = 0; i < _len; i++;)
		{
			var _point = array[i];
			_point.x += _x_offset;
			_point.y += _y_offset;
		}
		PolygonSprite(_polygon.sprite);
		vbuff_empty = false;
	}
}