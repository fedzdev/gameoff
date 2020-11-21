extends KinematicBody2D


var Health
var Speed




func _ready():
	get_tree().call_group("Game", "enemies_to_list", self)
