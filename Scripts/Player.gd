extends KinematicBody2D


onready var gunnode = get_node("bulletaudio")


const Bullet = preload("res://Tests/Bullut.tscn")
const FRICTION = 0.1

var motion = Vector2()
var acceleration = 5
var velocity_multiplier = 1
var shooting_timer = false
var bullets = 120
var follow_on = false
var playing_reload_audio = false



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
	if Input.is_action_pressed("shoot"):
			if shooting_timer == false:
				if bullets > 0:
					bullets -= 1
					var bullut = Bullet.instance()
					bullut.position = get_node("Sprite/gun/Position2D").global_position
					bullut.rotation = get_angle_to(get_global_mouse_position()) -rand_range(-PI / 8, PI / 8)
					get_parent().add_child(bullut)
					shooting_timer = true
					get_node("bulletspawntimer").start()
					gunnode.play()
				elif bullets <= 0:
					if not playing_reload_audio:
						print("gotta reload")
						reload()
	
	
	if Input.is_action_just_pressed("guard"):
		get_tree().call_group("dumpy", "move_dumpy", self.global_position)
		follow_on = false
	if Input.is_action_just_pressed("follow"):
		if follow_on:
			follow_on = false
		elif not follow_on:
			follow_on = true
			
	if follow_on:
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
	
	if Input.is_action_just_pressed("reload"):
		reload()

func _on_bulletspawntimer_timeout():
	shooting_timer = false


func reload():
	bullets = 0
	get_node("reloadtimer").start()
	get_node("reloadaudio").play()
	playing_reload_audio = true
	

func _on_reloadtimer_timeout():
	bullets = 120


func _on_AudioStreamPlayer2D_finished():
	bullets = 120


func _on_reloadaudio_finished():
	playing_reload_audio = false
