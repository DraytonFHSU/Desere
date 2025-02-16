extends BaseScene

@onready var heartsContainer = $CanvasLayer/HealthContainer
@onready var camera = $FollowCam

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	camera.follow_node = player
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(heartsContainer.updateHearts)
	player.attack.disable()
