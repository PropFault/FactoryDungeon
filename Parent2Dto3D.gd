extends Node
class_name Parent2Dto3D

export(NodePath) var childPath;
export(NodePath) var parentPath;
export(int, FLAGS, "x", "y", "z") var copyParentAxisToX;
export(int, FLAGS, "x", "y", "z") var copyParentAxisToY;

enum AxisEnum{x,y,z,doNotParent};
export(AxisEnum) var parentXTo;
export(AxisEnum) var parentYTo;
export(int) var convFacX;
export(int) var convFacY;
var child;
var parent;
var parentOriginalPosition;
var childOriginalPosition;
var MASK_X = 0b00000001;
var MASK_Y = 0b00000010;
var MASK_Z = 0b00000100;


# Called when the node enters the scene tree for the first time.
func _ready():
	child = get_node(childPath);
	parent = get_node(parentPath);
	if(copyParentAxisToX&MASK_X):
		child.global_transform.origin.x += parent.global_transform.origin.x * convFacX;
	if(copyParentAxisToX&MASK_Y):
		child.global_transform.origin.x += parent.global_transform.origin.y * convFacX;
	if(copyParentAxisToX&MASK_Z):
		child.global_transform.origin.x += parent.global_transform.origin.z * convFacX;
	if(copyParentAxisToY&MASK_X):
		child.global_transform.origin.y -= parent.global_transform.origin.x * -convFacY;
	if(copyParentAxisToY&MASK_Y):
		child.global_transform.origin.y -= parent.global_transform.origin.y * -convFacY;
	if(copyParentAxisToY&MASK_Z):
		child.global_transform.origin.y -= parent.global_transform.origin.z * -convFacY;
	
	parentOriginalPosition = parent.transform.origin;
	childOriginalPosition = child.transform.origin;
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var diff = (parentOriginalPosition - parent.transform.origin);
	if(parentXTo == AxisEnum.x):
		child.transform.origin.x += (diff.x - (child.transform.origin.x-childOriginalPosition.x)/convFacX)*convFacX;
	elif parentXTo == AxisEnum.y:
		child.transform.origin.x += (diff.y - (child.transform.origin.x-childOriginalPosition.x)/convFacX)*convFacX;
	elif parentXTo == AxisEnum.z:
		child.transform.origin.x += (diff.z - (child.transform.origin.x-childOriginalPosition.x)/convFacX)*convFacX;
	if(parentYTo == AxisEnum.x):
		child.transform.origin.y += (diff.x - (child.transform.origin.y-childOriginalPosition.y)/convFacY)*convFacY;
	elif parentYTo == AxisEnum.y:
		child.transform.origin.y += (diff.y - (child.transform.origin.y-childOriginalPosition.y)/convFacY)*convFacY;
	elif parentYTo == AxisEnum.z:
		child.transform.origin.y += (diff.z - (child.transform.origin.y-childOriginalPosition.y)/convFacY)*convFacY;
