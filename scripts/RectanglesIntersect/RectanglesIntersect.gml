function RectanglesIntersect(_right0, _left0, _top0, _bottom0, _right1, _left1, _top1, _bottom1)
{
    // Check if two rectangles intersect.

    // Parameters:
    // rect1, rect2: Tuples representing rectangles in the form (x, y, width, height)

    // Returns:
    // True if the rectangles intersect, False otherwise
	
	var _x0 = _left0;
	var _y0 = _bottom0;
	var _w0 = _right0 - _left0;
	var _h0 = _bottom0 - _top0;
	
	var _x1 = _left1;
	var _y1 = _bottom1;
	var _w1 = _right1 - _left1;
	var _h1 = _bottom1 - _top1;
	
    // Check for overlap on x and y axes
	
    if (_x0 < (_x1 + _w1)) and ((_x0 + _w0) > _x1) and (_y0 < (_y1 + _h1)) and ((_y0 + _h0) > _y1) return true;
    return false;
}