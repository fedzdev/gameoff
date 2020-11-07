extends KinematicBody2D


const Bullet = preload("res://Tests/Bullut.tscn")
const FRICTION = 0.1

var motion = Vector2()
var acceleration = 5
var velocity_multiplier = 1
var shooting_timer = false
var bullets = 12



func _physics_process(delta):
	update_player_input(delta)
	move_and_slide(motion * velocity_multiplier)

	change_look()
	
func change_look():
	if get_local_mouse_position().x > 0:
		get_node("Sprite").scale.x = 3
		get_node("Sprite/gun").look_at(get_global_mouse_position())

	elif get_local_mouse_position().x < 0:
		get_node("Sprite").scale.x = -3
		get_node("Sprite/gun").look_at(get_global_mouse_position())



func update_player_input(delta):
	get_tree().call_group("dumpy", "move_dumpy", self.global_position)
	if Input.is_action_pressed("shoot"):
			if shooting_timer == false:
				if bullets > 0:
					bullets -= 1
					var bullut = Bullet.instance()
					bullut.position = get_node("Sprite/gun/Position2D").global_position
					bullut.rotation = get_angle_to(get_global_mouse_position())
					get_parent().add_child(bullut)
					shooting_timer = true
					get_node("Timer").start()
				elif bullets <= 0:
					print("gotta reload")
	if Input.is_action_just_pressed("follow"):
		get_tree().call_group("dumpy", "move_dumpy", self.global_position)
	
	if Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		motion.y = clamp((motion.y - acceleration), -Global.max_speed, 0)
	elif Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up"):
		motion.y = clamp((motion.y + acceleration), 0, Global.max_speed)
	else:
		motion.y = lerp(motion.y, 0, FRICTION)
		
	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		motion.x = clamp((motion.x - acceleration), -Global.max_speed, 0)
	elif Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		motion.x = clamp((motion.x + acceleration), 0, Global.max_speed)
	else:
		motion.x = lerp(motion.x, 0, FRICTION)


func _on_Timer_timeout():
	shooting_timer = false
