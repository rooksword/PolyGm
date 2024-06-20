/// @desc Draw GUI

function PolyGmEditorDrawGUI()
{
	draw_set_font(fnt_poly);
	
	if keyboard_check(vk_lshift)
	{
		draw_sprite_tiled_ext(spr_grid, -1, -camera_get_view_x(view_camera[0]), -camera_get_view_y(view_camera[0]), global.grid_size / sprite_get_width(spr_grid), global.grid_size / sprite_get_height(spr_grid), c_white, 0.1);
	}
	
	global.bb_mousex = PosGui(mouse_xc, mouse_yc)[0];
	global.bb_mousey = PosGui(mouse_xc, mouse_yc)[1];

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	var _h = string_height("Test");
	var _y = (_h + global.bb_padding * 2) + 2;
	var i = 0;

	hover_on_button = false;
	
	#region Switch mode (edit and draw) button
	
	var _mode = "Edit";
	if state == EDITOR_STATES.DRAW _mode = "Draw";
	if state == EDITOR_STATES.BEZIER _mode = "Bezier";
	
	var _edit = new Button("Edit");
	_edit.DefineTL(global.bb_padding, global.bb_padding + (_y * i), string_width(_edit.text), _h);
	_edit.Draw();
	if _edit.Pressed()
	{
		state = EDITOR_STATES.EDIT;
	}
	if _edit.Hover() hover_on_button = true;
	
	var _draw = new Button("Draw");
	_draw.DefineTL(global.bb_padding * 2 + (_edit.x1 - _edit.x0), global.bb_padding + (_y * i), string_width(_draw.text), _h);
	_draw.Draw();
	if _draw.Pressed()
	{
		state = EDITOR_STATES.DRAW;
	}
	if _draw.Hover() hover_on_button = true;
	
	var _bez = new Button("Bezier");
	_bez.DefineTL(global.bb_padding * 3 + (_edit.x1 - _edit.x0) + (_draw.x1 - _draw.x0), global.bb_padding + (_y * i), string_width(_bez.text), _h);
	_bez.Draw();
	if _bez.Pressed()
	{
		state = EDITOR_STATES.BEZIER;
	}
	if _bez.Hover() hover_on_button = true;
	
	i += 1.5; 
	
	#endregion
	
	#region Layer buttons
	
	var _layer_current = global.layers[layer_index];
	var _layer_real = LayerFind(_layer_current.name);
	var _vis = layer_get_visible(_layer_real);
	var _loc = _layer_current.locked;
	
	var _l0 = new Button("Layer: " + string(layer_index) + " " + string_delete(_layer_current.name, 1, 3) + " " + (_vis ? "V " : "H ") + (_loc ? "L" : "U"));
	_l0.DefineTL(global.bb_padding, global.bb_padding + (_y * i), string_width(_l0.text), _h);
	_l0.Draw();
	if _l0.Pressed()
	{
		if layer_index < array_length(global.layers) - 1 layer_index++;
		else layer_index = 0;
	}
	if _l0.PressedR()
	{
		if layer_index > 0 layer_index--;
		else layer_index = array_length(global.layers) - 1;
	}
	i++;
	if _l0.Hover() hover_on_button = true;
	
	var _l1 = new Button(_vis ? "Hide layer" : "Show layer");
	_l1.DefineTL(global.bb_padding, global.bb_padding + (_y * i), string_width(_l1.text), _h);
	_l1.Draw();
	if _l1.Pressed()
	{
		if layer_get_visible(_layer_real)
		{
			layer_set_visible(_layer_real, false);
		}
		else
		{
			layer_set_visible(_layer_real, true);
		}
	}
	i++; if _l1.Hover() hover_on_button = true;
	
	var _str = "Layer:" + string(_loc ? "Unlock" : "Lock");
	var _l2 = new Button(_str);
	_l2.DefineTL(global.bb_padding, global.bb_padding + (_y * i), string_width(_l2.text), _h);
	_l2.Draw();
	if _l2.Pressed()
	{
		_layer_current.locked = !_layer_current.locked;
	}
	i++; if _l2.Hover() hover_on_button = true;
	
	var _l3 = new Button("Layer colour: " + ColourToName(_layer_current.colour) + ", " + string(_layer_current.alpha));
	_l3.DefineTL(global.bb_padding, global.bb_padding + (_y * i), string_width(_l3.text), _h);
	_l3.Draw();
	if _l3.Pressed()
	{
		_layer_current.colour =  make_color_rgb(
			get_integer("Red (0 - 255):", colour_get_red(_layer_current.colour)),
			get_integer("Green (0 - 255):", colour_get_green(_layer_current.colour)),
			get_integer("Blue (0 - 255):", colour_get_blue(_layer_current.colour))
		);
		_layer_current.alpha = get_integer("Alpha (0 - 255):", _layer_current.alpha);
	}
	i += 1.5; if _l3.Hover() hover_on_button = true;
	
	if _l0.Hover()
	or _l1.Hover()
	or _l2.Hover()
	or _l3.Hover()
	{
		with PolyGmShape
		{
			layer_hover = _layer_real != layer ? 0.25 : 1;
		}
		with PolyGmBezier
		{
			layer_hover = _layer_real != layer ? 0.25 : 1;
		}
		hover_on_button = true;
	}
	else
	{
		with PolyGmShape layer_hover = 1;	
		with PolyGmBezier layer_hover = 1;	
	}
	
	#endregion
	
	#region Sprite and colour
	
	var _b = new Button("Change sprite: " + sprite_get_name(global.textures[spr_index]));
	_b.DefineTL(global.bb_padding, global.bb_padding + (_y * i), string_width(_b.text), _h);
	_b.Draw();
	if _b.Pressed()
	{
		if spr_index < array_length(global.textures) - 1 spr_index++;
		else spr_index = 0;
		
		if shape_selected != -1
		{
			var _tex = global.textures[spr_index];
			with shape_selected PolygonSprite(_tex);
		}
	}
	i++; if _b.Hover() hover_on_button = true;
			
	var _b = new Button("Shape colour: " + ColourToName(colour) + ", " + string(alpha));
	_b.DefineTL(global.bb_padding, global.bb_padding + (_y * i), string_width(_b.text), _h);
	_b.Draw();
	if _b.Pressed()
	{
		colour = make_color_rgb(
			get_integer("Red (0 - 255):", colour_get_red(colour)),
			get_integer("Green (0 - 255):", colour_get_green(colour)),
			get_integer("Blue (0 - 255):", colour_get_blue(colour))
		);
		
		alpha = get_integer("Alpha (0 - 255):", alpha);
		
		if shape_selected != -1
		{
			var _col = colour;
			var _alp = alpha;
			with shape_selected
			{
				colour = _col;
				alpha = _alp;
			}
		}
	}
	i += 1.5; if _b.Hover() hover_on_button = true;
	
	#endregion
	
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
					PolygonDuplicate(shape_selected, 100, 0);
					shape_selected = -1;
				}
				i++; if _b.Hover() hover_on_button = true;
			
				var _b = new Button("Rotate shape");
				_b.DefineTL(global.bb_padding, global.bb_padding + (_y * i), string_width(_b.text), _h);
				_b.Draw();
				if _b.Down()
				{
					with shape_selected PolygonRotate(-2);
				}
			
				if _b.DownR()
				{
					with shape_selected PolygonRotate(2);
				}
				i++; if _b.Hover() hover_on_button = true;
			
				var _b = new Button("Flip shape horizontally");
				_b.DefineTL(global.bb_padding, global.bb_padding + (_y * i), string_width(_b.text), _h);
				_b.Draw();
				if _b.Pressed()
				{
					PolygonFlip(shape_selected, false);
					
				}
				i++; if _b.Hover() hover_on_button = true;
			
				var _b = new Button("Flip shape vertically");
				_b.DefineTL(global.bb_padding, global.bb_padding + (_y * i), string_width(_b.text), _h);
				_b.Draw();
				if _b.Pressed()
				{
					PolygonFlip(shape_selected, false);
				}
				i++; if _b.Hover() hover_on_button = true;
			}
			break;
			
		case EDITOR_STATES.DRAW:
			var _str = "Freehand: " + string(global.auto_draw);
			if global.auto_draw == 0 _str = "Point-by-point"
			var _b = new Button(_str);
			_b.DefineTL(global.bb_padding, global.bb_padding + (_y * i), string_width(_b.text), _h);
			_b.Draw();
			if _b.Pressed()
			{
				if global.auto_draw == 0 global.auto_draw = get_integer("Distance between points:", 64);
				else global.auto_draw = 0;
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