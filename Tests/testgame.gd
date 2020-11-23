extends Node2D



# RANDOMIZER OSIO
const lab = preload("res://Scenes/Lab.tscn")
const refuge = preload("res://Scenes/Refuge.tscn")
const warehouse = preload("res://Scenes/Warehouse.tscn")
const market = preload("res://Scenes/Market.tscn")
const ruins = preload("res://Scenes/Ruins.tscn")
onready var circles = get_node("Circles")
var lab_amount = 0
var refuge_amount = 0
var warehouse_amount = 0
var market_amount = 0
var list_of_spawns = [1,2,3,4]
var child_to_spawn_at = [0,1,2,3,4,5,6,7,8,9]
# RANDOMIZER OSIO

onready var convoy = get_node("Convoy")

func _ready():
	convoy.position = get_node("Circles/place0").position
	randomize()
	make_random_amounts()
	var filler = circles.get_children().size() - list_of_spawns.size()
	while filler != 0:
		list_of_spawns.append(5)
		filler -= 1
	random_spawner()

onready var tween = get_node("Tween")

func moveplauyer(pos):
	tween.interpolate_property(get_node("Convoy"), "position", convoy.position, pos, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#	convoy.position = lerp(convoy.position, pos, 2)
	tween.start()
	flip_day()
#	convoy.position = pos

onready var map = get_node("Autumn")
func flip_day():
	if map.modulate == Color(1, 1, 1):
		tween.interpolate_property(map, "modulate", Color(1, 1, 1) , Color(0, 1, 1) , 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	else:
		tween.interpolate_property(map, "modulate", Color(0, 1, 1) , Color(1, 1, 1) , 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
func random_spawner():
	while list_of_spawns.size() != 0:
#		spawns_amount -= 1
		child_to_spawn_at.shuffle()
		var popper
		list_of_spawns.shuffle()
		popper = list_of_spawns.pop_front()
		if popper == 1:
			var LabInstance = lab.instance()
			circles.get_child(child_to_spawn_at.pop_front()).add_child(LabInstance)
		if popper == 2:
			var RefugeInstance = refuge.instance()
			circles.get_child(child_to_spawn_at.pop_front()).add_child(RefugeInstance)
		if popper == 3:
			var WarehouseInstance = warehouse.instance()
			circles.get_child(child_to_spawn_at.pop_front()).add_child(WarehouseInstance)
		if popper == 4:
			var MarketInstance = market.instance()
			circles.get_child(child_to_spawn_at.pop_front()).add_child(MarketInstance)
		if popper == 5:
			var RuinsInstance = ruins.instance()
			circles.get_child(child_to_spawn_at.pop_front()).add_child(RuinsInstance)
		elif popper == null:
			print("nope")
func make_random_amounts():
	var roller
	var amountleft = 3
	while amountleft != 0:
		amountleft -= 1
		roller = randi() % 4 + 1
		list_of_spawns.append(roller)
# RANDOMIZER OSIO



func button_pressed(button, type, place, placewn):
	print(button," ", type ," ", place)
	if button == "Move":
		if Global.current_location.has(place):
			moveplauyer(circles.get_child(place).position)
			Global.current_location = Global.get(placewn)
			print(Global.current_location)
	


