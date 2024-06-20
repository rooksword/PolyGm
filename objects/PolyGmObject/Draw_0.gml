/// @desc Draw target

draw_self();

draw_line(origin.x, origin.y, target.x, target.y);
draw_set_colour(mo ? c_red : c_white);
draw_circle(origin.x, origin.y, 5, false);
draw_set_colour(mt ? c_red : c_white);
draw_circle(target.x, target.y, 5, false);