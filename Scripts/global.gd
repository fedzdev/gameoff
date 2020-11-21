extends Node

var max_speed = 200
var navnode
var linenode
var selected_companion
var companions = [1,2,3,4]

var enemies_in_current_encounter = []

var companion_1 = {"name":"Steve","gun":"SMG","spawn":Vector2(0,0),"id":1}
var companion_2 = {"name":"apina","gun":"Pistol","spawn":Vector2(5,0),"id":2}
var companion_3 = {"name":"a","gun":"Pistol","spawn":Vector2(10,0),"id":3}
var companion_4 = {"name":"mynamejeff","gun":"Snyipert","spawn":Vector2(15,0),"id":4}

# Location access
var place0 = [1]
var place1 = [0,2,3]
var place2 = [1,3]
var place3 = [1,2]


var gun_equip = [1,2,3]

var current_location = place0

