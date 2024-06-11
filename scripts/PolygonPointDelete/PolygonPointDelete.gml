function PolygonPointDelete(_p)
{
	var _index = -1;
	for (var i = 0; i < array_length(array); i++;)
	{
		if array[i] == _p
		{
			_index = i;	
		}
	}
	
	if _index != -1
	{
		array_delete(array, _index, 1);
		ArrayUpdate();
	}
}