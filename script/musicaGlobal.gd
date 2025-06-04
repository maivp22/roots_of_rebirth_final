extends Node

@onready var music_player: AudioStreamPlayer = AudioStreamPlayer.new()
var config = ConfigFile.new()
var config_path = "user://settings.cfg"

var is_paused = false
var current_tween = null



func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	music_player.stream = preload("res://musica/musica.mp3")
	add_child(music_player)
	var err = config.load(config_path)
	if err == OK:
		var saved_volume = config.get_value("Audio", "volume", -30)
		set_volume(saved_volume)
   
	music_player.play()
	fade_in()
	
func set_volume(value_db):
	music_player.volume_db = value_db

func toggle_music():
	is_paused = !is_paused
	music_player.stream_paused = is_paused

func pause_music():
	music_player.stream_paused = true

func resume_music():
	music_player.stream_paused = false

func stop_music():
	music_player.stop()

func play_new_music(path):
	fade_out(path)


func fade_in():
	if current_tween:
		current_tween.kill()
	current_tween = create_tween()
	current_tween.tween_property(music_player, "volume_db", -1, 2.0)


func fade_out(next_song = ""):
	if current_tween:
		current_tween.kill()
	current_tween = create_tween()
	current_tween.tween_property(music_player, "volume_db", -40, 2.0)
	current_tween.tween_callback(func():
		if next_song != "":
			music_player.stream = load(next_song)
			music_player.play()
			fade_in()
		else:
			music_player.stop()
)
