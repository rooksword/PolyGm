/// @desc Update colour

var _mx = PolyGmEditor.mouse_xc;
var _my = PolyGmEditor.mouse_yc;

mo = point_distance(_mx, _my, origin.x, origin.y) < 10;
mt = point_distance(_mx, _my, target.x, target.y) < 10;

var _val = (0.5 + sin((offset - 1.5) + (current_time / 1000 * spd)) / 2);

x = origin.x + (_val * (target.x - origin.x));
y = origin.y + (_val * (target.y - origin.y));

image_blend = merge_colour(colour, LayerFindStruct(layer_get_name(layer)).colour, 0.5);
image_alpha = (alpha * LayerFindStruct(layer_get_name(layer)).alpha) / 65025;

if angle_speed != 0 image_angle = ((current_time / 100) * angle_speed);