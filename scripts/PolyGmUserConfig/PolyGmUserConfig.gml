// Customize the following globals

// Mandatory:

// Array of textures

global.textures = [spr_rock, spr_metal];

// Aspect ratio of view

global.view_ratio = 16 / 9;

// Optional:

// Size of rectangles around each point

global.point_size = 6;

// Size of scaling handles

global.handle_size = 8;

// While drawing a new polygon in freehand mode, draw circles around each point to show distance between points? (0 = draw nothing, 1 = draw circle, 2 = draw line)

global.auto_draw_circles = 1;

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