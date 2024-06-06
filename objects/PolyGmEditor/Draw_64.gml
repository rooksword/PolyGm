/// @desc Draw GUI

function PolyGmEditorDrawGUI()
{
	global.bb_mousex = PosGui(mouse_xc, mouse_yc)[0];
	global.bb_mousey = PosGui(mouse_xc, mouse_yc)[1];

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	var _y = 48;
	var i = 0;

	hover_on_button = false;

	switch state
	{
		case EDITOR_STATES.EDIT:
			var _b = new Button("Mode: EDIT");
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
			
				var _b = new Button("Flip shape horizontally");
				_b.DefineTL(32, 32 + (_y * i), string_width(_b.text), string_height(_b.text));
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
				_b.DefineTL(32, 32 + (_y * i), string_width(_b.text), string_height(_b.text));
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
				_b.DefineTL(32, 32 + (_y * i), string_width(_b.text), string_height(_b.text));
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
				_b.DefineTL(32, 32 + (_y * i), string_width(_b.text), string_height(_b.text));
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
			var _b = new Button("Mode: DRAW");
			_b.DefineTL(32, 32 + (_y * i), string_width(_b.text), string_height(_b.text));
			_b.Draw();
			if _b.Pressed()
			{
				state = EDITOR_STATES.EDIT;	
			}
			i++; if _b.Hover() hover_on_button = true;
	
			var _str = "Freehand: " + string(auto_draw);
			if auto_draw == 0 _str = "Point-by-point"
			var _b = new Button(_str);
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
		draw_text(32, room_height - 32, "Middle click or press ALT to move the camera\nPress SHIFT to snap the mouse to the grid\nNumber of active shapes: "+string(instance_number(PolyGmShape)));
	}

	draw_sprite(spr_cursor, -1, global.bb_mousex, global.bb_mousey);
}

if global.draw_editor PolyGmEditorDrawGUI();