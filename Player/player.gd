extends CharacterBody2D

class_name Player

signal healthChanged


@export var dashDistance: int = 40
@onready var animations = $AnimationPlayer
@onready var hurt = $hurtAnimation
@onready var hurtTimer = $hurtTimer
@onready var attack = $attack

@export var maxHealth: int = 6
@onready var currentHealth: int = maxHealth

@export var knockbackPower: int = 2000

var lastAnimDirection: String = "Down"
var isHurt: bool = false
var enemyCollisions = []
var isDashing: bool = false

@export var speed: int = 35
func handleInput():
	#normal movement
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized() #get 
	velocity = moveDirection * speed
	
	if Input.is_action_just_pressed("ui_dash"):
		dashAttack()

#dash movement
func dashAttack():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	isDashing = true
	animations.play("dash" + lastAnimDirection)
	$SoundManager/dash1.play()
	attack.enable()
	collision_mask = 4 + 32 #bitwise for mask layers. 4 for undashable
	velocity = moveDirection * speed * dashDistance
	collision_mask = 1 + 4 + 32 #More easily seen here. enable layer 1 (player) and 
	await animations.animation_finished #wait till animation is finished to end attack
	animations.play("walk" + lastAnimDirection) #Corresponds to walkDown animation, etc.
	animations.stop()
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
		lastAnimDirection = direction

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
