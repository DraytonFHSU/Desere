class_name levelNameCard extends CanvasLayer

#var levelName: String = "default"
@export var levelNameTemp: String

func displayLevelName(levelName):
	#only seems to find this if the scene is local. Would like to make it so that I don't
	#have to copy and paste the whole scene every time though...
	$MarginContainer/VBoxContainer/sceneName.text = levelName
	visible = true
	$visibleTimer.start(3) 

func _on_visible_timer_timeout():
	visible = false
