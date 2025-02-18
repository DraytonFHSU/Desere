class_name dash_Attack extends Area2D

@onready var shape = $CollisionShape2D

func _ready():
	pass
	#shape.set_deferred("disabled", true)

func enable():
	shape.set_deferred("disabled", false)
	
func disable():
	shape.set_deferred("disabled", true)
