extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pitfall_body_entered(body):
	
	if body.is_in_group("player"):
		body.alive = false
		body.sprite.visible = false
		body.dead_text.visible = true
 
