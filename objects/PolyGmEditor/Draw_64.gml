/// @desc Draw GUI

function PolyGmEditorDrawGUI()
{
	if keyboard_check(vk_lshift) draw_sprite_tiled_ext(spr_grid, -1, 0, 0, global.grid_size / sprite_get_width(spr_grid), global.grid_size / sprite_get_height(spr_grid), c_white, 0.1);
	
	global.bb_mousex = PosGui(mouse_xc, mouse_yc)[0];
	global.bb_mousey = PosGui(mouse_xc, mouse_yc)[1];

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	var _h = string_height("Test");
	var _y = (_h + global.bb_padding * 2) + 2;
	var i = 0;

	hover_on_button = false;
	
	var _mode = "Edit";
	if state == EDITOR_STATES.DRAW _mode = "Draw";
	
	var _b = new Button("Mode: " + _mode);
	_b.DefineTL(global.bb_padding, global.bb_padding + (_y * i), string_width(_b.text), _h);
	_b.Draw();
	if _b.Pressed()
	{
		if state == EDITOR_STATES.EDIT state = EDITOR_STATES.DRAW;
		else state = EDITOR_STATES.EDIT;
	}
	i++; if _b.Hover() hover_on_button = true;
	
	var _l0 = new Button("Layer:" + string(layer_get_name(layers[layer_index])));
	_l0.DefineTL(global.bb_padding, global.bb_padding + (_y * i), string_width(_l0.text), _h);
	_l0.Draw();
	if _l0.Pressed()
	{
		if layer_index < array_length(layers) - 1 layer_index++;
		else layer_index = 0;
	}
	if _l0.PressedR()
	{
		if layer_index > 0 layer_index--;
		else layer_index = array_length(layers) - 1;
	}
	i++;
	if _l0.Hover() hover_on_button = true;
	
	var _l1 = new Button(layer_get_visible(layers[layer_index]) ? "Hide layer" : "Show layer");
	_l1.DefineTL(global.bb_padding, global.bb_padding + (_y * i), string_width(_l1.text), _h);
	_l1.Draw();
	if _l1.Pressed()
	{
		var _lay_id = layers[layer_index];
		if (layer_get_visible(_lay_id))
		{
			layer_set_visible(_lay_id, false);
		}
		else
		{
			layer_set_visible(_lay_id, true);
		}
	}
	i++; if _l1.Hover() hover_on_button = true;
	
	var _locked = InArray(layers[layer_index], layers_locked);
	var _str = "Layer:" + string(
			_locked ? "Unlock" : "Lock"
		);
	var _l2 = new Button(_str);
	_l2.DefineTL(global.bb_padding, global.bb_padding + (_y * i), string_width(_l2.text), _h);
	_l2.Draw();
	if _l2.Pressed()
	{
		if _locked
		{
			var _f = function(_element)
			{
			    return (_element == layers[layer_index]);
			}
			var _index = array_find_index(layers_locked, _f);
			array_delete(layers_locked, _index, 1);
		}
		else
		{
			array_push(layers_locked, layers[layer_index]);	
		}
	}
	i++; if _l2.Hover() hover_on_button = true;
	
	if _l0.Hover()
	or _l1.Hover()
	or _l2.Hover()
	{
		with PolyGmShape
		{
			if other.layers[other.layer_index] != layer
			{
				layer_hover = 0.25;
			}
			else
			{
				layer_hover = 1;	
			}
		}
		hover_on_button = true;
	}
	else
	{
		with PolyGmShape layer_hover = 1;	
	}
	
	switch state
	{
		case EDITOR_STATES.EDIT:
			if shape_selected != -1
			{
				var _b = new Button("Delete shape");
				_b.DefineTL(global.bb_padding, global.bb_padding + (_y * i), string_width(_b.text), _h);
				_b.Draw();
				if _b.Pressed()
				{
					instance_destroy(shape_selected);
					shape_selected = -1;
				}
				i++; if _b.Hover() hover_on_button = true;
			
				var _b = new Button("Duplicate shape");
				_b.DefineTL(global.bb_padding, global.bb_padding + (_y * i), string_width(_b.text), _h);
				_b.Draw();
				if _b.Pressed()
				{
					var _new_shape = instance_create_layer(0, 0, shape_selected.layer, PolyGmShape);	
					_new_shape.array = [];
					for (var j = 0; j < array_length(shape_selected.array); j++;)
					{
						var _p = shape_selected.array[j];
						array_push(_new_shape.array, new Vec2(_p.x, _p.y));
					}
					with _new_shape
					{
						sprite  = other.shape_selected.sprite;
						texture = sprite_get_texture(sprite, frame);
						uvs     = sprite_get_uvs(sprite, frame);
						
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
				_b.DefineTL(global.bb_padding, global.bb_padding + (_y * i), string_width(_b.text), _h);
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
			
				var _b = new Button("Flip shape horizontally");
				_b.DefineTL(global.bb_padding, global.bb_padding + (_y * i), string_width(_b.text), _h);
				_b.Draw();
				if _b.Pressed()
				{
					with shape_selected
					{
						for (var i = 0; i < array_length(array); i++;)
						{
					        array[i].x = x - (array[i].x - x);
					    }
						array = array_reverse(array);
						ArrayUpdate();	
					}
				}
				i++; if _b.Hover() hover_on_button = true;
			
				var _b = new Button("Flip shape vertically");
				_b.DefineTL(global.bb_padding, global.bb_padding + (_y * i), string_width(_b.text), _h);
				_b.Draw();
				if _b.Pressed()
				{
					with shape_selected
					{
						for (var i = 0; i < array_length(array); i++;)
						{
					        array[i].y = y - (array[i].y - y);
					    }
						array = array_reverse(array);
						ArrayUpdate();	
					}
				}
				i++; if _b.Hover() hover_on_button = true;
			
				var _b = new Button("Change sprite");
				_b.DefineTL(global.bb_padding, global.bb_padding + (_y * i), string_width(_b.text), _h);
				_b.Draw();
				if _b.Pressed()
				{
					with shape_selected
					{
						if spr_index < array_length(global.textures) - 1 spr_index++;
						else spr_index = 0;
						sprite = global.textures[spr_index];
						texture = sprite_get_texture(sprite, frame);
						uvs     = sprite_get_uvs(sprite, frame);
						ArrayUpdate();
					}
				}
				i++; if _b.Hover() hover_on_button = true;
			
				var _b = new Button("Change colour");
				_b.DefineTL(global.bb_padding, global.bb_padding + (_y * i), string_width(_b.text), _h);
				_b.Draw();
				if _b.Pressed()
				{
					with shape_selected
					{
						colour = make_color_rgb(
							get_integer("Red (0 - 255):", 0),
							get_integer("Green (0 - 255):", 0),
							get_integer("Blue (0 - 255):", 0)
						);
						alpha = get_integer("Alpha (0 - 255):", 0);
					}
				}
				i++; if _b.Hover() hover_on_button = true;
			}
			break;
		case EDITOR_STATES.DRAW:
			var _str = "Freehand: " + string(auto_draw);
			if auto_draw == 0 _str = "Point-by-point"
			var _b = new Button(_str);
			_b.DefineTL(global.bb_padding, global.bb_padding + (_y * i), string_width(_b.text), _h);
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
		if mouse_over_shape or hover_point != -1 or hover_handle != -1 or mouse_point != -1 _select = true;	
	}

	if shape_selected != -1 // Shape is selected
	and !hover_on_button // Not over button
	and !_select // Not interacting with shape
	and mouse_check_button_pressed(mb_left) // LMB pressed
	{
		shape_selected = -1;	
	}

	if global.info_text
	{
		draw_set_colour(c_white);
		draw_set_halign(fa_left);
		draw_set_valign(fa_bottom);
		draw_text(32, window_get_height() - 32, "Middle click or press ALT to move the camera\nPress SHIFT to snap the mouse to the grid\nNumber of active shapes: "+string(instance_number(PolyGmShape)));
	}

	draw_sprite(spr_cursor, -1, global.bb_mousex, global.bb_mousey);
}

if global.draw_editor PolyGmEditorDrawGUI();