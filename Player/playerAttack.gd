extends Node2D

var attack: Area2D

func _ready():
	if get_children().is_empty(): return
	attack = get_children()[0]
	
func enable():
	if !attack: return
	visible = true
	attack.enable()
	
func disable():
	if !attack: return
	visible = false
	attack.disable()
