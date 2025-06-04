extends "res://script/NivelBase.gd"

@onready var heartsContainer = $CanvasLayer/heartsContainer
@onready var player = $player

func _ready() -> void:
	MusicaGlobal.play_new_music("res://musica/mundoo.mp3")
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(heartsContainer.updateHearts)
	

func _on_inventoy_gui_closed() -> void:
	get_tree().paused = false


func _on_inventoy_gui_opened() -> void:
	get_tree().paused = true
