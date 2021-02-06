extends Node2D

export(NodePath)var  _rootSocket;
export(Font)var font;
onready var rootSocket = get_node(_rootSocket);
var value = 0;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if(Input.is_key_pressed(KEY_SPACE)):
		value += delta;
		var it = rootSocket;
		while(true):
			it.socketOwner.rotation = sin(value-it.socketOwner.position.x/30.0) * cos(it.socketOwner.position.y/500.0);
			if(it.next == null or it.next.get("socket") == null):
				break;
			it = it.next.socket;
			

	update()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _draw():
	var it = rootSocket;
	var sum = 0.0
	while(true):
		sum += it.socketOwner.volume;
		if(it.next == null or it.next.get("socket") == null):
				break;
		it = it.next.socket;
	draw_string(font,Vector2(),str(sum));
