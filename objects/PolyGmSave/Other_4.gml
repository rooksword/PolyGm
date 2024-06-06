/// @desc Create save file

instance_create_layer(0, 0, "Top", PolyGmEditor);
	
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