/// @desc Returns whether or not a value is in an array
/// @param {any} _val Value to look for
/// @param {array} _arr Array to look in
/// @returns {Bool} Whether or not the value is in the array
function InArray(_val, _arr)
{
	for (var i = 0; i < array_length(_arr); i++;)
	{
		if _val == _arr[i] return true;	
	}
	return false;
}