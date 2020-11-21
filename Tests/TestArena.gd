extends Node2D

const CompanionScene = preload("res://Scenes/Companion.tscn")

onready var nav_2d : Navigation2D = get_node("Navigation2D")
onready var line_2d : Line2D = get_node("Line2D")
onready var dumpy : KinematicBody2D = get_node("dumpy")

func _ready():
	Global.navnode = get_node("Navigation2D")
	Global.linenode = get_node("Line2D")
	spawn_companions()
	print(Global.enemies_in_current_encounter)

func enemies_to_list(enemy_to_add):
	Global.enemies_in_current_encounter.append(enemy_to_add)

func spawn_companions():
	var companion_name
	var companion_gun
	var companion_pos
	var companion_id
#	var companion_sprite
	for companion in Global.companions:
		if companion == 1:
			companion_name = Global.companion_1.name
			companion_gun = Global.companion_1.gun
			companion_pos = Global.companion_1.spawn
			companion_id = Global.companion_1.id
		if companion == 2:
			companion_name = Global.companion_2.name
			companion_gun = Global.companion_2.gun
			companion_pos = Global.companion_2.spawn
			companion_id = Global.companion_2.id
		if companion == 3:
			companion_name = Global.companion_3.name
			companion_gun = Global.companion_3.gun
			companion_pos = Global.companion_3.spawn
			companion_id = Global.companion_3.id
		if companion == 4:
			companion_name = Global.companion_4.name
			companion_gun = Global.companion_4.gun
			companion_pos = Global.companion_4.spawn
			companion_id = Global.companion_4.id
			
		var companion_instance = CompanionScene.instance()
		companion_instance.name_label = companion_name
		companion_instance.gun = companion_gun
		companion_instance.position = companion_pos
		companion_instance.id = companion_id
		add_child(companion_instance)

