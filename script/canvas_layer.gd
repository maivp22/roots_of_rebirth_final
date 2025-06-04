extends CanvasLayer

@onready var inventory = $InventoryGui

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_inventory"):
		toggle_inventory()

func toggle_inventory():
	inventory.visible = not inventory.visible
	get_tree().paused = inventory.visible
