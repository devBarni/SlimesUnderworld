extends CharacterBody2D

var SPEED = -25.0
var facing_right = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	add_to_group("enemy")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if !$RayCast2D.is_colliding() && is_on_floor():
		flip()
	
	velocity.x = SPEED
	
	update_animation()
	move_and_slide()
	
func update_animation():
	animated_sprite_2d.play("default")
	


func _on_enemyhitbox_body_entered(body):
	if body.is_in_group("player"):
		queue_free()
func flip():
	facing_right = !facing_right
	scale.x = abs(scale.x) * -1
	if facing_right:
		SPEED = abs(SPEED)
	else:
		SPEED = abs(SPEED) *-1
