function LinesIntersect(_x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4, _segment)
{
	var _ua, _ub, _ud, _ux, _uy, _vx, _vy, _wx, _wy;
	_ua = 0;
	_ux = _x2 - _x1;
	_uy = _y2 - _y1;
	_vx = _x4 - _x3;
	_vy = _y4 - _y3;
	_wx = _x1 - _x3;
	_wy = _y1 - _y3;
	_ud = _vy * _ux - _vx * _uy;
	if (_ud != 0)
	{
		_ua = (_vx * _wy - _vy * _wx) / _ud;
		if _segment
		{
			_ub = (_ux * _wy - _uy * _wx) / _ud;
			if (_ua < 0 || _ua > 1 || _ub < 0 || _ub > 1)
			{
				_ua = 0;
			}
		}
	}
	return _ua;
}