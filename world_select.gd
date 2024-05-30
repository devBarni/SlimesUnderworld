extends Node

# Sygnały łączące logikę.
func _ready():
	$Control/Map1.mouse_entered.connect(button_mouse_entered.bind($Control/Map1))
	$Control/Map2.mouse_entered.connect(button_mouse_entered.bind($Control/Map2))
	$Control/Map3.mouse_entered.connect(button_mouse_entered.bind($Control/Map3))
	$Control/Map1.pressed.connect(stage_select.bind($Control/Map1.name))
	$Control/Map2.pressed.connect(stage_select.bind($Control/Map2.name))
	$Control/Map3.pressed.connect(stage_select.bind($Control/Map3.name))
	
func button_mouse_entered(button):
	$Control/HeroIcon.global_position = button.global_position + Vector2(20,40)
	
# Poniżej system zmiany plansz
func stage_select(world):
	match(world):
		"Map1":
			get_tree().change_scene_to_file("res://scenes/world.tscn")
		"Map2":
			get_tree().change_scene_to_file("res://scenes/World2.tscn")
		"Map3":
			get_tree().change_scene_to_file("res://scenes/World3.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
