extends State
class_name BlasketRocketLauncher

@export var enemy: CharacterBody2D
@export var rocket : PackedScene
var player: CharacterBody2D
var coolDownDone = false

func fire_rocket():
	var rocket_instance = rocket.instantiate()
	add_child(rocket_instance)
	var aim_node = enemy.get_node("aim")
	rocket_instance.global_position = aim_node.global_position
	rocket_instance.updateDirection(player)

func Enter():
	#print_debug("1")
	player = get_tree().get_first_node_in_group("Player")
	#var animation = enemy.get_node("AnimationPlayer")
	$"../../AnimationPlayer".play("shootDown")
	#print_debug(animation)
	#animation.play("shootDown")
	for i in range(4):
		$rocketCooldown.start()
		await $rocketCooldown.timeout
		fire_rocket()
		
	Transitioned.emit(self, "flameThrower")
