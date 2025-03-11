extends CharacterBody2D

class_name Zombie

@export var speed = 2
@export var limit = 0.5

@onready var animations = $AnimationPlayer

var target = null
var health = 4
var isDead = false

func update_velocity():
	if !target: return
	velocity = (target.position - position) / speed
	
func updateAnimation():
	if velocity.length() == 0:
		if animations.is_playing():
			animations.play("RESET")
			animations.stop()
	else:
		var direction = "Down"
		#if velocity.x < 0: direction = "Left"
		#elif velocity.x > 0: direction = "Right"
		if velocity.y < 0: direction = "Up"
		
		animations.play("walk" + direction) #Corresponds to walkDown animation, etc.

func _physics_process(_delta):
	if isDead: return
	update_velocity()
	move_and_slide()
	updateAnimation()

func _on_hurt_box_area_entered(_area):
	$SoundManager/hit1.play()
	health -= 1
	if health == 0:
		$hitBox.set_deferred("monitorable", false)
		isDead=true
		queue_free()


func _on_detection_area_body_entered(body):
	if body is Player:
		target = body


func _on_detection_area_body_exited(_body):
	velocity -= velocity
	target = null
