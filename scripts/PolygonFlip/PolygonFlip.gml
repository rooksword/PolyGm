/// @desc Flips a polygon horizontally or vertically around its center
/// @param {Id.Instance} _shape Instance of PolyGmShape
/// @param {Bool} _horizontally Bool: true, then flip horizontally. False, then flip vertically
function PolygonFlip(_shape, _horizontally)
{
	if instance_exists(_shape)
	{
		with _shape
		{
			var _len = array_length(array);
			if _horizontally
			{
				for (var i = 0; i < _len; i++;)
				{
					array[i].x = x - (array[i].x - x);
				}
			}
			else
			{
				for (var i = 0; i < _len; i++;)
				{
					array[i].y = y - (array[i].y - y);
				}
			}
			array = array_reverse(array);
			ArrayUpdate();
		}
	}
}