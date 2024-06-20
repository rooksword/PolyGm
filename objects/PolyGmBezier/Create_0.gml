/// @desc Variables

line = [
	new Vec2(x, y),
	new Vec2(x + 50, y),
	new Vec2(x + 100, y),
	new Vec2(x + 150, y)
];

point_hover = -1;
point_hold = -1;

time = 0;

rand = [];

colour_debug = make_colour_hsv(irandom(255), 255, 255);

layer_hover = 1;