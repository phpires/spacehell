extends Area2D

@export var bullet_speed = 1000
var initial_position
# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed_direction = Vector2(0,-1)
	var speed_vector = speed_direction.normalized()*bullet_speed
	position += speed_vector*delta

func start(pos):
	position = pos

func _on_area_entered(area):
	print("Bullet hitted area: " + area)
	if area.is_in_group("enemies"):
		area.explode()
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	#print("Bullet hitted body: " + body)
	if body.is_in_group("enemies"):
		body.explode()
		queue_free()
