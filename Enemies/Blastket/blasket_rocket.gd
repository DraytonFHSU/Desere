extends Area2D

var direction : Vector2 = Vector2.UP
@export var speed: int = 100

var target

func _process(delta):
	translate(direction*speed*delta)

#makes the rocket look at the player. Ran from BlasketRocket to avoid bugs/constant following
func updateDirection(player):
	target = player.global_position+Vector2(randf_range(-50, 50), randf_range(-50, 50))
	look_at(target)
	direction = Vector2.RIGHT.rotated(rotation)
	$AnimationPlayer.play("rocket")
	$SoundManager/rocketWoosh.pitch_scale = randf_range(1, 0.9)
	$SoundManager/rocketWoosh.play()

#used to check if this is an attack
#admittedly a bit scuffed, but fixes my hitbox bug for now
func attack():
	pass 

