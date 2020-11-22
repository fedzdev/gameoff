extends "res://Scripts/EnemyCharacter.gd"


var Health
var Speed

# Called when the node enters the scene tree for the first time.
func _ready():
	Health = 100


func receive_damage(damage):
	Health -= damage
	get_node("TextureProgress").value = Health
	if Health <= 0:
		ded()


func ded():
	Global.enemies_in_current_encounter.pop_front()
	queue_free()
