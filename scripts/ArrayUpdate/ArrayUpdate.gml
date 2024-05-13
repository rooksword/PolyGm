function ArrayUpdate()
{
	vertex_begin(vbuff, format);

	for (var i = 0; i < array_length(array); i++;)
	{
		var _array = ArrayFidelity(array[i], fidelity);
		_array = PolygonToTriangles(_array);
		for (var j = 0; j < array_length(_array); j++;)
		{
			VertexAdd(vbuff, _array[j], uvs, sprite, c_white, 1);
		}
	}

	vertex_end(vbuff);
	//vertex_freeze(vbuff);
}