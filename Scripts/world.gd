extends Node2D

@onready var heartsContainer = $CanvasLayer/HealthContainer
@onready var player = $TileMap/Player
# Called when the node enters the scene tree for the first time.
func _ready():
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(heartsContainer.updateHearts)

