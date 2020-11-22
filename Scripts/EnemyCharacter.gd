extends KinematicBody2D





func _ready():
	get_tree().call_group("Game", "enemies_to_list", self)



