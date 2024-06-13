/// @desc Updates the array of the PolyGmShape
function ArrayUpdate()
{
	vertex_begin(vbuff, format);

	array_tri = PolygonToTriangles(array);
	for (var i = 0; i < array_length(array_tri); i++;)
	{
		VertexAdd(vbuff, array_tri[i], uvs, sprite, c_white, 1);
	}

	vertex_end(vbuff);
	if global.freeze vertex_freeze(vbuff);
}