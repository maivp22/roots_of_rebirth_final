class_name MainMenu
extends CanvasLayer

@onready var button_continue: Button = $Button_continue
@onready var button_exit: Button = $Button_exit
@onready var button_start: Button = $Button_start
@onready var button_options: Button = $Button_Options



@onready var start_level = preload("res://Scenes/cinematica.tscn") as PackedScene
@onready var options_scene = preload("res://Scenes/Settings_Tab_Container.tscn") as PackedScene

func _ready():
	handle_connecting_signals()
	if !MusicaGlobal.music_player.playing:
		MusicaGlobal.music_player.play()

func handle_connecting_signals()-> void:
	button_start.button_down.connect(on_start_pressed)
	button_exit.button_down.connect(on_exit_pressed)
	button_options.button_down.connect(on_options_pressed)
	
func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)
	
func on_exit_pressed() -> void:
	get_tree().quit()
	
func on_options_pressed() -> void:
	get_tree().change_scene_to_packed(options_scene)
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		on_start_pressed()
	if event.is_action_pressed("ui_pause"):
		MusicaGlobal.toggle_music()

		
