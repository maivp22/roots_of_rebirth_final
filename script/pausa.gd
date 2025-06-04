extends CanvasLayer
	
func _on_boton_continuar_pressed() -> void:
	get_tree().paused = false
	self.visible = false
	MusicaGlobal.resume_music()


func _on_boton_salir_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/mainmenu.tscn")
	MusicaGlobal.play_new_music("res://musica/musica.mp3")
