extends KinematicBody2D

var moving = false
var speed : = 200
var path : = PoolVector2Array() setget set_path


func _ready() -> void:
	set_process(false)
	

func _process(delta: float) -> void:
	var move_distance : = speed * delta
	move_along_path(move_distance)
	

func move_along_path(distance : float) -> void:
	var start_point : = position
	for i in range(path.size()):
		var distance_to_next : = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			var dirto = start_point.direction_to(path[0])
			moving = true
			move_and_slide(dirto * speed)
			break
		elif distance < 0.0:
			position = path[0]
			set_process(false)
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)
	

func set_path(value: PoolVector2Array) -> void:
	path = value
	if value.size() == 0:
		return
	set_process(true)
	

func move_to_pos(move_position):
	var new_path = Global.navnode.get_simple_path(self.global_position, move_position)
	Global.linenode.points = new_path
	self.path = new_path
