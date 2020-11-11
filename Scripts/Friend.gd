extends KinematicBody2D

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


func _ready() -> void:
	set_process(false)
	

func _physics_process(delta):
	move_back()
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
#	print(stuck, " ", velocity)


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
	

func move_to_pos(move_position):
	var new_path = Global.navnode.get_simple_path(self.global_position, move_position, false)
	stored_move_pos = move_position
	Global.linenode.points = new_path
	self.path = new_path

var move_back_here
func move_back():
	for i in range(get_slide_count() - 1):
		var collision = get_slide_collision(i)
		move_back_here = position - collision.collider.position
		print(move_back_here)
		move_to_pos(move_back_here)
