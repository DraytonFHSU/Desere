class_name dash_Attack extends Area2D

@onready var shape = $CollisionShape2D

func _ready():
	visible = false #visible by default, creating a ghost attack animation that does no damage
	#pass

func enable():
	visible = true
	shape.set_deferred("disabled", false)
	
func disable():
	visible = false
	shape.set_deferred("disabled", true)
