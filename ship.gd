extends Area2D

@export var speed = 150
@export var bullet_cooldown = 0.13
@export var bullet_scene: PackedScene
@onready var screen_size = get_viewport_rect().size
@onready var animation_player = $AnimationPlayer
signal hit

var Y_OFFSET = 100
var BULLET_OFFSET = -8
var can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	start(Vector2(screen_size.x/2, screen_size.y - Y_OFFSET))
	$BulletCooldown.wait_time = bullet_cooldown


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	position += input*speed*delta
	position = position.clamp(Vector2(16,16), screen_size - Vector2(16,16))
	if (Input.is_action_just_pressed("move_left")):
		animation_player.play("move_left")
	if (Input.is_action_just_released("move_left")):
		animation_player.play("move_left_reversed")
	if (Input.is_action_just_pressed("move_right")):
		animation_player.play("move_right")
	if (Input.is_action_just_released("move_right")):
		animation_player.play("move_right_reversed")
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
