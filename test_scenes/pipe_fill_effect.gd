extends AnimatedSprite

export(NodePath)var _pipe;
export(Vector2)var moveDown;
onready var pipe: Pipe = get_node(_pipe);
onready var maxScale = scale;
func _process(_delta):
	var percent = pipe.fillPercent/100.0
	var newScale = Vector2(maxScale.x, maxScale.y * percent)
	self.scale = newScale;
	self.position = Vector2(self.position.x, 2.0 * (1.0-percent))
	var avgR = 0;
	var avgG = 0;
	var avgB = 0;
	var ind = 0;
	for liquid in pipe.fluidTypes:
		avgR += pipe.fluidTypes[liquid].color.r;
		avgG += pipe.fluidTypes[liquid].color.g;
		avgB += pipe.fluidTypes[liquid].color.b;
		ind += 1;
	if ind > 0:
		avgR /= ind;
		avgG /= ind;
		avgB /= ind;
	self.modulate = Color(avgR, avgG, avgB)

