/// @desc Create save file

global.layers = [];

if file_exists(global.save_directory + "layers.sav")
{
	var _buffer = buffer_load(global.save_directory + "layers.sav");
	var _string = buffer_read(_buffer, buffer_string);
	buffer_delete(_buffer);
	
	global.layers = json_parse(_string);
}
else
{
	var _layers = layer_get_all();
	for (var i = 0; i < array_length(_layers); i++;)
	{
		var _lay = _layers[i];
		array_push(global.layers, {
			name: layer_get_name(_lay),
			locked: false,
			visible: true,
			colour: c_white,
			alpha: 255
		});
	}
}

instance_create_layer(0, 0, "GUI", PolyGmEditor);
	
if file_exists(global.save_directory + "polygons.sav")
{
	var _buffer = buffer_load(global.save_directory + "polygons.sav");
	var _string = buffer_read(_buffer, buffer_string);
	buffer_delete(_buffer);
	
	var _load_data = json_parse(_string);
	
	while array_length(_load_data) > 0
	{
		var _load_entity = array_pop(_load_data);
		var _inst = instance_create_layer(0, 0, _load_entity.layer, PolyGmShape);
		with _inst
		{
			drawing = false;
			vbuff_empty = false;
			
			array = _load_entity.array;
			sprite = _load_entity.sprite;
			texture = sprite_get_texture(sprite, frame);
			uvs     = sprite_get_uvs(sprite, frame);
			colour = _load_entity.colour;
			alpha = _load_entity.alpha;
			
			PolygonUpdate();
			ArrayUpdate();
		}
	}
}