/// @desc Movement and zooming

// Set camera struct with x (left), y (top), width, and height

cam = {
	x: camera_get_view_x(view_camera[0]),
	y: camera_get_view_y(view_camera[0]),
	w: camera_get_view_width(view_camera[0]),
	h: camera_get_view_height(view_camera[0])
};

// Move camera object around

if mouse_check_button(mb_middle)
or keyboard_check(vk_lalt)
{
	x += PolyGmEditor.mouse_xprevious - mouse_x;
	y += PolyGmEditor.mouse_yprevious - mouse_y;
}

// Zoom in or out if wheel scrolled

zoom_level = clamp(zoom_level + (((mouse_wheel_down() - mouse_wheel_up())) * 0.1), 0.1, 4);

// Set width and height based on zoom level

cam.w = lerp(cam.w, zoom_level * room_width, 1);
cam.h = cam.w / global.view_ratio; // Set height based on width and aspect ratio

// Center view on x and y position

cam.x = x - cam.w / 2;
cam.y = y - cam.h / 2;

// Set the camera view

camera_set_view_size(view_camera[0], cam.w, cam.h);
camera_set_view_pos(view_camera[0], cam.x, cam.y);