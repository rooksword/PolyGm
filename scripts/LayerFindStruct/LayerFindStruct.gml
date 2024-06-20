/// @desc Looks through the global array of layers to see if the layer name supplied is a real layer
/// @param {string} _name The name of the layer
/// @returns {Struct} The struct of the layer or -1 if not found
function LayerFindStruct(_name)
{
	var _arr = global.layers;
	var _len = array_length(_arr);
	for (var i = 0; i < _len; i++;)
	{
		var _lay = _arr[i];
		if _lay.name == _name
		{
			return _lay;	
		}
	}
	return -1;
}