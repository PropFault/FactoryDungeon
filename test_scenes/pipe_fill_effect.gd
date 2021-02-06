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
	self.modulate = Color(percent, percent +0.4, percent * percent)

