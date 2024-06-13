/// @desc Returns whether or not two rectangles are intersecting
/// @param {real} _right0 X value for rectangle 1's right edge
/// @param {real} _left0 X value for rectangle 1's left edge
/// @param {real} _top0 Y value for rectangle 1's top edge
/// @param {real} _bottom0 Y value for rectangle 1's bottom edge
/// @param {real} _right1 X value for rectangle 2's right edge
/// @param {real} _left1 X value for rectangle 2's left edge
/// @param {real} _top1 Y value for rectangle 2's top edge
/// @param {real} _bottom1 Y value for rectangle 2's bottom edge
/// @returns {Bool} Whether or not two rectangles are intersecting
function RectanglesIntersect(_right0, _left0, _top0, _bottom0, _right1, _left1, _top1, _bottom1)
{
    // Check for overlap on x and y axes
	
    if ((_left0 < _right1) and (_right0 > _left1) and (_top0 < _bottom1) and (_bottom0 > _top1))
	{
		return true
	}
	
    return false;
}