extends Node2D

onready var nav_2d : Navigation2D = get_node("Navigation2D")
onready var line_2d : Line2D = get_node("Line2D")
onready var dumpy : KinematicBody2D = get_node("dumpy")

func _ready():
	Global.navnode = get_node("Navigation2D")
	Global.linenode = get_node("Line2D")
	Global.spawn_companions()
