class_name spinDashAttack extends Area2D

@onready var shape = $CollisionPolygon2D
@onready var animations = $AnimationPlayer

func _ready():
	shape.set_deferred("disabled", true)
	
func enable():
	shape.set_deferred("disabled", false)
	animations.play("spin")
	
func disable():
	shape.set_deferred("disabled", true)
