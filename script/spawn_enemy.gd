extends Area2D

@onready var Enemy_Scene = preload("res://Scenes/enemy.tscn")
var bool_spawn = true

var enemigos = []  # La lista FIFO de enemigos activos
var max_enemigos = 10  # Número máximo de enemigos permitidos

var random = RandomNumberGenerator.new()

func _ready() -> void:
	random.randomize()

func _process(delta: float) -> void:
	spawn()

func spawn():
	if bool_spawn and enemigos.size() < max_enemigos:
		$cooldown.start()
		bool_spawn = false

		var enemy_instance = Enemy_Scene.instantiate()
		enemy_instance.position = Vector2(
			random.randi_range(82, 1200),
			random.randi_range(450, 1600)
		)
		enemy_instance.process_mode = Node.PROCESS_MODE_PAUSABLE
		add_child(enemy_instance)

		enemigos.append(enemy_instance)

func _on_cooldown_timeout():
	bool_spawn = true
