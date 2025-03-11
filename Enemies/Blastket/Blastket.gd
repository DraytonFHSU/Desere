extends CharacterBody2D
class_name Blastket

@export var speed = 2
@export var limit = 0.5

@onready var animations = $AnimationPlayer

var target = null
var health = 25
var isDead = false
var isStunned = false

func updateAnimation():
	if velocity.length() == 0:
		if animations.is_playing():
			animations.play("RESET")
			animations.stop()
	else:
		var direction = "Down"
		if velocity.y < 0: direction = "Up"
		
		animations.play("walk" + direction) #Corresponds to walkDown animation, etc.

func _physics_process(_delta):
	if isDead: return
	move_and_slide()
	updateAnimation()

func _on_hurt_box_area_entered(_area):
	$SoundManager/hit1.play()
	health -= 1
	#isStunned.emit()
	print_debug(health)
	if health == 0:
		$hitBox.set_deferred("monitorable", false)
		isDead=true
		queue_free()


#func _on_start_body_entered(body):
	#if body is Player:
		#target = body

