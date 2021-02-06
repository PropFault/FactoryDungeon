extends KinematicBody2D

export(NodePath) var animatorPath;
var animator;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity;
var forward;

# Called when the node enters the scene tree for the first time.
func _ready():
	animator = get_node(animatorPath);
	velocity = Vector2(0,0);
	forward = Vector2(1,0);

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _physics_process(delta):
	if Input.is_action_pressed("m_l"):
		velocity += Vector2(-5, 0);
	if Input.is_action_pressed("m_r"):
		velocity += Vector2(5, 0);
	velocity += Vector2(0.0,9.81);
	velocity = self.move_and_slide(velocity, Vector2(0,-1), false, 4, 1);
	#if self.is_on_floor():
		#velocity /= 1.05;
	

func _process(delta):
	animator.playback_speed = velocity.length() / 45;

func _input(event):
	if event.is_action_pressed("jump"):
		velocity += Vector2(0.0, -200.0);
	
