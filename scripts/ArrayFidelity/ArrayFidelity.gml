function ArrayFidelity(_array, _fidelity)
{
	var _arr = [];
	for (var i = 0; i < array_length(_array); i += _fidelity;)
	{
		array_push(_arr, _array[i]);
	}
	array_push(_arr, _array[array_length(_array) - 1]);
	return _arr;
}