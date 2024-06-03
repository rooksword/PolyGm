global.bb_hover = 0; // 0 = darken, 1 = alpha
global.bb_rect_colour = c_ltgray;
global.bb_rect_alpha = 1;
global.bb_text_colour = c_dkgray;
global.bb_outline = false;
global.bb_padding = 4;
global.bb_mousex = 0;
global.bb_mousey = 0;

function Button(_string) constructor
{
	text = _string;
	text_x = 0;
	text_y = 0;
	
	x0 = -global.bb_padding;
	y0 = -global.bb_padding;
	x1 = global.bb_padding;
	y1 = global.bb_padding;
	
	radius = 0;
	
	function Define4(_x0, _y0, _x1, _y1)
	{
		x0 += _x0;
		y0 += _y0;
		x1 += _x1;
		y1 += _y1;
	}
	
	function DefineTL(_x, _y, _w, _h)
	{
		x0 += _x;
		y0 += _y;
		x1 += _x + _w;
		y1 += _y + _h;
		
		text_x = _x;
		text_y = _y;
	}
	
	function DefineTR(_x, _y, _w, _h)
	{
		x0 += _x - _w;
		y0 += _y - _h;
		x1 += _x;
		y1 += _y;
		
		text_x = _x;
		text_y = _y;
	}
	
	function DefineC(_x, _y, _w, _h)
	{
		x0 += _x - (_w / 2);
		y0 += _y - (_h / 2);
		x1 += _x + (_w / 2);
		y1 += _y + (_h / 2);
		
		text_x = _x;
		text_y = _y;
	}

	function Draw()
	{
		var _alpha = 1;
		
		var _rcolour = global.bb_rect_colour;
		var _tcolour = global.bb_text_colour;
		
		if global.bb_hover == 0
		{
			if Hover()
			{
				_rcolour = merge_colour(_rcolour, c_black, 0.5);
				_tcolour = merge_colour(_tcolour, c_black, 0.5);
			}
		}
		else
		{
			if !Hover()
			{
				_alpha = 0.5;
			}
		}
		
		draw_set_alpha(_alpha);
		
		draw_set_colour(_rcolour);
		draw_set_alpha(global.bb_rect_alpha);
		draw_roundrect_ext(x0, y0, x1, y1, radius, radius, global.bb_outline);
		
		draw_set_alpha(1);
		draw_set_alpha(_alpha);
		
		draw_set_colour(_tcolour);
		draw_text(text_x, text_y, text);
		
		draw_set_alpha(1);
	}
	
	function Hover()
	{
		return point_in_rectangle(global.bb_mousex, global.bb_mousey, x0, y0, x1, y1);	
	}
	
	function Pressed()
	{
		return Hover() and mouse_check_button_pressed(mb_left);
	}
	
	function PressedR()
	{
		return Hover() and mouse_check_button_pressed(mb_right);
	}
	
	function Down()
	{
		return Hover() and mouse_check_button(mb_left);
	}
	
	function DownR()
	{
		return Hover() and mouse_check_button(mb_right);
	}
	
	function Released()
	{
		return Hover() and mouse_check_button_released(mb_left);
	}
}