function Wrap(_val, _a, _b)
{
	var _value = floor(_val);
	var _min = floor(min(_a, _b));
	var _max = floor(max(_a, _b));
	var _range = _max - _min + 1; // + 1 is because max bound is inclusive

	return (((_value - _min) % _range) + _range) % _range + _min;
}