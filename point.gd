extends Area2D

var is_collected = false

func _on_body_entered(body):
	if body.name == "player" and not is_collected:
		is_collected = true
		$AudioStreamPlayer2D.play()
		Global.startingPoints += 1
		body.updatePointCount()
		hide()
