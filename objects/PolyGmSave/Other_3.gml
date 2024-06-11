/// @desc Save

#region Save polygons

instance_activate_object(PolyGmShape);

var _saveData = [];

for (var i = 0; i < instance_number(PolyGmShape); i++;)
{
	var _inst = instance_find(PolyGmShape, i);
	var _saveEntity = {
		array: _inst.array,
		sprite: _inst.sprite,
		colour: _inst.colour,
		alpha: _inst.alpha,
		layer: _inst.layer
	};
	array_push(_saveData, _saveEntity);
}

// Convert data to JSON string and save it via a buffer

var _string = json_stringify(_saveData);
var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
buffer_write(_buffer, buffer_string, _string);
buffer_save(_buffer, global.save_directory + "polygons.sav");
buffer_delete(_buffer);

#endregion

#region Save layers

_saveData = [];

for (var i = 0; i < array_length(global.layers); i++;)
{
	var _saveEntity = global.layers[i];
	array_push(_saveData, _saveEntity);
}

// Convert data to JSON string and save it via a buffer

_string = json_stringify(_saveData);
_buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
buffer_write(_buffer, buffer_string, _string);
buffer_save(_buffer, global.save_directory + "layers.sav");
buffer_delete(_buffer);

#endregion