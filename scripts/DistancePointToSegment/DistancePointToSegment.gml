/// @desc Calculates the distance between a point and a segment
/// @param {real} _px X position to check
/// @param {real} _py Y position to check
/// @param {real} _x1 X co-ordinate of line start
/// @param {real} _y1 Y co-ordinate of line start
/// @param {real} _x2 X co-ordinate of line end
/// @param {real} _y2 Y co-ordinate of line end
/// @returns {real} Distance from the point to a projection point on the line
function DistancePointToSegment(_px, _py, _x1, _y1, _x2, _y2)
{
    // Calculate the vector projections
	
    var _dx = _x2 - _x1
    var _dy = _y2 - _y1
	
    if _dx == 0 and _dy == 0 // The segment is actually a point
	{
        return sqrt(sqr(_px - _x1) + sqr(_py - _y1));
	}
    
    var _t = ((_px - _x1) * _dx + (_py - _y1) * _dy) / (_dx * _dx + _dy * _dy);
    var _t_clamped = clamp(_t, 0, 1);
    
    // Coordinates of the projection point
	
    var _x_proj = _x1 + _t_clamped * _dx;
    var _y_proj = _y1 + _t_clamped * _dy;
    
    // Distance from the point to the projection point
	
     return sqrt(sqr(_px - _x_proj) + sqr(_py - _y_proj));
}