extends CharacterBody2D

@export var speed = 20
@export var limit = 0.5
@export var endPoint: Marker2D

@onready var animations = $AnimationPlayer

var startPosition
var endPosition
var health = 4
var isDead = false

func _ready():
	startPosition = position
	endPosition = endPoint.global_position

func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd

func updateVelocity():
	var moveDirection = (endPosition - position)
	if moveDirection.length() < limit:
		changeDirection()
	velocity = moveDirection.normalized()*speed
	
func updateAnimation():
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
		
		animations.play("walk" + direction) #Corresponds to walkDown animation, etc.

func _physics_process(_delta):
	if isDead: return
	updateVelocity()
	move_and_slide()
	updateAnimation()


func _on_hurt_box_area_entered(_area):
	#if area.name=="dashAttack":
	$SoundManager/hit1.pitch_scale = randf_range(1, 0.9)
	$SoundManager/hit1.play()
	health -= 1
	if health == 0:
		$hitBox.set_deferred("monitorable", false)
		isDead=true
		queue_free()
