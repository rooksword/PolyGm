/// @desc Looks through the global array of layers to see if the layer name supplied is a real layer
/// @param {string} _name The name of the layer
/// @returns {Struct} The struct of the layer or -1 if not found
function LayerFindStruct(_name)
{
	for (var i = 0; i < array_length(global.layers); i++;)
	{
		var _lay = global.layers[i];
		if _lay.name == _name
		{
			return _lay;	
		}
	}
	return -1;
}