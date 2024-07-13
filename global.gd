extends Node

#Odpowiada za zbieranie punktów

var startingPoints = 0

var currentlevel = 1

var root = null

func spawnSoundEffect(bus:String, effect:Resource, pos:Vector2, randomPitch:bool, boost:float = 0.0, global = false) -> void:
	var newSoundEffect
	if !global:
		newSoundEffect = AudioStreamPlayer2D.new()
		newSoundEffect.position = pos
	else:
		newSoundEffect = AudioStreamPlayer.new()
		

	newSoundEffect.bus = bus
	newSoundEffect.stream = effect
	if boost:
		newSoundEffect.volume_db += boost
		
	if randomPitch:
		newSoundEffect.pitch_scale = randf_range(0.9, 1.1)    
		
	newSoundEffect.finished.connect(newSoundEffect.queue_free)
	root.add_child(newSoundEffect)
		
	newSoundEffect.play()
