extends PipelineComponent

export(NodePath) var _socket;
onready var socket:PipeSocket = get_node(_socket);
export(float,0,999.0) var pumpForce = 100.0;
var enabled = false
var volume = 0;
var maxVolume = 0;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(socket.next == null):
		return;
	if(Input.is_key_pressed(KEY_SHIFT)):
		enabled = !enabled;
	var n = socket.next;
	while(n != null):
		if(not n.isPipe()):
			break;
		if enabled:
			n.pumpingForce = self.pumpForce;

		else:
			n.pumpingForce = 0;
		n = n.socket.next;
	if enabled:
		position.y += rand_range(-0.5,0.5);
	socket.next.volume +=self.volume;
	self.volume = 0;
