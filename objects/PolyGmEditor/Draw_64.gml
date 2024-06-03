/// @desc Draw GUI

global.bb_mousex = device_mouse_x_to_gui(0);
global.bb_mousey = device_mouse_y_to_gui(0);

draw_set_halign(fa_left);
draw_set_valign(fa_top);

var _y = 48;
var i = 0;

hover_on_button = false;

switch state
{
	case EDITOR_STATES.EDIT:
		var _b = new Button("Mode = EDIT");
		_b.DefineTL(32, 32 + (_y * i), string_width(_b.text), string_height(_b.text));
		_b.Draw();
		if _b.Pressed()
		{
			state = EDITOR_STATES.DRAW;	
		}
		i++; if _b.Hover() hover_on_button = true;
		
		if shape_selected != -1
		{
			var _b = new Button("Delete shape");
			_b.DefineTL(32, 32 + (_y * i), string_width(_b.text), string_height(_b.text));
			_b.Draw();
			if _b.Pressed()
			{
				instance_destroy(shape_selected);
				shape_selected = -1;
			}
			i++; if _b.Hover() hover_on_button = true;
			
			var _b = new Button("Duplicate shape");
			_b.DefineTL(32, 32 + (_y * i), string_width(_b.text), string_height(_b.text));
			_b.Draw();
			if _b.Pressed()
			{
				var _new_shape = instance_create_layer(0, 0, "Instances", PolyGmShape);	
				_new_shape.array = [];
				for (var j = 0; j < array_length(shape_selected.array); j++;)
				{
					var _p = shape_selected.array[j];
					array_push(_new_shape.array, new Vec2(_p.x, _p.y));
				}
				with _new_shape
				{
					drawing = false;
					for (var j = 0; j < array_length(array); j++;)
					{
						var _point = array[j];
						_point.x += 100;
					}
					ArrayUpdate();
					vbuff_empty = false;
				}
				shape_selected = -1;
			}
			i++; if _b.Hover() hover_on_button = true;
			
			var _b = new Button("Rotate shape");
			_b.DefineTL(32, 32 + (_y * i), string_width(_b.text), string_height(_b.text));
			_b.Draw();
			if _b.Down()
			{
				with shape_selected
				{
					PolygonRotate(-2);
				}
			}
			
			if _b.DownR()
			{
				with shape_selected
				{
					PolygonRotate(2);
				}
			}
			i++; if _b.Hover() hover_on_button = true;
		}
		break;
	case EDITOR_STATES.DRAW:
		var _b = new Button("Mode = DRAW");
		_b.DefineTL(32, 32 + (_y * i), string_width(_b.text), string_height(_b.text));
		_b.Draw();
		if _b.Pressed()
		{
			state = EDITOR_STATES.EDIT;	
		}
		i++; if _b.Hover() hover_on_button = true;
	
		var _b = new Button("Auto draw = " + string(auto_draw));
		_b.DefineTL(32, 32 + (_y * i), string_width(_b.text), string_height(_b.text));
		_b.Draw();
		if _b.Pressed()
		{
			if auto_draw == 0 auto_draw = get_integer("Distance between points:", 64);
			else auto_draw = 0;
		}
		i++; if _b.Hover() hover_on_button = true;
		break;
}

var _select = false;
with PolyGmShape
{
	if mouse_over_shape or hover_handle != -1 _select = true;	
}

if !_select and !hover_on_button and shape_selected != -1 and mouse_check_button_pressed(mb_left)
{
	shape_selected = -1;	
}