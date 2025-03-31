extends Area2D

var direction : Vector2 = Vector2.UP
@export var speed: int = 20

var target

#on creation, ready the despawn timer
func _ready():
	$disappear.start()

#simple move function.
func _process(delta):
	translate(direction*speed*delta)

#makes the flame look at the player. Ran from BlasketFlameThrower to avoid bugs/constant following
func updateDirection(player):
	target = player.global_position+Vector2(randf_range(-50, 50), randf_range(-50, 50))
	look_at(target)
	direction = Vector2.RIGHT.rotated(rotation) #note to self, delete this and look_at and fix rotation
	$AnimationPlayer.play("flicker")

#used to check if this is an attack
#admittedly a bit scuffed, but fixes my hitbox bug for now
func attack():
	pass 

#remove instance from game after two seconds
func _on_disappear_timeout():
	queue_free()
