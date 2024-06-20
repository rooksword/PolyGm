/*
Lerp is a value from 0-1 to find on the line between p0 and p3
p1 and p2 are the control points

returns array (x,y)
*/
function BezierPointFind(_t, _p0, _p1, _p2, _p3)
{
	//Precalculated power math
	var _tt  = _t  * _t;
	var _ttt = _tt * _t;
	var _u   = 1  - _t; //Inverted
	var _uu  = _u  * _u;
	var _uuu = _uu * _u;

	//Calculate the point
	var _px =       _uuu * _p0.x; //first term
	var _py =       _uuu * _p0.y;
	_px += 3 * _uu *  _t * _p1.x; //second term
	_py += 3 * _uu *  _t * _p1.y;
	_px += 3 * _u  * _tt * _p2.x; //third term 
	_py += 3 * _u  * _tt * _p2.y;
	_px +=          _ttt * _p3.x; //fourth term
	_py +=          _ttt * _p3.y;

	//Pack into an array
	return new Vec2(_px, _py);
}