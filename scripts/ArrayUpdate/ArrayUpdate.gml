function ArrayUpdate()
{
	vertex_begin(vbuff, format);

	var _array = PolygonToTriangles(array);
	for (var i = 0; i < array_length(_array); i++;)
	{
		VertexAdd(vbuff, _array[i], uvs, sprite, c_white, 1);
	}

	vertex_end(vbuff);
	//vertex_freeze(vbuff);
}