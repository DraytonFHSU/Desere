extends State
class_name BlasketPosition

@export var enemy: CharacterBody2D
@export var move_speed := 40.0
var player: Player

func Enter():
	print_debug("entered!")
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(delta: float):
	#player = get_tree().get_first_node_in_group("Player") #dupe code because causes glitch otherwise? #but now its not doing that?
	var direction = player.global_position - enemy.global_position
	if direction.length() <= 150:
		Transitioned.emit(self, "rocketlauncher")
	if direction.length() > 150:
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2()
	
