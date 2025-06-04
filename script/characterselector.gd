extends CanvasLayer

const characters = [
	preload("res://Player/Skin1.png"),
	preload("res://Player/Skin2.png"),
	preload("res://Player/Skin3.png"),
	preload("res://Player/Skin4.png"),
	preload("res://Player/Skin5.png"),
]
var index_selection = 0
var char_portrait

func _ready():
	char_portrait = $Sprite2D
	update_portrait(index_selection)
	
func update_portrait(index):
	char_portrait.texture = characters[index]

func _on_button_left_pressed() -> void:
	if(index_selection > 0):
		index_selection -= 1
	elif(index_selection == 0):
		index_selection = characters.size()-1
	update_portrait(index_selection)

func _on_button_right_pressed() -> void:
	if(index_selection < characters.size()-1):
		index_selection += 1
	elif(index_selection == characters.size()-1):
		index_selection = 0
	update_portrait(index_selection)

func _on_button_ok_pressed() -> void:
	GameData.selected_skin_index = index_selection
	get_tree().change_scene_to_file("res://Scenes/Mundo.tscn")

func _input(event):
	if event.is_action_pressed("ui_pause"):
		MusicaGlobal.toggle_music()
	if(event.is_action_pressed("ui_accept")):
		_on_button_ok_pressed()
	elif(event.is_action_pressed("ui_cancel")):
		get_tree().change_scene_to_file("res://Scenes/mainmenu.tscn")
	elif(event.is_action_pressed("ui_right")):
		_on_button_right_pressed()
	elif(event.is_action_pressed("ui_left")):
		_on_button_left_pressed()
