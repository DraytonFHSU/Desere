class_name Player extends CharacterBody2D

signal healthChanged

#child nodes
@onready var animations = $AnimationPlayer
@onready var hurt = $hurtAnimation
@onready var hurtBox = $hurtBox
@onready var hurtTimer = $hurtTimer
@onready var attack = $attack

#stats
@export var dashDistance: int = 40
@export var maxHealth: int = 6
@onready var currentHealth: int = maxHealth
@export var knockbackPower: int = 2000
@export var speed: int = 35

#various variables used in functions
var lastAnimDirection: String = "Down"
var isHurt: bool = false
var attackType: String = "dash"
var isDashing: bool = false

#normal movement
func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized() #get 
	velocity = moveDirection * speed
	
	if Input.is_action_just_pressed("ui_dash"):
		attackHandler()

#dash movement
func attackHandler():
	#if attackType == "dash":
		#attack.dashAttack()
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
	if isDashing: return #let the dash attack handle the animation while dashing
	if velocity.length() == 0: #stop player animation
		if animations.is_playing():
			animations.stop()
	else:
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
		
		animations.play("walk" + direction) #Corresponds to walkDown animation, etc.
		lastAnimDirection = direction

#func handleCollision(): #legacy code?
	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		#var collider = collision.get_collider()
	
func _physics_process(_delta):
	handleInput()
	move_and_slide()
	#handleCollision()
	updateAnimation()
	if !isHurt:
		for area in hurtBox.get_overlapping_areas():
			if area.name == "hitBox":
				hurtByEnemy(area)
	
func hurtByEnemy(area):
	currentHealth -= 1
	if currentHealth <= 0:
		currentHealth = maxHealth #change to game over
	healthChanged.emit(currentHealth) #transfer health over to the container
	isHurt = true
	knockback(area.get_parent().velocity)
	hurt.play("hurtBlink") #Invincibility-frames
	hurtTimer.start() 
	await hurtTimer.timeout
	hurt.play("RESET")
	isHurt = false
	
	
func knockback(enemyVelocity: Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection 
	move_and_slide()
