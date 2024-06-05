function PosGui(_x, _y)
{
	var cl = camera_get_view_x(view_camera[0])
	var ct = camera_get_view_y(view_camera[0])

	var off_x = argument0 - cl // x is the normal x position
	var off_y = argument1 - ct // y is the normal y position
	// convert to gui
	var off_x_percent = off_x / camera_get_view_width(view_camera[0])
	var off_y_percent = off_y / camera_get_view_height(view_camera[0])
       
	var gui_x = off_x_percent * display_get_gui_width()
	var gui_y = off_y_percent * display_get_gui_height()
	
	return [gui_x, gui_y];
}