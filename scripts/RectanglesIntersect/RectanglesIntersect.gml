function RectanglesIntersect(_right0, _left0, _top0, _bottom0, _right1, _left1, _top1, _bottom1)
{
    // Check if two rectangles intersect.

    // Parameters:
    // rect1, rect2: Tuples representing rectangles in the form (x, y, width, height)

    // Returns:
    // True if the rectangles intersect, False otherwise
	
	var _w0 = _right0 - _left0;
	var _h0 = _bottom0 - _top0;
	
	var _w1 = _right1 - _left1;
	var _h1 = _bottom1 - _top1;
	
    // Check for overlap on x and y axes
	
    if (_left0 < (_left1 + _w1))
	and ((_left0 + _w0) > _left1)
	and (_bottom0 < (_bottom1 + _h1))
	and ((_bottom0 + _h0) > _bottom1) return true;
	
    return false;
}