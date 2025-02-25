extends State
class_name BlasketRocketLauncher

@export var enemy: CharacterBody2D
@export var rocket : PackedScene

var player: CharacterBody2D

func fire_rocket():
	var rocket_instance = rocket.instantiate()
	add_child(rocket_instance)
	var aim_node = enemy.get_node("aim")
	rocket_instance.global_position = aim_node.global_position+Vector2(randf_range(-10, 10), randf_range(-10, 10))
	
	print_debug(rocket_instance.position)

func Enter():
	#print_debug("1")
	player = get_tree().get_first_node_in_group("Player")
	var animation = enemy.get_node("AnimationPlayer")
	fire_rocket()
	fire_rocket()
	fire_rocket()
	fire_rocket()
	Transitioned.emit(self, "idle")


#func Physics_Update(delta: float):
	#Transitioned.emit(self, "idle")
