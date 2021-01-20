extends KinematicBody2D

export(NodePath) var walkAnimatorPath;
var walkAnimator;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity;
var forward;

# Called when the node enters the scene tree for the first time.
func _ready():
	walkAnimator = get_node(walkAnimatorPath);
	velocity = Vector2(0,0);
	forward = Vector2(1,0);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	walkAnimator.playback_speed = (velocity.length() * velocity.normalized().dot(forward)) / 20.0;
	
func _physics_process(delta):
	if Input.is_action_pressed("m_l"):
		velocity += Vector2(-50*delta, 0);
	if Input.is_action_pressed("m_r"):
		velocity += Vector2(50*delta, 0);
	velocity += Vector2(0.0,9.81*delta);
	velocity = self.move_and_slide(velocity, Vector2(0,-1));
	#if self.is_on_floor():
		#velocity /= 1.05;
	

func _input(event):
	if event.is_action_pressed("jump"):
		velocity += Vector2(0.0, -20.0);
	
