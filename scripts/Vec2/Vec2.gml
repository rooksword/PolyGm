function Vec2(_x = 0, _y = 0) constructor
{
	x = _x;
	y = _y;
	
	function Add(_v)
	{
		x += _v.x;
		y += _v.y;
	}
	
	function AddT(_t)
	{
		x += _t;
		y += _t;
	}
	
	function Multiply(_v)
	{
		x *= _v.x;
		y *= _v.y;
	}
	
	function MultiplyT(_t)
	{
		x *= _t
		y *= _t;
	}
	
	function Lerp(_v, _acc)
	{
		x = lerp(x, _v.x, _acc);
		y = lerp(y, _v.y, _acc);
	}
	
	function Rotate(_a)
	{
		var _xc = x * cos(_a);
		var _ys = y * sin(_a);
		var _xs = x * sin(_a);
		var _yc = y * cos(_a);
		
		x = _xc - _ys;
		y = _xs + _yc;
	}
	
	function Lengthdir(_dir)
	{
		x = lengthdir_x(x, _dir);
		y = lengthdir_y(y, _dir);
	}
	
	function Magnitude()
	{
		return sqrt(sqr(x) + sqr(y));	
	}
}