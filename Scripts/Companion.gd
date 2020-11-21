extends "res://Scripts/Friend.gd"


var name_label = "?"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("NameLabel").text = name_label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("NameLabel").text = name_label
