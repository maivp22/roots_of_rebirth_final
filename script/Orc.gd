extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

var speed = 70
var player_chase = false
var player = null

var patrol_direction = Vector2(1, 0)  # Movimiento horizontal
var patrol_speed = 50
var patrol_range = 150
var patrol_origin = Vector2()

func _ready():
	patrol_origin = position
	animated_sprite.play("idle")

func _physics_process(delta: float):
	if player_chase and player != null:
		var direction = player.position - position
		var move_direction = Vector2(direction.x, 0).normalized()  # Solo horizontal
		position += move_direction * speed * delta
		# Animar persecución
		if move_direction.x != 0:
			animated_sprite.play("side_walk")
			animated_sprite.flip_h = move_direction.x < 0
		else:
			animated_sprite.play("idle")
	else:
		patrullar(delta)

func patrullar(delta):
	position += patrol_direction * patrol_speed * delta
	if position.distance_to(patrol_origin) > patrol_range:
		patrol_direction *= -1
	
	animated_sprite.play("side_walk")
	animated_sprite.flip_h = patrol_direction.x < 0

func _on_detection_area_body_entered(body: Node2D):
	if body.name == "Player":
		player = body
		player_chase = true

func _on_detection_area_body_exited(body: Node2D):
	if body == player:
		player = null
		player_chase = false
		patrol_origin = position
