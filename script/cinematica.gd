extends Control

const escenas = {
	0: {
		"fondo":"res://Cinematica/Escena1.png" ,
		"dialogos": [
			"El planeta no cayó por un impacto… sino por olvido.",
			"Por siglos, ignoramos los susurros de la Tierra.",
			"Su calor, su agua, su ritmo… todo se rompió."
		]
	},
	1: {
		"fondo":"res://Cinematica/Escena2.png" ,
		"dialogos": [
			"El aire cambió. Las lluvias dejaron de caer.",
			"Las estaciones se confundieron, la vida desapareció lentamente.",
			"Y entonces… el silencio."
		]
	},
	2: {
		"fondo":"res://Cinematica/Escena3.png",
		"dialogos": [
			"La Tierra se fragmentó en tres mundos aislados.",
		]
	},
	3: {
		"fondo":"res://Cinematica/Escena4.png" ,
		"dialogos": [
			"En cada uno sobrevive una pequeña chispa de esperanza.",
			"Si encuentras eso fragmentos... aún puedes restaurarlo todo.",
			"Tú has sido elegido. No para luchar, sino para sanar.",
			"Completa las misiones de cada bioma. Devuelve lo que se perdió.",
			"Cuando unas los fragmentos… la vida podrá volver. ¿Estás listo?"
		]
	},
}
# Variables de control
var escena_actual = 0
var dialog_index = 0
var tween: Tween

@onready var fondo = $Fondo
@onready var label = $Panel/RichTextLabel
@onready var button = $Panel/Button_next
@onready var fade_anim = $AnimationPlayer
@onready var overlay = $FadeOverlay


		
func _ready():
	start(0)
	MusicaGlobal.play_new_music("res://musica/cinematica.mp3")

	
# Empieza una escena cinematográfica
func start(id):
	escena_actual = id
	dialog_index = 0
	visible = true
	update_fondo()
	speak()
	

func update_fondo():
	var fondo_path = escenas[escena_actual]["fondo"]
	fondo.texture = load(fondo_path)


func speak():
	label.visible_ratio = 0
	var dialogos = escenas[escena_actual]["dialogos"]
	label.text = dialogos[dialog_index]
	tween = create_tween()
	var animation_speed = 0.05 * label.text.length()
	tween.tween_property(label,"visible_ratio",1,animation_speed)
	dialog_index += 1
	
	

func next():
	if(tween.is_running()):
		tween.kill()
		label.visible_ratio = 1
		return
		
	var dialogos = escenas[escena_actual]["dialogos"]
	if(dialog_index < dialogos.size()):
		speak()
	else:
		escena_actual += 1
		if escenas.has(escena_actual):
			start(escena_actual) 
		else:
			end_cinematic()  


func end_cinematic():
	fade_anim.play("fade_to_black")          
	await fade_anim.animation_finished  
	get_tree().change_scene_to_file("res://Scenes/characterselector.tscn")  



func _input(event):
	if event.is_action_pressed("ui_pause"):
		MusicaGlobal.toggle_music()
	if event.is_action_released("ui_accept"):
		next()


func _on_button_pressed() -> void:
	next()


func _on_saltar_pressed() -> void:
	fade_anim.play("fade_to_black")          
	await fade_anim.animation_finished  
	get_tree().change_scene_to_file("res://Scenes/characterselector.tscn")
