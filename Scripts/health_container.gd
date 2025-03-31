extends HBoxContainer

@onready var HeartGuiClass = preload("res://Scenes/heart_gui.tscn")

func setMaxHearts(maxHealth: int):
	for i in range(maxHealth):
		var heart = HeartGuiClass.instantiate()
		add_child(heart)

func updateHearts(currentHealth: int):
	var hearts = get_children()
	
	for i in range(currentHealth):
		hearts[i].update(true)
	for i in range(currentHealth, hearts.size()):
		hearts[i].update(false)
	
