extends Area2D

func _on_body_entered(body):
	if body.has_signal("hit"):
		body.hit.emit()


func _on_score_box_body_entered(body):
	## Checks whether or not the body actually has the signal before emiting the signal
	## While the check may not be needed for this small project, it is a good habit to have for larger ones
	if body.has_signal("scored"):
		body.scored.emit()
	
