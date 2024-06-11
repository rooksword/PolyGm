// Looks through array of layer structs and returns layer id of layer with matching name

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
}