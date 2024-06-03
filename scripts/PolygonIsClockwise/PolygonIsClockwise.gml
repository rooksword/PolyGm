function PolygonIsCounterclockwise(_arr)
{
	var _cw = 0;
	for (var i = 0; i < array_length(_arr); i++;)
	{
		var _p = _arr[i];
		var _q = 0;
		if i < array_length(_arr) - 1
		{
			_q = _arr[i + 1];
		}
		else
		{
			_q = _arr[0];
		}
			
		_cw += (_q.x - _p.x) * (_q.y + _p.y);
	}
	return (_cw < 0);
}