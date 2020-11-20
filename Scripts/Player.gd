extends KinematicBody2D


var CurrentGun
onready var Hands = get_node("hand")

const Pistol = preload("res://Scenes/Pistol.tscn")
const SMG = preload("res://Scenes/SMG.tscn")
const Snyipert = preload("res://Scenes/Snyipert.tscn")
const Bullet = preload("res://Tests/Bullut.tscn")
const Gernade = preload("res://Tests/Gernade.tscn")
const FRICTION = 0.1

var motion = Vector2()
var acceleration = 5
var velocity_multiplier = 1
var grenades = 3
var follow_on = false
var playing_reload_audio = false
var target = get_global_mouse_position()


func _ready():
	global_gun_number()
	CurrentGun = get_node("hand").get_child(0)
	position_gun()


func _physics_process(delta):
	update_player_input(delta)
	move_and_slide(motion * velocity_multiplier)

	change_look()



func change_look():
	if get_local_mouse_position().x > 0:
		if not CurrentGun == null:
			get_node("Sprite").scale.x = 3
			CurrentGun.scale.x = 1
			CurrentGun.flip_v = false
			CurrentGun.position.x = CurrentGun.must_position
			if CurrentGun.has_method("MustOffset"):
				CurrentGun.BarrelPoint.position.y = -CurrentGun.must_offset
			CurrentGun.rotation_degrees = rad2deg(get_angle_to(get_global_mouse_position()))

	if get_local_mouse_position().x < 0:
		if not CurrentGun == null:
			get_node("Sprite").scale.x = -3
			CurrentGun.scale.x = 1
			CurrentGun.flip_v = true
			CurrentGun.position.x = -CurrentGun.must_position
			if CurrentGun.has_method("MustOffset"):
				CurrentGun.BarrelPoint.position.y = CurrentGun.must_offset
			CurrentGun.rotation_degrees = rad2deg(get_angle_to(get_global_mouse_position()))




func update_player_input(delta):
	if Input.is_action_pressed("shoot"):
		if not CurrentGun == null:
			target = get_global_mouse_position()
			CurrentGun.shoot(target)
	if Input.is_action_just_pressed("throw"):
		if grenades > 0:
			grenades -= 1
			var gernade = Gernade.instance()
			gernade.position = get_node("Sprite/gun/Position2D").global_position
			gernade.rotation = get_angle_to(get_global_mouse_position()) 
			get_parent().add_child(gernade)
	
	if Input.is_action_just_pressed("swap_left"):
		swap_gun("left")
	if Input.is_action_just_pressed("swap_right"):
		swap_gun("right")
	if Input.is_action_just_pressed("guard"):
		get_tree().call_group("Companion", "move_to_pos", self.global_position)
		follow_on = false
	if Input.is_action_just_pressed("follow"):
		if follow_on:
			follow_on = false
		elif not follow_on:
			follow_on = true
			
	if follow_on:
		get_tree().call_group("Companion", "move_to_pos", self.global_position)
	
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
		CurrentGun.reload()


func position_gun():
	pass
#	if CurrentGun.name == "SMG":
#		CurrentGun.offset.x = 13
#		CurrentGun.position.y = 7
#	if CurrentGun.name == "Pistol":
#		CurrentGun.position.y = 13
#	if CurrentGun.name == "Snyipert":
#		CurrentGun.offset.x = 18
#		CurrentGun.position.y = 4
		
	

var gun_number = Global.gun_equip.size()
var current_gun = 1
func swap_gun(input):
	if input == "left":
		current_gun -= 1
		if current_gun < 0:
			current_gun = 2
		global_gun_number()
	if input == "right":
		current_gun += 1
		if current_gun > 2:
			current_gun = 0
		global_gun_number()
	position_gun()

func equip_gun_to_number(Gun):
	remove_from_hand()
	var gun_inst = Gun.instance()
	Hands.add_child(gun_inst)
	CurrentGun = gun_inst


func remove_from_hand():
	if not CurrentGun == null:
		CurrentGun.queue_free()

func global_gun_number():
	Global.gun_equip[current_gun]
	if Global.gun_equip[current_gun] == 1:
		equip_gun_to_number(Pistol)
	if Global.gun_equip[current_gun] == 2:
		equip_gun_to_number(SMG)
	if Global.gun_equip[current_gun] == 3:
		equip_gun_to_number(Snyipert)
