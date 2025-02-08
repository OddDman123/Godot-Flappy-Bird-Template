extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= 100 * delta
	
	if position.x <= -256:
		position.x = 0
