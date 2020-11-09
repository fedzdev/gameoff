extends KinematicBody2D



var speed : = 200
var path : = PoolVector2Array() setget set_path
var stop_moving = false

func _ready() -> void:
	set_process(false)
	
func test():
	pass

func _process(delta: float) -> void:
	var move_distance : = speed * delta
	move_along_path(move_distance)
	
func _physics_process(delta):
	if move_out_of_way:
		move_and_slide(-playerdir * speed)

func move_along_path(distance : float) -> void:
	var start_point : = position
	for i in range(path.size()):
		var distance_to_next : = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
#			start_point.direction_to()
			var dirto = start_point.direction_to(path[0])
			if not stop_moving:
				move_and_slide(dirto * speed)
#			move_and_slide(start_point.direction_to(distance / distance_to_next))
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
	

func move_dumpy(glopos):
	if stop_moving or not move_out_of_way:
		var new_path = Global.navnode.get_simple_path(self.global_position, glopos)
		Global.linenode.points = new_path
		self.path = new_path









func _on_Area2D_body_entered(body):
	if body.name == "Player":
		move_dumpy(self.position)
		stop_moving = true



func _on_Area2D_body_exited(body):
	if body.name == "Player":
		stop_moving = false


var playerdir
var move_out_of_way = false

func _on_OutOfWayCollider_body_entered(body):
	if body.name == "Player":
		playerdir = position.direction_to(body.position)
		move_dumpy(self.position)
		move_out_of_way = true


func _on_OutOfWayCollider_body_exited(body):
	if body.name == "Player":
		move_out_of_way = false
