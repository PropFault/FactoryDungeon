extends Tween
class_name RayCast2DPositioner, "res://interface/human_ik.png"

export(NodePath) var raycast2DPath;
export(NodePath) var targetPath;
export(int, FLAGS, "x", "y", "Do not modify") var xMask;
export(int, FLAGS, "x", "y", "Do not modify") var yMask;
export(int, FLAGS, "x", "y", "Do not modify") var zMask;
export(int)var convFacX;
export(int)var convFacY;
export(int)var trackerCompensationX;
export(int)var tackerCompensationY;
export(int)var offsetX;
export(int)var offsetY;
export(bool)var enabled;

var raycast2D;
var target;
var MASK_X = 0b00000001
var MASK_Y = 0b00000010
var MASK_DONOT = 0b00000100


func _ready():
	raycast2D = get_node(raycast2DPath) as RayCast2D;
	target =  get_node(targetPath) as Spatial
	#targetBasePos = target.global_transform.origin;

func _physics_process(_delta):
	if self.is_active():
		return
	var colPoint = raycast2D.global_transform.origin - raycast2D.get_collision_point();
	colPoint += Vector2(trackerCompensationX, tackerCompensationY); # compensate for tracker base pos
	colPoint += Vector2(offsetX, offsetY);
	colPoint.x /= convFacX;
	colPoint.y /= convFacY;
	var toApply = Vector3(
		colPoint.x if xMask&MASK_X else 0 +
		colPoint.y if xMask&MASK_Y else 0,
		colPoint.x if yMask&MASK_X else 0 +
		colPoint.y if yMask&MASK_Y else 0,
		colPoint.x if zMask&MASK_X else 0 +
		colPoint.y if zMask&MASK_Y else 0 
		);
	if xMask&MASK_DONOT:
		toApply.x = target.transform.origin.x;
	if yMask&MASK_DONOT:
		toApply.y = target.transform.origin.y;
	if zMask&MASK_DONOT:
		toApply.z = target.transform.origin.z;
	self.interpolate_property(target, "transform:origin", target.transform.origin, toApply, 0.05, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT);
	self.start();
	print(toApply);

