extends "res://Scripts/StateMachine.gd"

func _ready():
	add_state("idle")
	add_state("move")
	add_state("seen")
	add_state("stuck")
	add_state("shooting")
	call_deferred("set_state", states.idle)
	



func _state_logic(delta):
	get_node("../Label").text = str(states.keys()[state])




func _get_transition(delta):
	match state:
		states.idle:
			if not parent.velocity == Vector2(0,0):
				return states.move
			if parent.velocity == Vector2(0,0) and parent.has_command:
				return states.stuck
			if parent.target != null:
				return states.shooting
		states.move:
			if parent.velocity == Vector2(0,0) and parent.has_command:
				return states.idle
			if parent.stuck == true and parent.velocity == Vector2(0, 0):
				return states.stuck
		states.stuck:
			if parent.velocity == Vector2(0,0) and not parent.has_command:
				return states.idle
			if not parent.velocity == Vector2(0,0) and parent.has_command:
				return states.move
		states.seen:
			pass
		states.shooting:
			if parent.target == null:
				print("nulltarget")
				return states.idle


func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			pass
		states.move:
			pass
		states.stuck:
#			parent.move_back()
			pass
		states.seen:
			pass
		states.shooting:
			pass

func _exit_state(old_state, new_state):
	match old_state:
		states.idle:
			pass
		states.move:
			parent.anim_node.play("collision_det_shaper")
		states.stuck:
			pass
		states.seen:
			pass
		states.shooting:
			pass
	pass
