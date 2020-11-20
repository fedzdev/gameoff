extends "res://Scripts/StateMachine.gd"

func _ready():
	add_state("idle")
	add_state("move")
	add_state("seen")
	add_state("chasing")
	add_state("stuck")
	call_deferred("set_state", states.idle)
	



func _state_logic(delta):
	get_node("../Label").text = str(states.keys()[state])




func _get_transition(delta):
	match state:
		states.idle:
			pass
		states.move:
			pass
		states.stuck:
			pass
		states.seen:
			pass
		states.shooting:
			pass


func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			pass
		states.move:
			pass
		states.stuck:
			pass
		states.seen:
			pass

func _exit_state(old_state, new_state):
	match old_state:
		states.idle:
			pass
		states.move:
			pass
		states.stuck:
			pass
		states.seen:
			pass
