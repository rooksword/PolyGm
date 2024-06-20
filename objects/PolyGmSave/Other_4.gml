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
	var _len = array_length(_layers);
	for (var i = 0; i < _len; i++;)
	{
		var _lay = _layers[i];
		var _name = layer_get_name(_lay);
		if string_copy(_name, 1, 3) == "PGM"
		{
			array_push(global.layers, {
				name: _name,
				locked: false,
				visible: true,
				colour: c_white,
				alpha: 255
			});
		}
	}
}

instance_create_layer(0, 0, "GUI", PolyGmEditor);
instance_create_layer(0, 0, "PGMTop", PolyGmShapeDraw);	

if file_exists(global.save_directory + "bezier.sav")
{
	var _buffer = buffer_load(global.save_directory + "bezier.sav");
	var _string = buffer_read(_buffer, buffer_string);
	buffer_delete(_buffer);
	
	var _load_data = json_parse(_string);
	
	while array_length(_load_data) > 0
	{
		var _load_entity = array_pop(_load_data);
		var _inst = instance_create_layer(0, 0, "PGMBezier", PolyGmBezier);
		with _inst
		{
			line = _load_entity.line;
		}
		array_push(PolyGmShapeDraw.shapes, _inst);
	}
}

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
			PolygonSprite(_load_entity.sprite);
			colour = _load_entity.colour;
			alpha = _load_entity.alpha;
			
			PolygonUpdate();
		}
		array_push(PolyGmShapeDraw.shapes, _inst);
	}
}

if file_exists(global.save_directory + "objects.sav")
{
	var _buffer = buffer_load(global.save_directory + "objects.sav");
	var _string = buffer_read(_buffer, buffer_string);
	buffer_delete(_buffer);
	
	var _load_data = json_parse(_string);
	
	while array_length(_load_data) > 0
	{
		var _load_entity = array_pop(_load_data);
		var _inst = instance_create_layer(_load_entity.x, _load_entity.y, _load_entity.layer, PolyGmObject);
		with _inst
		{
			sprite_index = _load_entity.sprite_index;
			colour  = _load_entity.colour;
			alpha  = _load_entity.alpha;
			image_xscale = _load_entity.image_xscale;
			image_yscale = _load_entity.image_yscale;
			image_angle  = _load_entity.image_angle;
			angle_speed  = _load_entity.angle_speed;
			spd          = _load_entity.spd;
			offset		 = _load_entity.offset;
			origin       = _load_entity.origin;
			target       = _load_entity.target;
		}
		array_push(PolyGmShapeDraw.shapes, _inst);
	}
}

array_sort(PolyGmShapeDraw.shapes, function(_elm1, _elm2)
{
    return _elm2.depth - _elm1.depth;
});