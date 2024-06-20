/// @desc Draw all shapes

var _shape_colour = colour;
shader_set(sh_colour);
var _len = array_length(shapes);
for (var i = 0; i < _len; i++;)
{
	var _inst = shapes[i];
	with _inst
	{
		switch object_index
		{
			case PolyGmShape:
				if vbuff_empty == false
				{
					var _lay = LayerFindStruct(layer_get_name(layer));
	
					var _darken =
						((mouse_over_shape and !PolyGmEditor.shape_selected == id)
						or (hover_shape and moving_point == -1)) * (255 / 3);
	
					var _colour = [colour_get_red(colour), colour_get_green(colour), colour_get_blue(colour), alpha];
					_colour[0] -= _darken;
					_colour[1] -= _darken;
					_colour[2] -= _darken;
		
					_colour[0] = (_colour[0] * colour_get_red(_lay.colour)) / 255;
					_colour[1] = (_colour[1] * colour_get_green(_lay.colour)) / 255;
					_colour[2] = (_colour[2] * colour_get_blue(_lay.colour)) / 255;
					_colour[3] = (_colour[3] * _lay.alpha) / 255;
	
					var _new = [_colour[0] / 255, _colour[1] / 255, _colour[2] / 255, (_colour[3] / 255) * layer_hover];
					if _shape_colour != _new
					{
						shader_set_uniform_f_array(shader_get_uniform(sh_colour, "colour"), _new);
						_shape_colour = _new;
					}
					vertex_submit(vbuff, pr_trianglelist, texture);
				}
				break;
			case PolyGmBezier:
				var _lay = LayerFindStruct(layer_get_name(layer));
				var _colour = [colour_get_red(_lay.colour), colour_get_green(_lay.colour), colour_get_blue(_lay.colour), _lay.alpha];
			
				var _new = [_colour[0] / 255, _colour[1] / 255, _colour[2] / 255, (_colour[3] / 255) * layer_hover];
				if _shape_colour != _new
				{
					shader_set_uniform_f_array(shader_get_uniform(sh_colour, "colour"), _new);
					_shape_colour = _new;
				}
				BezierDraw();
				break;
		}
	}
}
shader_reset();

with PolyGmShape ShapeDrawDebug();