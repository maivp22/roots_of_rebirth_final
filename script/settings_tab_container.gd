class_name Settings_Tab_Container
extends Control

@onready var exit_button: Button = $Exit_Button

signal exit_options_menu

	
func _ready():
	exit_button.pressed.connect(_on_exit_button_pressed)

func _on_exit_button_pressed() -> void:
	print("Botón de salir presionado!")
	get_tree().change_scene_to_file("res://Scenes/mainmenu.tscn")
	
	
func _input(event):
	if event.is_action_pressed("ui_pause"):
		MusicaGlobal.toggle_music()
