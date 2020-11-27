extends Control

const Pistol = preload("res://Scenes/Pistol.tscn")
const SMG = preload("res://Scenes/SMG.tscn")
const Sniper = preload("res://Scenes/Snyipert.tscn")

var current_gun 

var gun_in_viewport


onready var Upgrade2Name = get_node("HBoxContainer/RightSide/SecondGrade/CenterContainer/HBoxContainer/VBoxContainer/UpgradeName")
onready var Upgrade2Desc = get_node("HBoxContainer/RightSide/SecondGrade/CenterContainer/HBoxContainer/VBoxContainer/UpgradeDescription")
onready var Upgrade1Name = get_node("HBoxContainer/RightSide/FirstGrade/CenterContainer/HBoxContainer/VBoxContainer/UpgradeName")
onready var Upgrade1Desc = get_node("HBoxContainer/RightSide/FirstGrade/CenterContainer/HBoxContainer/VBoxContainer/UpgradeDescription")
# ///// Local info about the upgrades, only listen to signal to show
# gun has to have var to turn show on signal received
var SMG_grade_1 = {"name":"Widebarrel","desc":"Widens the barrel to allow more bullets to be shot at the same time, at the cost of accuracy","Cost":50}

func _ready():
	gun_in_viewport = get_node("HBoxContainer/ViewportContainer/Viewport").get_child(0)
	for button in get_tree().get_nodes_in_group("PurchaseButtons"):
		button.connect("pressed", self, "_some_button_pressed", [button])
		button.connect("mouse_entered", self, "_button_hovered", [button])
		button.connect("mouse_exited", self, "_button_hovered_exit", [button])

func loadgun(gun):
	clear_names()
	if gun == "SMG":
		pass
		Upgrade1Name.text = SMG_grade_1.name
		Upgrade1Desc.text = SMG_grade_1.desc
		Global.Cost_for_grade = SMG_grade_1.Cost
#		gun.show.upgrade1 = true
	if gun == "Pistol":
		pass
	if gun == "Snyipert":
		pass

func clear_names():
	Upgrade1Desc.text = "desc"
	Upgrade2Desc.text = "desc"

#func insert_info_on_grades(gun):
#	if gun == "SMG":
#

func _some_button_pressed(button):
	button.hide()

func _button_hovered(button):
	if current_gun == "Pistol":
		print(button)
	if current_gun == "SMG":
		print(button.name)
		if button.name == "PurchaseButton1":
			gun_in_viewport.animation = "New Anim"
	if current_gun == "Sniper":
		pass
#	get_node("HBoxContainer/ViewportContainer/Viewport/SMG").animation = "New Anim"
#	cost = button upgrade
	pass

func _button_hovered_exit(button):
	if current_gun == "Pistol":
		print(button)
	if current_gun == "SMG":
		gun_in_viewport.animation = "default"


func ChangeGun(gun):
	var gun_inst
	if gun == "Pistol":
		gun_inst = Pistol.instance()
		current_gun = "Pistol"
	if gun == "SMG":
		gun_inst = SMG.instance()
		current_gun = "SMG"
	if gun == "Sniper":
		gun_inst = Sniper.instance()
		gun_inst.offsetx = 0
		gun_inst.positiony = 0
		current_gun = "Sniper"
	get_node("HBoxContainer/ViewportContainer/Viewport").get_child(0).queue_free()
	gun_inst.centered = false
#	gun_inst.offsetx = 0
#	gun_inst.positiony = 0
	get_node("HBoxContainer/ViewportContainer/Viewport").add_child(gun_inst)
	gun_in_viewport = get_node("HBoxContainer/ViewportContainer/Viewport").get_child(0)
	print(gun_in_viewport)
