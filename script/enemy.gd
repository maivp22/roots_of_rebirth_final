extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

var speed = 70
var player_chase = false
var player = null
var last_direction = "front"
var last_flip_h = false

var patrol_direction = Vector2(1, 0)
var patrol_speed = 40
var patrol_range = 100
var patrol_origin = Vector2()

var skins = [
	preload("res://Enemy/Chomb1.tres"),
	preload("res://Enemy/Chomb2.tres"),
	preload("res://Enemy/Chomb3.tres"),
]

func _ready():
	patrol_origin = position
	animated_sprite.sprite_frames = skins[randi() % skins.size()]

func _physics_process(delta: float):
	if player_chase and player != null:
		var direction = player.position - position
		var move_direction = direction.normalized()
		position += move_direction * speed * delta
		animar(move_direction)
	else:
		patrullar(delta)

func patrullar(delta):
	position += patrol_direction * patrol_speed * delta
	if position.distance_to(patrol_origin) > patrol_range:
		patrol_direction *= -1
	animar(patrol_direction)

func animar(direction: Vector2):
	if abs(direction.x) > abs(direction.y):
		animated_sprite.play("side_walk")
		animated_sprite.flip_h = direction.x > 0
	elif direction.y < 0:
		animated_sprite.play("back_walk")
		animated_sprite.flip_h = false
	else:
		animated_sprite.play("front_walk")
		animated_sprite.flip_h = false

func _on_detection_area_body_entered(body: Node2D):
	if body.name == "player":
		player = body
		player_chase = true

func _on_detection_area_body_exited(body: Node2D):
	if body == player:
		player = null
		player_chase = false
