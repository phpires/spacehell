extends Node

@export var ship_health = 10
@export var alien_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_alien()
	$AlienTimer.start()
	pass # Replace with function body.

func _on_ship_hit():
	ship_health -= 1
	print(ship_health)
	if (ship_health <= 0):
		game_over()

func game_over():
	$Ship.queue_free()
	$AlienTimer.stop()

func _on_alien_timer_timeout():
	spawn_alien()
	pass # Replace with function body.

func spawn_alien():
	var alien = alien_scene.instantiate()
	add_child(alien)
