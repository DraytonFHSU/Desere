extends State
class_name BlasketPosition

@export var enemy: CharacterBody2D
@export var move_speed := 40.0
var player: Player

func Enter():
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(_delta: float):
	var direction = player.global_position - enemy.global_position
	#check move away from player if they are close, towards if far away
	#I considered Match statements, as they are supposed to work like switches, 
	#but they don't appear to like comparision operators
	if direction.length() <= 125:
		enemy.velocity = direction.normalized() * move_speed * -1.5
	elif direction.length() <= 170 and direction.length()>125:
		enemy.velocity *= 0
		Transitioned.emit(self, "rocketlauncher")
	elif direction.length() > 170:
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2()
	
