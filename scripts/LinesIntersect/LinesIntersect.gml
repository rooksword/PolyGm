/// @desc Takes two lines (x1, y1 to x2, y2 and x3, y3 to x4, y4) and returns if they are intersecting
/// @param {real} _x1 X1 of line 1
/// @param {real} _y1 Y1 of line 1
/// @param {real} _x2 X2 of line 1
/// @param {real} _y2 Y2 of line 1
/// @param {real} _x3 X1 of line 2
/// @param {real} _y3 Y1 of line 2
/// @param {real} _x4 X2 of line 2
/// @param {real} _y4 Y2 of line 2
/// @param {BooL} _segment Are the lines segments
/// @returns {real} Are the lines intersecting
/// @url https://www.gmlscripts.com/script/lines_intersect
function LinesIntersect(_x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4, _segment)
{
	/*
	
	Adapted from GMLscripts.com
	
	Returns a vector multiplier (t) for an intersection on the
	first line. A value of (0 < t <= 1) indicates an intersection 
	within the line segment, a value of 0 indicates no intersection, 
	other values indicate an intersection beyond the endpoints.
	
	    x1,y1,x2,y2     1st line segment
	    x3,y3,x4,y4     2nd line segment
	    segment         If true, confine the test to the line segments.
	
	By substituting the return value (t) into the parametric form
	of the first line, the point of intersection can be determined.
	eg. x = x1 + t * (x2 - x1)
	    y = y1 + t * (y2 - y1)
	
	License: GMLscripts.com/license
	
	*/
	
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