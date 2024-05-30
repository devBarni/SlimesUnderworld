extends CharacterBody2D


const SPEED = 80.0
var JUMP_VELOCITY = -240.0
var firstJUMP_VELOCITY = -200.0
var alive = true

#zliczanie skoków
var jump_count = 0
var first_jump = 1
var max_jumps = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite = $AnimatedSprite2D
@onready var dead_text = $DeadText

func _ready():
	add_to_group("player")

func _physics_process(delta):
	if alive:
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta
		
		if is_on_floor():
			jump_count = 0
		
		# Handle Jump.
		if Input.is_action_just_pressed("up") and jump_count < max_jumps:
			velocity.y = JUMP_VELOCITY
			jump_count +=1
			$AnimatedSprite2D/AudioStreamPlayer2D.play()
		if Input.is_action_just_pressed("up") and jump_count == first_jump:
			velocity.y = firstJUMP_VELOCITY
			$AnimatedSprite2D/AudioStreamPlayer2D.play()

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if is_on_floor() && direction != 0:
			sprite.play('run')
		elif is_on_floor():
			sprite.play('idle')
		elif !is_on_floor():
			sprite.play('jump')
			
		if direction < 0:
			sprite.flip_h = true
		elif direction > 0:
			sprite.flip_h = false
			
		move_and_slide()
	else:
		
		if Input.is_action_just_pressed("restart"):
			get_tree().reload_current_scene()

# Śmierć bohatera (po wejściu na kolce) oraz schowanie go, wyświetlenie
# ekranu restartu
func _on_area_2d_body_entered(body):
	alive = false
	sprite.visible = false
	dead_text.visible = true
	Global.startingPoints = 0

# Aktualizacja interfejsu z punktami 
@onready var point_count = $UIManager/Displaycoins
func updatePointCount():
	point_count.text = str(Global.startingPoints)
	
# Śmierć bohatera po zetknięciu z przeciwnikiem
func _on_playerhitbox_body_entered(body):
	
	if body.is_in_group("enemy"):
		
		alive = false
		sprite.visible = false
		dead_text.visible = true
		Global.startingPoints = 0

func _on_transition_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://world_select.tscn")
