extends Node
class_name TransformLinker, "res://interface/transform_link.png"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (Dictionary) var linkingPaths;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for sourceP in linkingPaths.keys():
		var targetP = linkingPaths[sourceP];
		var source = get_node(sourceP);
		var target = get_node(targetP);
		
		target.global_transform = source.global_transform;
