/// @desc Moves a point (Vec2) of a polygon
/// @param {Struct} _p A point (Vec2)
/// @param {real} _x Pixels to horizontally offset the point by
/// @param {real} _y Pixels to vertically offset the point by
function PolygonPointMove(_p, _x, _y)
{
	_p.x += _x;
	_p.y += _y;
}