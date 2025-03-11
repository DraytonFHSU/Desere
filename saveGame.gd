extends Node2D

var save_path = "user://variable.save"
var variable1 = 'test1'

func _onready():
	load_data()

func save_data():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(variable1)
	print_debug(save_path)
	print(OS.get_data_dir())
	file.close()

func load_data():
	var file = FileAccess.open(save_path, FileAccess.READ)
	file.store_var(variable1)
	file.close()

func _on_body_entered(body):
	save_data()
