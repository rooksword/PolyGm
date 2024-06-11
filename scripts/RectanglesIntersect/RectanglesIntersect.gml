function RectanglesIntersect(_right0, _left0, _top0, _bottom0, _right1, _left1, _top1, _bottom1)
{
    // Check for overlap on x and y axes
	
    if ((_left0 < _right1) and (_right0 > _left1) and (_top0 < _bottom1) and (_bottom0 > _top1))
	{
		return true
	}
	
    return false;
}