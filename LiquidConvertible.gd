extends Node
class_name LiquidConvertible
export(NodePath) var _root;
export(NodePath) var _sprite;
export(float, 0, 9999.9) var volumeProduced;
export(String) var typeString;

func convertToLiquidType():
	var root = get_node(_root);
	var type = LiquidType.new(root, get_node(_sprite),typeString, volumeProduced);
	root.get_parent().remove_child(root);
	return type;
