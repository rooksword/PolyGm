function DistancePointToSegment(_px, _py, _x1, _y1, _x2, _y2)
{
    // Calculate the vector projections
    var _dx = _x2 - _x1
    var _dy = _y2 - _y1
    if _dx == 0 and _dy == 0
	{
        // The segment is actually a point
        return sqrt(sqr(_px - _x1) + sqr(_py - _y1));
	}
    
    var _t = ((_px - _x1) * _dx + (_py - _y1) * _dy) / (_dx * _dx + _dy * _dy)
    var _t_clamped = max(0, min(1, _t))
    
    // Coordinates of the projection point
    var _x_proj = _x1 + _t_clamped * _dx
    var _y_proj = _y1 + _t_clamped * _dy
    
    // Distance from the point to the projection point
    var _distance = sqrt(sqr(_px - _x_proj) + sqr(_py - _y_proj))
    return _distance
}