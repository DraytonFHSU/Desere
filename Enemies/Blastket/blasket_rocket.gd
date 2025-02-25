extends Area2D

var direction : Vector2 = Vector2.LEFT
@export var speed: int = 100

func _process(delta):
	translate(direction*speed*delta)


