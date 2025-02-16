extends Camera2D

@export var tilemap: TileMap
@export var follow_node: Node2D

func _ready():
	var mapRect = tilemap.get_used_rect()
	var tileSize = tilemap.rendering_quadrant_size #renamed from cell_quadrant_size
	var worldSizeInPixels = mapRect.size * tileSize
	limit_right = worldSizeInPixels.x
	limit_bottom = worldSizeInPixels.y-16

func _process(delta):
	global_position = follow_node.global_position
