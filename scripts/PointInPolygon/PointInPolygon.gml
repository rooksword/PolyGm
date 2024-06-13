/// @desc Returns whether or not the point is inside a polygon
/// @param {real} _x X position to check
/// @param {real} _y Y position to check
/// @param {array} _polygon Array containing a triangle list which represents the polygon
/// @returns {Bool} Whether or not the point is inside a polygon
function PointInPolygon(_x, _y, _polygon)
{
	var _inside = false;
  
	for (var i = 0; i < array_length(_polygon); i += 3;)
	{
		var _a = _polygon[i];
		var _b = _polygon[i + 1];
		var _c = _polygon[i + 2];
		
		if point_in_triangle(_x, _y, _a.x, _a.y, _b.x, _b.y, _c.x, _c.y) _inside = true;
	}
	
	return _inside;
}