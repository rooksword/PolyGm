/// @desc Activates all polygons, then deactivates polygons outside of specified region
function PolygonActivation()
{
	var _cam = PolyGmCamera.cam;   // Uses the demo camera by default, feel free to change
	var _right  = _cam.x + _cam.w; // X value of right edge of region
	var _left   = _cam.x;          // X value of left edge of region
	var _top    = _cam.y;          // Y value of top edge of region
	var _bottom = _cam.y + _cam.h; // Y value of bottom edge of region
	
	instance_activate_object(PolyGmShape);
	with PolyGmShape
	{
		if !drawing and !RectanglesIntersect(right, left, top, bottom, _right, _left, _top, _bottom)
		{
			instance_deactivate_object(id);	
		}
	}
}