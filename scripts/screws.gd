extends Node2D


func _physics_process(delta):
	position.x -= 100 * delta
	
	if position.x < -25:
		queue_free()
