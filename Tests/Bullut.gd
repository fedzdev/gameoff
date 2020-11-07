extends Area2D

var speed = 1000
var life_time = 3
	
func _physics_process(delta):
	position += transform.x * speed * delta
	
#	apply_impulse(Vector2(),Vector2(speed,0).rotated(rotation))
	

#func seppoku():
#	yield(get_tree().create_timer(life_time), "timeout")
#	queue_free()



func _on_Bullut_body_entered(body):
	if body.name == "dumpy":
		get_node("AudioStreamPlayer2D").play()
		self.hide()


func _on_AudioStreamPlayer2D_finished():
	queue_free()
