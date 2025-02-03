extends CharacterBody2D

@export var speed = 20
@export var limit = 0.5

@onready var animations = $AnimationPlayer

var health = 4
var isDead = false

func _ready():
	pass
	
	
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
	move_and_slide()
	updateAnimation()

func _on_hurt_box_area_entered(_area):
	health -= 1
	print_debug(health)
	if health == 0:
		$hitBox.set_deferred("monitorable", false)
		isDead=true
		queue_free()
