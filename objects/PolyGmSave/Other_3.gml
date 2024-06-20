/// @desc Save

#region Save objects

var _save_data = [];

for (var i = 0; i < instance_number(PolyGmObject); i++;)
{
	var _inst = instance_find(PolyGmObject, i);
	var _save_entity = {
		x: _inst.x,
		y: _inst.y,
		origin: _inst.origin,
		target: _inst.target,
		sprite_index: _inst.sprite_index,
		colour: _inst.colour,
		alpha: _inst.alpha,
		layer: _inst.layer,
		image_xscale: _inst.image_xscale,
		image_yscale: _inst.image_yscale,
		image_angle: _inst.image_angle,
		angle_speed: _inst.angle_speed,
		spd: _inst.spd,
		offset: _inst.offset
	};
	array_push(_save_data, _save_entity);
}

// Convert data to JSON string and save it via a buffer

var _string = json_stringify(_save_data);
var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
buffer_write(_buffer, buffer_string, _string);
buffer_save(_buffer, global.save_directory + "objects.sav");
buffer_delete(_buffer);

#endregion

#region Save bezier curves

instance_activate_object(PolyGmBezier);

_save_data = [];

for (var i = 0; i < instance_number(PolyGmBezier); i++;)
{
	var _inst = instance_find(PolyGmBezier, i);
	var _save_entity = {
		line: _inst.line
	};
	array_push(_save_data, _save_entity);
}

// Convert data to JSON string and save it via a buffer

_string = json_stringify(_save_data);
_buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
buffer_write(_buffer, buffer_string, _string);
buffer_save(_buffer, global.save_directory + "bezier.sav");
buffer_delete(_buffer);

#endregion

#region Save polygons

instance_activate_object(PolyGmShape);

_save_data = [];

for (var i = 0; i < instance_number(PolyGmShape); i++;)
{
	var _inst = instance_find(PolyGmShape, i);
	var _save_entity = {
		array: _inst.array,
		sprite: _inst.sprite,
		colour: _inst.colour,
		alpha: _inst.alpha,
		layer: _inst.layer
	};
	array_push(_save_data, _save_entity);
}

// Convert data to JSON string and save it via a buffer

_string = json_stringify(_save_data);
_buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
buffer_write(_buffer, buffer_string, _string);
buffer_save(_buffer, global.save_directory + "polygons.sav");
buffer_delete(_buffer);

#endregion

#region Save layers

_save_data = [];

var _len = array_length(global.layers);
for (var i = 0; i < _len; i++;)
{
	var _save_entity = global.layers[i];
	array_push(_save_data, _save_entity);
}

// Convert data to JSON string and save it via a buffer

_string = json_stringify(_save_data);
_buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
buffer_write(_buffer, buffer_string, _string);
buffer_save(_buffer, global.save_directory + "layers.sav");
buffer_delete(_buffer);

#endregion