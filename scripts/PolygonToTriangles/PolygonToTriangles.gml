function PolygonToTriangles(_polygon)
{
	var _polygon_size, _triangles, _points, _poly_x, _poly_y, _good;
	var i, j, _n, _p, _a, _b, _c, _x0, _y0, _x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4;
	_polygon_size = array_length(_polygon);
	_triangles = [];
	_points = [];
	_poly_x = [];
	_poly_y = [];

	for (var _point = 0; _point < _polygon_size; _point++;)
	{
		array_push(_poly_x, _polygon[_point].x);
		array_push(_poly_y, _polygon[_point].y);
	}

	// 1. For (_n - 3) vertices
	_n = _polygon_size;
	for (_n = _polygon_size; _n > 3; _n -= 1)
	{
		//  a. Select first point (random)    
		_points = [];
		for (_p = 0; _p < _n; _p += 1) array_push(_points, _p);
		repeat(_p)
		{
			i = floor(random(array_length(_points)));
			_a = array_get(_points, i);
			array_delete(_points, i, 1);

			//  b. Pick the next two points
			_b = (_a + 1) mod _n;
			_c = (_a + 2) mod _n;

			//  c. Make a triangle with the selected points
			_x0 = array_get(_poly_x, _a);
			_y0 = array_get(_poly_y, _a);
			_x1 = array_get(_poly_x, _b);
			_y1 = array_get(_poly_y, _b);
			_x2 = array_get(_poly_x, _c);
			_y2 = array_get(_poly_y, _c);

			//  d. If triangle is counter-clockwise...
			if ((_x1 - _x0) * (_y2 - _y0) + (_y0 - _y1) * (_x2 - _x0) < 0)
			{
				_good = true;
				//  ...and if triangle has no vertices within it...
				for (i = 0; i < _n; i += 1)
				{
					if ((i != _a) && (i != _b) && (i != _c))
					{
						_x3 = array_get(_poly_x, i);
						_y3 = array_get(_poly_y, i);
						if (point_in_triangle(_x3, _y3, _x0, _y0, _x1, _y1, _x2, _y2))
						{
							_good = false;
							break;
						}
						//  ...and if the new edge has no other edges crossing it...
						j = (i + 1) mod _n;
						if ((j != _a) && (j != _b) && (j != _c))
						{
							_x4 = array_get(_poly_x, j);
							_y4 = array_get(_poly_y, j);

							if (LinesIntersect(_x0, _y0, _x2, _y2, _x3, _y3, _x4, _y4, true) != 0)
							{
								_good = false;
								break;
							}
						}
					}
				}

				//  e.  ...then add the triangle to list and remove the unshared vertex
				if (_good)
				{
					array_push(_triangles, new Vec2(_x0, _y0));
					array_push(_triangles, new Vec2(_x1, _y1));
					array_push(_triangles, new Vec2(_x2, _y2));
					array_delete(_poly_x, _b, 1);
					array_delete(_poly_y, _b, 1);
					break;
				}
			}
		}
	}

	//  2. There are only three vertices left, so add the final triangle to the list
	array_push(_triangles, new Vec2(_poly_x[0], _poly_y[0]));
	array_push(_triangles, new Vec2(_poly_x[1], _poly_y[1]));
	array_push(_triangles, new Vec2(_poly_x[2], _poly_y[2]));

	return _triangles;
}