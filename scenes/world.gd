extends Node2D

var time: float = 0.0
var minutes: int = 0
var seconds: int = 0
var msec: int = 0

func _enter_tree():
	Global.root = self

func _process(delta) -> void:
	time += delta
	msec = fmod(time, 1) * 100
	seconds = fmod(time, 60)
	minutes = fmod(time, 3600) / 60
	$TileMap/player/UIManager/Control/Minutes.text = "%02d:" % minutes
	$TileMap/player/UIManager/Control/Seconds.text = "%02d." % seconds
	$TileMap/player/UIManager/Control/Msecs.text = "%03d" % msec

func stop() -> void:
	set_process(false)

func get_time_formatted() -> String:
	return "%02d:%02d.%03d" % [minutes, seconds, msec]
