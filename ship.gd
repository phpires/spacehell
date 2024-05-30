extends Area2D

@export var speed = 450
var screen_size
signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	start(Vector2(screen_size/2))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if (Input.is_action_pressed("move_right")):
		velocity.x += 1
	if (Input.is_action_pressed("move_left")):
		velocity.x -= 1
	if (Input.is_action_pressed("move_down")):
		velocity.y += 1
	if (Input.is_action_pressed("move_up")):
		velocity.y -= 1
	
	if (velocity.length()):
		velocity = velocity.normalized()*speed
	
	position += velocity*delta
	position = position.clamp(Vector2.ZERO, screen_size)
	

func _on_body_entered(body):
	hit.emit()
	$CollisionShapeShip.set_deferred("disable", true)

func start(pos : Vector2):
	position = pos
	$CollisionShapeShip.disabled = false
