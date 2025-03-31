extends State
class_name BlasketStun

@export var enemy: CharacterBody2D
var timer : Timer



#temporarily unused. Too add to later when finishing blastkets last state



# Upon moving to this state, initialize timer
# and stun enemy
func enter():
	print_debug("entered")
	#timer = Timer.new()
	#timer.wait_time = 1.0
	#timer.autostart = true
	#timer.timeout.connect(on_timer_finished)
	#add_child(timer)
	#enemy.stunned = true


# Upon leaving this state, clear and free all
# state relevant stuff
#func exit():
	#timer.stop()
	#timer.timeout.disconnect(on_timer_finished)
	#timer.queue_free()
	#timer = null
	#enemy.stunned = false


#func on_timer_finished():
	#if !try_chase():
		#Transitioned.emit(self, "position")
