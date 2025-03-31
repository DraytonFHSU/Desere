class_name spinDashAttack extends Area2D

@onready var shape = $CollisionPolygon2D
@onready var animations = $AnimationPlayer

func _ready():
	visible = false
	shape.set_deferred("disabled", true)
	
func enable():
	visible = true
	shape.set_deferred("disabled", false)
	animations.play("spin")
	
func disable():
	visible = false
	shape.set_deferred("disabled", true)
