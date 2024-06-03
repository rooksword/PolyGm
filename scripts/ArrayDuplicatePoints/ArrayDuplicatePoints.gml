function ArrayDuplicatePoints(_dest, _src)
{
	_dest = [];
	for (var i = 0; i < array_length(_src); i++;)
	{
		var _p = _src[i];
		array_push(_dest, new Vec2(_p.x, _p.y));
	}
}