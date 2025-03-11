extends BaseScene

@onready var heartsContainer = $Player/CanvasLayer/HealthContainer
@onready var camera = $FollowCam

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("Player")
	super()
	camera.follow_node = player
	heartsContainer.setMaxHearts(player.maxHealth) #set up health
	heartsContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(heartsContainer.updateHearts)
	player.attack.disable() #or else it starts active in a bugged state
