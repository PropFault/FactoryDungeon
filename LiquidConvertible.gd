extends Node
class_name LiquidConvertible
export(NodePath) var _root;
export(NodePath) var _sprite;
export(float, 0, 9999.9) var volumeProduced;
export(String) var typeString;

func convertToLiquidType():
	return LiquidType.new(get_node(_root), get_node(_sprite),typeString, volumeProduced);
