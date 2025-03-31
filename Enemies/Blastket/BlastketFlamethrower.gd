extends State
class_name BlasketFlameThrower

@export var enemy: CharacterBody2D
@export var flame : PackedScene

var player: CharacterBody2D
var coolDownDone = false

func fire_flame():
	var flame_instance = flame.instantiate()
	add_child(flame_instance)
	var aim_node = enemy.get_node("aim")
	flame_instance.global_position = aim_node.global_position
	flame_instance.updateDirection(player)

func Enter():
	#print_debug("1")
	player = get_tree().get_first_node_in_group("Player")
	var animation = enemy.get_node("AnimationPlayer")
	animation.play("flameDown")
	for i in range(10):
		fire_flame() #1/60th of a second is probably fine.
		$flameCooldown.start()
		await $flameCooldown.timeout #using await here since I don't have to run anything else
	Transitioned.emit(self, "idle")
