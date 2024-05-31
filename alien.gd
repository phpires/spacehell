extends RigidBody2D

var screen_size
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().get_visible_rect().size
	position = generate_position()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func generate_position():
	var x =  rng.randi_range(0, screen_size.x)
	return Vector2(x,0)
