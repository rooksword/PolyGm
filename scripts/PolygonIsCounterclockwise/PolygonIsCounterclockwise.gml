/// @desc Returns a list of triangles created from a given 2D polygon.
/// @param {array} _polygon Array of an ordered series of coordinated pairs (Vec2) defining the shape of a polygon
/// @returns {Bool} Bool: true if counter clockwise, false if clockwise
function PolygonIsCounterclockwise(_polygon)
{
	var _cw = 0;
	for (var i = 0; i < array_length(_polygon); i++;)
	{
		var _p = _polygon[i];
		var _q = (i < (array_length(_polygon) - 1)) ? _polygon[i + 1] : _polygon[0];
		_cw += (_q.x - _p.x) * (_q.y + _p.y);
	}
	return (_cw < 0);
}