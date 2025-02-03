extends Panel

@onready var sprite = $Sprite2D
# Called when the node enters the scene tree for the first time.

func update(whole: bool):
	if whole: sprite.frame = 0
	else: sprite.frame = 2
