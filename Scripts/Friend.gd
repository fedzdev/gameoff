extends KinematicBody2D


const Pistol = preload("res://Scenes/Pistol.tscn")
const SMG = preload("res://Scenes/SMG.tscn")
const Snyipert = preload("res://Scenes/Snyipert.tscn")
const Bullet = preload("res://Tests/Bullut.tscn")

onready var anim_node = get_node("AnimationPlayer")

var id

var moving = false
var speed : = 200
var path : = PoolVector2Array() setget set_path
var motion = Vector2()

# NEW SHIT
var prev_pos = position
var velocity = Vector2(0,0)
var list = []
var empty
var stuck = false
var has_command = false
var stored_move_pos
var casting = false
var bodyy = null
var CurrentGun
var target
var gun

func _ready() -> void:
	set_process(false)
	if not gun == null:
		give_gun(gun)
	
func _physics_process(delta):
	velocity = (position - prev_pos).round()
	prev_pos = position
	if motion == empty:
		list.append(motion)
		if list.size() >= 10:
			stuck = true
		elif list.size() < 10:
			stuck = false
	else:
		list.clear()
	empty = motion
	if casting:
		get_node("RayCast2D").set_cast_to((bodyy.global_position - self.global_position))
#	if Input.is_action_pressed("shoot"):
	if not bodyy == null:
#		print(bodyy.name)
		if not get_node("RayCast2D").is_colliding():
			target = bodyy.position
			CurrentGun.shoot(target)
	else:
		target = null
	change_look()

func change_look():
	if not target == null: 
		if target.x - self.position.x > 0:
				get_node("Sprite").scale.x = 3
				CurrentGun.scale.x = 1
				CurrentGun.flip_v = false
				CurrentGun.position.x = CurrentGun.must_position
				if CurrentGun.has_method("MustOffset"):
					CurrentGun.BarrelPoint.position.y = -CurrentGun.must_offset
				CurrentGun.rotation_degrees = rad2deg(get_angle_to(target))
		if target.x - self.position.x  < 0:
				get_node("Sprite").scale.x = -3
				CurrentGun.scale.x = 1
				CurrentGun.flip_v = true
				CurrentGun.position.x = -CurrentGun.must_position
				if CurrentGun.has_method("MustOffset"):
					CurrentGun.BarrelPoint.position.y = CurrentGun.must_offset
				CurrentGun.rotation_degrees = rad2deg(get_angle_to(target))

func _process(delta: float) -> void:
	var move_distance : = speed * delta
	move_along_path(move_distance)
	

func move_along_path(distance : float) -> void:
	var start_point : = position
	for i in range(path.size()):
		var distance_to_next : = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			has_command = true
			var dirto = start_point.direction_to(path[0])
			motion = (dirto * speed).round()
			move_and_slide(motion)
			break
		elif distance < 0.0:
			position = path[0]
			set_process(false)
			has_command = false
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)
	if path.size() == 0:
		has_command = false
	

func set_path(value: PoolVector2Array) -> void:
	path = value
	if value.size() == 0:
		return
	set_process(true)
	

func move_to_pos(move_position, selected_comp):
	if self.id == selected_comp or selected_comp == 5:
		var new_path = Global.navnode.get_simple_path(self.global_position, move_position, false)
		stored_move_pos = new_path
		Global.linenode.points = new_path
		self.path = new_path

#var move_back_here
#func move_back():
#	for i in range(get_slide_count() - 1):
#		var collision = get_slide_collision(i)
#		move_back_here = position - collision.collider.position
#		print(move_back_here)
#		move_to_pos(move_back_here)
#	move_to_pos(stored_move_pos)

func give_gun(gun):
	if gun == "Snyipert":
		gun = Snyipert
	elif gun == "Pistol":
		gun = Pistol
	elif gun == "SMG":
		gun = SMG
	var gun_instance = gun.instance()
	add_child(gun_instance)
	CurrentGun = gun_instance

func _on_EnemyDetector_body_entered(body):
	if body.collision_layer == 1:
		bodyy = body
		print("print")
		casting = true


func _on_EnemyDetector_body_exited(body):
	bodyy = null
	casting = false
