extends Node

var max_speed = 200
var navnode
var linenode
var selected_companion
var companions = [1]


var place0 = [1]
var place1 = [0,2,3]
var place2 = [1,3]
var place3 = [1,2]


var gun_equip = [1,2,3]

var current_location = place0

func spawn_companions():
	for companion in companions:
		print("prööff")
