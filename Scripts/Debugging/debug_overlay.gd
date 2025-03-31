extends CanvasLayer

#currently not working, VBoxContainer keeps not being found. Doesn't happen for other people
#maybe an update issue?

#current implementation by luckius at https://www.youtube.com/watch?v=2nnXfVA5Wgs
#Though if this implementation doesn't work ...

#@onready var container: VBoxContainer = $VBoxContainer
#@onready var panel = preload("res://Scenes/Debugging/debug_panel.tscn")
#var nodes: Dictionary = {}
#var panels: Array[DebugPanel] = []
#
#func _ready() -> void:
	#await get_tree().process_frame
	#for node in nodes:
		#_create_panel(node)
#
#func _process(delta: float) -> void:
	#_update_all_panels()
#
#func add(node: Node, variable: String) -> void:
	#if nodes.has(node):
		#var variables = nodes[node]
		#variables.append(variable)
	#else:
		#var variables: Array[String] = [variable]
		#nodes[node] = variables
#
#func _create_panel(node: Node) -> void:
	#var inst: DebugPanel = panel.instantiate()
	#container.add_child(inst)
#
	#var variables = nodes[node]
	#inst.title.text = node.name
#
	#for variable in variables:
		#inst.values.text += "%s: %s\n" % [variable, node.get(variable)]
#
	#panels.append(inst)
#
#func _update_all_panels() -> void:
	#var index: int = 0
	#for node in nodes:
		#var variables: Array[String] = nodes[node]
		#var panel: DebugPanel = panels[index]
		#panel.values.text = "" # Clear all text
#
		#for variable in variables:
			#panel.values.text += "%s: %s\n" % [variable, node.get(variable)]
#
		#index += 1
