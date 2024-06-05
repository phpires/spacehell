extends Area2D

@export var speed = 450
@export var bullet_cooldown = 0.13
@export var bullet_scene: PackedScene

signal hit

var Y_OFFSET = 100
var BULLET_OFFSET = -8
var screen_size
var can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	start(Vector2(screen_size.x/2, screen_size.y - Y_OFFSET))
	$BulletCooldown.wait_time = bullet_cooldown


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
	if (Input.is_action_pressed("shoot")):
		shoot()

func shoot():
	if not can_shoot:
		return
	can_shoot = false
	$BulletCooldown.start()
	var bullet = bullet_scene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.start(position + Vector2(0, BULLET_OFFSET))
	

func _on_body_entered(body):
	hit.emit()
	#$CollisionShapeShip.set_deferred("disable", true)

func start(pos : Vector2):
	position = pos
	#$CollisionShapeShip.disabled = false


func _on_bullet_cooldown_timeout():
	can_shoot = true
