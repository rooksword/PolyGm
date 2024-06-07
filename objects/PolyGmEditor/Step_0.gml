/// @desc Create PolyGmShape

#region Snap mouse to grid

var _s = keyboard_check(vk_lshift) ? global.grid_size : 1;
mouse_xc = floor(mouse_x / _s) * _s;
mouse_yc = floor(mouse_y / _s) * _s;

#endregion

var _m = PosGui(mouse_xc, mouse_yc);

switch state
{
	case EDITOR_STATES.EDIT:
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
	case EDITOR_STATES.SELECT:
		array_push(selection, new Vec2(mouse_xc, mouse_yc));

		if mouse_check_button_released(mb_left)
		{
			if PolygonIsCounterclockwise(selection) selection = array_reverse(selection);
			var _selection_tri = PolygonToTriangles(selection);
			
			with PolyGmShape
			{
				for (var i = 0; i < array_length(array); i++;)
				{
					var _p = array[i];
				
					if PointInPolygon(_p.x, _p.y, _selection_tri)
					{
						array_push(other.select_array, _p);
					}
				}
			}
			
			if array_length(select_array) == 0 state = EDITOR_STATES.EDIT;
			else state = EDITOR_STATES.EDIT_SELECT;
		}
		break;
	case EDITOR_STATES.EDIT_SELECT:
		for (var i = 0; i < array_length(select_array); i++;)
		{
			var _p = select_array[i];
			var _mp = PosGui(mouse_xprevious, mouse_yprevious);
			_p.x += _m[0] - _mp[0];
			_p.y += _m[1] - _mp[1];
		}
		
		with PolyGmShape
		{
			ArrayUpdate();	
		}
		
		if mouse_check_button_pressed(mb_left)
		{
			state = EDITOR_STATES.EDIT;
		}
		break;
	case EDITOR_STATES.DRAW:
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
			instance_create_layer(mouse_xc, mouse_yc, layers[layer_index], PolyGmShape);	
		}
		
		layers = layer_get_all();
		
		break;
}

instance_activate_object(PolyGmShape);


var _cam = PolyGmCamera.cam;

with PolyGmShape
{
	if !drawing
	and !(
	   point_in_rectangle(left, top, _cam.x, _cam.y, _cam.x + _cam.w, _cam.y + _cam.h)
	or point_in_rectangle(right, top, _cam.x, _cam.y, _cam.x + _cam.w, _cam.y + _cam.h)
	or point_in_rectangle(right, bottom, _cam.x, _cam.y, _cam.x + _cam.w, _cam.y + _cam.h)
	or point_in_rectangle(left, bottom, _cam.x, _cam.y, _cam.x + _cam.w, _cam.y + _cam.h)
	)
	{
		instance_deactivate_object(id);	
	}
}