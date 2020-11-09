extends RigidBody2D

var speed = 700
const explosion = preload("res://Assets/Explosion.wav")

func _ready():
	get_node("AudioStreamPlayer2D").play()
	apply_impulse(Vector2(),Vector2(speed,0).rotated(rotation))
	


func _on_AudioStreamPlayer2D_finished():
	if get_node("AudioStreamPlayer2D").stream == explosion:
		queue_free()


func _on_Timer_timeout():
	get_node("AudioStreamPlayer2D").stream = explosion
	get_node("AudioStreamPlayer2D").play()
