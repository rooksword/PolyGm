/// @desc Update colour

image_blend = merge_colour(colour, LayerFindStruct(layer_get_name(layer)).colour, 0.5);
image_alpha = (alpha * LayerFindStruct(layer_get_name(layer)).alpha) / 65025;