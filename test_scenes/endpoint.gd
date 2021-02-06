extends PipelineComponent
export(NodePath)var _particles;
onready var particles:Particles2D = get_node(_particles);
var volume = 0;
var pumpingForce = 0;
var maxVolume = 10.0;


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	particles.emitting = volume > 0.05;
	particles.speed_scale = volume + 1.0;
	volume -= delta * volume * 50.0;
