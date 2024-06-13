/// @desc Converts a pair of game co-ordinates to GUI co-ordinates
/// @param {real} _x X position to convert
/// @param {real} _y Y position to convert
/// @returns {array<real>} Returns an array where the first value is the x position 
function PosGui(_x, _y)
{
	var _cl = camera_get_view_x(view_camera[0]); // Camera left
	var _ct = camera_get_view_y(view_camera[0]); // Camera tp

	var _off_x = _x - _cl; // x is the normal x position
	var _off_y = _y - _ct; // y is the normal y position
	
	// convert to gui
	
	var _off_x_percent = _off_x / camera_get_view_width(view_camera[0]);
	var _off_y_percent = _off_y / camera_get_view_height(view_camera[0]);
       
	var _gui_x = _off_x_percent * display_get_gui_width();
	var _gui_y = _off_y_percent * display_get_gui_height();
	
	return [_gui_x, _gui_y];
}