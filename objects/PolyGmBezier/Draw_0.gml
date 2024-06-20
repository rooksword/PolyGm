/// @desc Draw line

function BezierDraw()
{
	draw_set_colour(c_white);

	var _d = 0.1;
	var _leaf = false;

	var _count = 0;

	var _a = 30;

	var _debug = PolyGmEditor.active and PolyGmEditor.state == EDITOR_STATES.BEZIER;

	for (var i = 0; i < 1; i += _d;)
	{
		if _count == array_length(rand)
		{
			array_push(rand, {
				dir: choose(-90, 90) + irandom_range(-_a, _a),
				leaf: choose(true, false, false, false),
				ang: choose(1.25, 2.5, 5)
			});
		}
	
		var _l1 = new Vec2(line[1].x + sin(time * 2) * 16, line[1].y + sin(time) * 8);
		var _l2 = new Vec2(line[2].x + sin(time * 2) * 16, line[2].y + sin(time) * 8);
	
		var _p = BezierPointFind(i, line[0], _l1, _l2, line[3]);
		var _q = -1;
	
		if i < 1 - _d
		{
			_q = BezierPointFind(i + _d, line[0], _l1, _l2, line[3]);
		}
	
		if _q != -1
		{
		
			var _dir = point_direction(_p.x, _p.y, _q.x, _q.y);
			var _dist = point_distance(_p.x, _p.y, _q.x, _q.y);
		
			draw_sprite_ext(spr_vine, -1, _p.x, _p.y, _dist, 1, _dir, _debug ? colour_debug : c_white, 1);
			
			draw_sprite_ext(spr_vine_circle, -1, _q.x, _q.y, 1, 1, 0, _debug ? colour_debug : c_white, 1);
			
			if rand[_count].leaf
			{
				draw_sprite_ext(spr_vine_leaf, -1, _p.x, _p.y, 1, 1, _dir + rand[_count].dir + sin(time * rand[_count].ang) * 15, _debug ? colour_debug : c_white, 1);
			}
		}
	
		_count++;
	
		//draw_circle(_p.x, _p.y, 2, false);
	}
}

function BezierDrawDebug()
{
	var _len = array_length(line);
	for (var i = 0; i < _len; i++;)
	{
		var _p = line[i];
		
		draw_set_colour(point_hover == i or point_hold == i ? merge_colour(colour_debug, c_black, 0.5) : colour_debug);
		draw_circle(_p.x, _p.y, 5, false);
	}
}