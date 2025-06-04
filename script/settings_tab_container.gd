class_name Settings_Tab_Container
extends Control

@onready var exit_button: Button = $Exit_Button
@onready var volume_slider: HSlider = $TabContainer/Sonido/MarginContainer/VBoxContainer/VolumeSlider
var config = ConfigFile.new()
var config_path = "user://settings.cfg"
signal exit_options_menu
@onready var button_fullscreen: CheckButton = $TabContainer/Gráficos/MarginContainer/ScrollContainer/VBoxContainer/Button_Fullscreen
@onready var button_resolution: OptionButton = $TabContainer/Gráficos/MarginContainer/ScrollContainer/VBoxContainer/Button_Resolution
@onready var button_v_sync: CheckButton = $TabContainer/Gráficos/MarginContainer/ScrollContainer/VBoxContainer/Button_VSync
@onready var brillo_overlay = BrilloOverlay
@onready var brillo_rect: ColorRect = BrilloOverlay.get_node("ColorRect")

var resolutions = [
	Vector2i(1920, 1080),
	Vector2i(1600, 900),
	Vector2i(1366, 768),
	Vector2i(1280, 720),
	Vector2i(1024, 768)
]
func _ready():
	var is_fullscreen = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	button_fullscreen.button_pressed = is_fullscreen
	var err = config.load(config_path)
	if err == OK:
		var saved_volume = config.get_value("Audio", "volume", -30)  # -30 dB como predeterminado
		MusicaGlobal.set_volume(saved_volume)
		volume_slider.value = saved_volume
	else:
		volume_slider.value = MusicaGlobal.music_player.volume_db

	volume_slider.value_changed.connect(_on_volume_slider_value_changed)

	exit_button.pressed.connect(_on_exit_button_pressed)
	for res in resolutions:
		var label = str(res.x) + " x " + str(res.y)
		button_resolution.add_item(label)

	button_resolution.selected = 0
	button_resolution.item_selected.connect(_on_button_resolution_item_selected)
	button_v_sync.toggled.connect(_on_button_v_sync_toggled)
	var current_vsync = ProjectSettings.get_setting("display/window/vsync/vsync_mode") == 1
	button_v_sync.button_pressed = current_vsync


func _on_exit_button_pressed() -> void:
	print("Botón de salir presionado!")
	get_tree().change_scene_to_file("res://Scenes/mainmenu.tscn")
	
	
func _input(event):
	if event.is_action_pressed("ui_pause"):
		MusicaGlobal.toggle_music()


func _on_volume_slider_value_changed(value: float) -> void:
	MusicaGlobal.set_volume(value)
	config.set_value("Audio", "volume", value)
	config.save(config_path)


func _on_Button_Fullscreen_toggled(button_pressed):
	print("Botón presionado:", button_pressed)
	if button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		print("Se activó pantalla completa")
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_size(Vector2i(800, 600))
		print("Se activó modo ventana")


func _on_button_fullscreen_toggled(toggled_on: bool) -> void:
	print("Botón presionado:", toggled_on)
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		print("Se activó pantalla completa")
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_size(Vector2i(800, 600))
		print("Se activó modo ventana")


func _on_button_resolution_item_selected(index: int) -> void:
	var selected_res = resolutions[index]
	DisplayServer.window_set_size(selected_res)
	print("Resolución cambiada a:", selected_res)


func _on_button_v_sync_toggled(toggled_on: bool) -> void:
	if toggled_on:
		ProjectSettings.set_setting("display/window/vsync/vsync_mode", 1)
		print("V-Sync activado")
	else:
		ProjectSettings.set_setting("display/window/vsync/vsync_mode", 0)
		print("V-Sync desactivado")


func _on_brillo_slider_value_changed(value: float) -> void:
	var alpha = 1.0 - value / 100.0
	BrilloOverlay.get_node("ColorRect").color.a = alpha
	print("Brillo actualizado:", value, "% (alpha:", alpha, ")")
