extends Node

var current_surface := "mundo1" 

func set_surface(surface: String) -> void:
	current_surface = surface

func get_footstep_sound() -> AudioStream:
	var path = "res://audio/pasos/%s.wav" % current_surface
	if ResourceLoader.exists(path):
		return load(path)
	else:
		push_warning("Missing footstep sound: " + path)
		return null
