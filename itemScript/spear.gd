extends "res://itemScript/collectable.gd"

@onready var animations = $AnimationPlayer

func collect(inventory: Inventory):
	animations.play("rotation")
	await  animations.animation_finished
	super(inventory)
