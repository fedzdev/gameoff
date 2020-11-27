extends KinematicBody2D



var test 
var speed : = 200
var path : = PoolVector2Array() setget set_path
var stop_moving = false
var stored_path
var motion = Vector2()

var target


func _ready():
	get_tree().call_group("Game", "enemies_to_list", self)
#	set_process(false)


func _process(delta: float) -> void:
	var move_distance : = speed * delta
	move_along_path(move_distance)
	raycast()


func move_along_path(distance : float) -> void:
	var start_point : = position
	for i in range(path.size()):
		var distance_to_next : = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			var dirto = start_point.direction_to(path[0])
			if not stop_moving:
				motion = dirto * speed
				move_and_slide(motion)
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
	
func move_to_pos(glopos):
	var new_path = Global.navnode.get_simple_path(self.global_position, glopos, false)
	Global.linenode.points = new_path
	self.path = new_path

func raycast():
	if target != null:
		get_node("RayCast2D").set_cast_to((target.global_position - self.global_position))
		if get_node("RayCast2D").is_colliding():
			var kolli = get_node("RayCast2D").get_collider() 

func _on_Area2D_body_entered(body):
	if body.collision_layer == 1 or body.collision_layer == 2:
		target = body
