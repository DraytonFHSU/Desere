class_name BaseScene extends Node

@onready var player: Player
@onready var entrance_markers: Node2D = $EntranceMarkers

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	if scene_manager.player:
		if player:
			player.queue_free()
		
		player = scene_manager.player
		add_child(player)
	positionPlayer()
	

func positionPlayer():
	var last_scene = scene_manager.last_scene_name
	if last_scene.is_empty():
		last_scene = "spawn"
	for entrance in entrance_markers.get_children():
		if entrance is Marker2D and entrance.name=="spawn" or entrance.name==last_scene:
			player.global_position = entrance.global_position
	
