// Looks through all room layers and returns layer id of layer with matching name

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
}