/// @desc Initialize

window_set_cursor(cr_none); // Remove default windows cursor
						    
gpu_set_texrepeat(true);    // Set all textures to repeat infinitely
				
//show_debug_overlay(true);

texturegroup_unload("texgroup1");

enum EDITOR_STATES          // States control what buttons and actions are available
{						    
	EDIT_POLY,			    
	DRAW_POLY,
	SELECT,
	EDIT_SELECT,
	BEZIER,
	EDIT_OBJECT,
	DRAW_OBJECT
}
						    
state = EDITOR_STATES.EDIT_POLY; // Set the default state to 'edit'
						    
shape_selected = -1;        // Holds a reference to the currently selected shape
hover_on_button = false;    // Is the mouse hovering over a button?
						    
mouse_xc = mouse_x;         // Current mouse_x (can be snapped)
mouse_yc = mouse_y;         // Current mouse_y (can be snapped)
mouse_xprevious = mouse_x;  // Previous mouse_x (can be snapped)
mouse_yprevious = mouse_y;  // Previous mouse_y (can be snapped)

layer_index = 0;

select_array = [];
selection = [];

spr_index = 0;
colour = c_white;
alpha = 255;

active = false;

deactivated = [];

dbgview = dbg_view("PolyGmEditor", visible, 0, 18, 300, display_get_height() - 18);
shape_dbgsection = undefined;
object_dbgsection = undefined;

function DBGSettings()
{
	dbg_section("Settings", true);

	var _str = "EDIT_POLY,DRAW_POLY,SELECT,EDIT_SELECT,BEZIER,EDIT_OBJECT,DRAW_OBJECT";
	dbg_drop_down(ref_create(self, "state"), _str, "State");

	_str = "";
	var _len = array_length(global.layers);
	for (var i = 0; i < _len; i++;)
	{
		var _lay = global.layers[i];
		_str += _lay.name;
		if i < _len - 1 _str += ",";
	}

	dbg_drop_down(ref_create(self, "layer_index"), _str, "Current Layer");

	dbg_colour(ref_create(self, "colour"), "Blend Colour");
	dbg_slider(ref_create(self, "alpha"), 0, 255, "Alpha");

	_str = "";
	var _len = array_length(global.textures);
	for (var i = 0; i < _len; i++;)
	{
		var _spr = global.textures[i];
		_str += sprite_get_name(_spr);
		if i < _len - 1 _str += ",";
	}

	dbg_drop_down(ref_create(self, "spr_index"), _str, "Sprite");
	
	dbg_text_input(ref_create(global, "auto_draw"), "Auto-draw Distance", "r");
}

function DBGLayers()
{
	dbg_section("Layers", true);

	var _len = array_length(global.layers);
	for (var i = 0; i < _len; i++;)
	{
		var _lay = global.layers[i];
		dbg_text(_lay.name);
		dbg_checkbox(ref_create(_lay, "visible"), "Visible");
		dbg_checkbox(ref_create(_lay, "locked"), "Locked");
		dbg_colour(ref_create(_lay, "colour"), "Blend Colour");
		dbg_slider(ref_create(_lay, "alpha"), 0, 255, "Alpha");
	}
}

function DBGShape()
{
	shape_dbgsection = dbg_section("Shape Selected", true);

	dbg_button("Update", function () {
		shape_selected.colour = colour;	
		shape_selected.alpha = alpha;
		
		var _index = shape_selected.object_index;
		var _tex = global.textures[spr_index];
		if _index == PolyGmShape
		{
			with shape_selected PolygonSprite(_tex);
		}
		else if _index == PolyGmObject
		{
			shape_selected.sprite_index = _tex;	
		}
	});

	dbg_button("Delete", function () {
		instance_destroy(shape_selected);
		shape_selected = -1;
	});

	dbg_button("Duplicate", function () {
		var _index = shape_selected.object_index;
		if _index == PolyGmShape PolygonDuplicate(shape_selected, 100, 0);
		else if _index == PolyGmObject
		{
			var _inst = instance_create_layer(shape_selected.x + 100, shape_selected.y, shape_selected.layer, PolyGmObject);
			_inst.sprite_index = shape_selected.sprite_index;
			_inst.colour       = shape_selected.colour;
			_inst.alpha        = shape_selected.alpha;
			_inst.layer        = shape_selected.layer;
			_inst.image_xscale = shape_selected.image_xscale;
			_inst.image_yscale = shape_selected.image_yscale;
			_inst.image_angle  = shape_selected.image_angle;
			_inst.angle_speed  = shape_selected.angle_speed;
			_inst.spd          = shape_selected.spd;
			_inst.offset       = shape_selected.offset;
		}
		shape_selected = -1;
	});

	dbg_button("Flip Horzontally", function () {
		var _index = shape_selected.object_index;
		if _index == PolyGmShape PolygonFlip(shape_selected, true);
		else if _index == PolyGmObject with shape_selected image_xscale *= -1;
	});

	dbg_same_line();

	dbg_button("Flip Vertically", function () {
			var _index = shape_selected.object_index;
			if _index == PolyGmShape PolygonFlip(shape_selected, false);
			else if _index == PolyGmObject with shape_selected image_yscale *= -1;
	});

	dbg_button("Rotate Clockwise", function () {
		var _index = shape_selected.object_index;
		if _index == PolyGmShape with shape_selected PolygonRotate(-2);
		else if _index == PolyGmObject shape_selected.image_angle -= 2;	
	});

	dbg_same_line();

	dbg_button("Rotate Counter-clockwise", function () {
		var _index = shape_selected.object_index;
		if _index == PolyGmShape with shape_selected PolygonRotate(2);
		else if _index == PolyGmObject shape_selected.image_angle += 2;	
	});
}

function DBGObject()
{
	object_dbgsection = dbg_section("Object", true);
	
	dbg_text_input(ref_create(shape_selected, "image_xscale"), "X Scale", "r");
	dbg_text_input(ref_create(shape_selected, "image_yscale"), "Y Scale", "r");
	dbg_text_input(ref_create(shape_selected, "spd"), "Speed", "r");
	dbg_text_input(ref_create(shape_selected, "offset"), "Offset", "r");
	dbg_text_input(ref_create(shape_selected, "angle_speed"), "Auto-rotate Speed", "r");
}

function DBGInformation()
{
	dbg_section("Information");
	dbg_text(ref_create(global, "info_text"));	
}

DBGSettings();
DBGLayers();
DBGInformation();