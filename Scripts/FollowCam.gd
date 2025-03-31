extends Camera2D

@export var tilemap: TileMap
@export var follow_node: Player

func _ready():
	#on load, get the tilemap that was put in the followcam and measure it to find limits for the camera
	var mapRect = tilemap.get_used_rect()
	var tileSize = tilemap.rendering_quadrant_size #renamed from cell_quadrant_size
	var worldSizeInPixels = mapRect.size * tileSize #currently only does rectangles
	limit_right = worldSizeInPixels.x
	limit_bottom = worldSizeInPixels.y

func _process(_delta):
	follow_node = get_tree().get_first_node_in_group("Player") #get player from group 
	global_position = follow_node.global_position #set camera to player. Allows for different camera sizes

