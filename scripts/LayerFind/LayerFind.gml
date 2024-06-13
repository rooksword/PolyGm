/// @desc Looks through all the layers to see if the layer name supplied is a real layer
/// @param {string} _name The name of the layer
/// @returns {Id.Layer} The ID of the layer or -1 if not found

function LayerFind(_name)
{
	var _layers = layer_get_all();
	for (var i = 0; i < array_length(_layers); i++;)
	{
		var _lay = _layers[i];
		if layer_get_name(_lay) == _name
		{
			return _lay;	
		}
	}
	return -1;
}