// Customize the following globals

// Mandatory:

/// @desc Activates all polygons, then deactivates polygons outside of specified region
function PolygonActivation()
{
	var _cam = PolyGmCamera.cam;     // Uses the demo camera by default, feel free to change
	var _right  = _cam.x + _cam.w; // X value of right edge of region
	var _left   = _cam.x;          // X value of left edge of region
	var _top    = _cam.y;          // Y value of top edge of region
	var _bottom = _cam.y + _cam.h; // Y value of bottom edge of region
	
	var _len = array_length(deactivated);
	for (var i = 0; i < _len; i++;)
	{
		var _d = deactivated[i];
		if RectanglesIntersect(_d.right, _d.left, _d.top, _d.bottom, _right, _left, _top, _bottom)
		{
			instance_activate_object(_d.id);
			array_delete(deactivated, i, 1);
			_len--;
		}
	}
	
	var _deactivated = deactivated;
	
	with PolyGmShape
	{
		//if layer_get_name(layer) != "PGMTop"
		//{
		//	instance_deactivate_object(id);
		//}
		
		if !drawing and !RectanglesIntersect(right, left, top, bottom, _right, _left, _top, _bottom)
		{
			array_push(_deactivated, {
				id: id,
				right: right,
				left: left,
				top: top,
				bottom: bottom
			});
			instance_deactivate_object(id);	
		}
	}
	
	instance_activate_object(PolyGmBezier);
	with PolyGmBezier
	{
		if !point_in_rectangle(line[0].x, line[0].y, _left, _top, _right, _bottom)
		and !point_in_rectangle(line[1].x, line[1].y, _left, _top, _right, _bottom)
		and !point_in_rectangle(line[2].x, line[2].y, _left, _top, _right, _bottom)
		and !point_in_rectangle(line[3].x, line[3].y, _left, _top, _right, _bottom)
		{
			instance_deactivate_object(id);	
		}
	}
}

// Array of textures

global.textures = [spr_metal, spr_rock];

// Aspect ratio of view

global.view_ratio = 16 / 9;

// Optional:

// Size of rectangles around each point

global.point_size = 4;

// Size of scaling handles

global.handle_size = 6;

// The distance between points when drawing in freehand mode

global.auto_draw = 64;

// While drawing a new polygon in freehand mode, draw circles around each point to show distance between points? (0 = draw nothing, 1 = draw circle, 2 = draw line)

global.auto_draw_circles = 2;

// Draw info text

global.info_text = true;

// Grid size (for snapping the mouse to the grid)

global.grid_size = 64;

// Directory for save files (by default in your local app data)

global.save_directory = "";

// If true, PolyGmEditor draws to GUI. If false, call PolyGmEditorDrawGUI() function in whichever 'Draw GUI' event you want

global.draw_editor = true;

// If true, all vertex buffers will get frozen upon creation (good for if you are just loading a level and don't need to edit it at runtime and want a performance boost)

global.freeze = false;

// Keyboard shortcut to switch between working with polygons and shapes

global.shortcut_poly = ord("O");

// Keyboard shortcut to switch between editing and drawing

global.shortcut_edit = ord("P");