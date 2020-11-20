extends "res://Scripts/Gun.gd"


var must_position = 2
var must_offset = 7

func _ready():
	position.y = 13

func MustOffset():
	must_offset = 7
