function PolygonRotate(_spd)
{
	for (var i = 0; i < array_length(array); i++;)
	{
		var _p = array[i];
		var _dist = point_distance(_p.x, _p.y, center.x, center.y);
		var _dir = point_direction(_p.x, _p.y, center.x, center.y) + _spd;
					
		_p.x = center.x - dcos(_dir) * _dist;
		_p.y = center.y + dsin(_dir) * _dist;
	}
	ArrayUpdate();
}