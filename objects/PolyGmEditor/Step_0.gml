/// @desc Create PolyGmShape

if keyboard_check_pressed(vk_f11) window_set_fullscreen(!window_get_fullscreen());
surface_resize(application_surface, window_get_width(), window_get_height());

#region Snap mouse to grid

var _s = keyboard_check(vk_lshift) ? global.grid_size : 1;
mouse_xc = floor(mouse_x / _s) * _s;
mouse_yc = floor(mouse_y / _s) * _s;

var _m = PosGui(mouse_xc, mouse_yc);

#endregion

active = not is_mouse_over_debug_overlay();

if !active window_set_cursor(cr_arrow);
else window_set_cursor(cr_none);

var _len = array_length(global.layers);
for (var i = 0; i < _len; i++;)
{
	var _lay = global.layers[i];
	var _lay_real = LayerFind(_lay.name);
	layer_set_visible(_lay_real, _lay.visible);
}

if shape_selected != -1
{
	if not dbg_section_exists(shape_dbgsection)
	{
		dbg_view_delete(dbgview);
		dbgview = dbg_view("PolyGmEditor", visible, 0, 18, 300, display_get_height() - 18);
		DBGSettings();
		DBGShape();
		if shape_selected.object_index == PolyGmObject DBGObject();
		DBGLayers();
		DBGInformation();
	}
}
else
{
	if dbg_section_exists(shape_dbgsection) dbg_section_delete(shape_dbgsection);
	if dbg_section_exists(object_dbgsection) dbg_section_delete(object_dbgsection);
}

if active
{
	switch state
	{
		#region BEZIER
		case EDITOR_STATES.BEZIER:
			var _can_create = true;
			with PolyGmBezier
			{
				if point_hover != -1
				or point_hold != -1
				{
					_can_create = false;	
				}
			}
		
			if !hover_on_button and _can_create and mouse_check_button_pressed(mb_left)
			{
				var _inst = instance_create_layer(mouse_xc, mouse_yc, "PGMBezier", PolyGmBezier);	
				array_push(PolyGmShapeDraw.shapes, _inst);
			}
			break;
		#endregion
		#region DRAW POLY
		case EDITOR_STATES.DRAW_POLY:
			var _can_draw = true;
			with PolyGmShape
			{
				if drawing
				or hover_shape == true
				or hover_point != -1
				or hover_handle != -1
				or mouse_point != -1
				{
					_can_draw = false;
				}
			}
		
			if !hover_on_button and _can_draw and mouse_check_button_pressed(mb_left)
			{
				PolygonCreate(mouse_xc, mouse_yc, LayerFind(global.layers[layer_index].name), colour, alpha, global.textures[spr_index]);
			}
			break;
		#endregion
		#region EDIT POLY
		case EDITOR_STATES.EDIT_POLY:
			if mouse_check_button_pressed(mb_left)
			{
				var _can_draw = -1;
				with PolyGmShape
				{
					if drawing
					or hover_shape == true
					or hover_point != -1
					or hover_handle != -1
					or mouse_point != -1
					{
						_can_draw = id;
					}
				}
			
				if _can_draw != -1
				{
					shape_selected = _can_draw;	
				}
				else if !hover_on_button
				{
					selection = [];
					select_array = [];
					state = EDITOR_STATES.SELECT;
					array_push(selection, new Vec2(mouse_xc, mouse_yc));
				}
			}
			break;
		#endregion
		#region SELECT
		case EDITOR_STATES.SELECT:
			array_push(selection, new Vec2(mouse_xc, mouse_yc));

			if mouse_check_button_released(mb_left)
			{
				if !PolygonIsCounterclockwise(selection) selection = array_reverse(selection);
				var _selection_tri = PolygonToTriangles(selection);
			
				var _select_array = select_array;
				
				with PolyGmShape
				{
					if !locked
					{
						var _len = array_length(array);
						for (var i = 0; i < _len; i++;)
						{
							var _p = array[i];
				
							if PointInPolygon(_p.x, _p.y, _selection_tri)
							{
								array_push(_select_array, _p);
							}
						}
					}
				}
			
				if array_length(select_array) == 0 state = EDITOR_STATES.EDIT_POLY;
				else state = EDITOR_STATES.EDIT_SELECT;
			}
			break;
		#endregion
		#region EDIT SELECT
		case EDITOR_STATES.EDIT_SELECT:
			var _len = array_length(select_array);
			for (var i = 0; i < _len; i++;)
			{
				var _mp = PosGui(mouse_xprevious, mouse_yprevious);
				PolygonPointMove(select_array[i], _m[0] - _mp[0], _m[1] - _mp[1]);
			}
		
			with PolyGmShape ArrayUpdate();	
		
			if mouse_check_button_pressed(mb_left)
			{
				state = EDITOR_STATES.EDIT_POLY;
			}
			break;
		#endregion
		#region DRAW OBJECT
		case EDITOR_STATES.DRAW_OBJECT:
			var _can_draw = true;
			with PolyGmShape
			{
				if drawing
				or hover_shape == true
				or hover_point != -1
				or hover_handle != -1
				or mouse_point != -1
				{
					_can_draw = false;
				}
			}
			
			if position_meeting(mouse_xc, mouse_yc, PolyGmObject)
			{
				_can_draw = false;	
			}
		
			if !hover_on_button and _can_draw and mouse_check_button_pressed(mb_left)
			{
				var _inst = instance_create_layer(
					mouse_xc, mouse_yc,
					LayerFind(global.layers[layer_index].name),
					PolyGmObject);
				_inst.origin = new Vec2(mouse_xc, mouse_yc);
				_inst.target = new Vec2(mouse_xc + 100, mouse_yc);
				_inst.colour = colour;
				_inst.alpha = alpha;
			}
			break;
		#endregion
		#region EDIT OBJECT
		case EDITOR_STATES.EDIT_OBJECT:
			if shape_selected == -1
			{
				if mouse_check_button_pressed(mb_left) and position_meeting(mouse_xc, mouse_yc, PolyGmObject)
				{
					shape_selected = instance_position(mouse_xc, mouse_yc, PolyGmObject);
				}
			}
			else
			{
				if mouse_check_button(mb_left)
				{
					if shape_selected.mo PolygonPointMove(shape_selected.origin, mouse_xc - mouse_xprevious, mouse_yc - mouse_yprevious);
					if shape_selected.mt PolygonPointMove(shape_selected.target, mouse_xc - mouse_xprevious, mouse_yc - mouse_yprevious);
				}
			}
			break;
		#endregion
	}
}
else
{
	//shape_selected = -1;	
}

PolygonActivation();