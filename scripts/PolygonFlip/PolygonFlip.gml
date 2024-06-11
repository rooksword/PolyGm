function PolygonFlip(_shape, _horizontally)
{
	with _shape
	{
		if _horizontally
		{
			for (var i = 0; i < array_length(array); i++;)
			{
				array[i].x = x - (array[i].x - x);
			}
		}
		else
		{
			for (var i = 0; i < array_length(array); i++;)
			{
				array[i].y = y - (array[i].y - y);
			}
		}
		array = array_reverse(array);
		ArrayUpdate();
	}
}