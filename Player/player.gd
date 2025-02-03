extends CharacterBody2D

class_name Player

signal healthChanged

@export var speed: int = 35
@export var dashDistance: int = 40
@onready var animations = $AnimationPlayer
@onready var hurt = $hurtAnimation
@onready var hurtTimer = $hurtTimer
@onready var attack = $attack

@export var maxHealth: int = 6
@onready var currentHealth: int = maxHealth

@export var knockbackPower: int = 500

var lastAnimDirection: String = "Down"
var isHurt: bool = false
var enemyCollisions = []
var isDashing: bool = false

func handleInput():
	#normal movement
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") #get 
	#var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	velocity = moveDirection * speed
	
	if Input.is_action_just_pressed("ui_dash"):
		dashAttack()

#dash movement
func dashAttack():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	animations.play("dash" + lastAnimDirection)
	isDashing = true
	attack.enable()
	collision_mask = 4 + 8 #bitwise for mask layers. 4 for undashable, 8 for hitboxes 
	#if moveDirection == 0:
		#velocity = moveDirection * speed * dashDistance #to correct: need to make dash go in deirection last
	#else:
	velocity = moveDirection * speed * dashDistance
	collision_mask = 1 + 4 #More easily seen here. enable layer 1 and 3
	await animations.animation_finished
	attack.disable()
	isDashing = false
		
	
func updateAnimation():
	if isDashing: return
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
		
		animations.play("walk" + direction) #Corresponds to walkDown animation, etc.

func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
	
func _physics_process(_delta):
	handleInput()
	move_and_slide()
	handleCollision()
	updateAnimation()
	if !isHurt:
		for enemyArea in enemyCollisions:
			hurtByEnemy(enemyArea)
	
func hurtByEnemy(area):
	currentHealth -= 1
	if currentHealth <= 0:
		currentHealth = maxHealth
	healthChanged.emit(currentHealth)
	isHurt = true
	knockback(area.get_parent().velocity)
	hurt.play("hurtBlink")
	hurtTimer.start()
	await hurtTimer.timeout
	hurt.play("RESET")
	isHurt = false
	
func _on_hurt_box_area_entered(area):
	if area.name == "hitBox":
		enemyCollisions.append(area)

func _on_hurt_box_area_exited(area):
	enemyCollisions.erase(area)
	
func knockback(enemyVelocity: Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection 
	move_and_slide()
