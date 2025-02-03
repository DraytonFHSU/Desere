extends Area2D

@onready var shape = $CollisionShape2D

func enable():
	shape.set_deferred("disabled", false)
	
func disable():
	shape.set_deferred("disabled", true)
