extends Control

const Pistol = preload("res://Scenes/Pistol.tscn")
const SMG = preload("res://Scenes/SMG.tscn")
const Sniper = preload("res://Scenes/Snyipert.tscn")

func _ready():
#	loadgun()
#	load gun and based on if load upgrades and names from global
	pass
	for button in get_tree().get_nodes_in_group("PurchaseButtons"):
		button.connect("pressed", self, "_some_button_pressed", [button])
		button.connect("mouse_entered", self, "_button_hovered", [button])


func _some_button_pressed(button):
	button.hide()

func _button_hovered(button):
	get_node("HBoxContainer/ViewportContainer/Viewport/SMG").animation = "New Anim"

func ChangeGun(gun):
	var gun_inst
	if gun == "Pistol":
		gun_inst = Pistol.instance()
	if gun == "SMG":
		gun_inst = SMG.instance()
	if gun == "Sniper":
		gun_inst = Sniper.instance()
		gun_inst.offsetx = 0
		gun_inst.positiony = 0
	get_node("HBoxContainer/ViewportContainer/Viewport").get_child(0).queue_free()
	gun_inst.centered = false
#	gun_inst.offsetx = 0
#	gun_inst.positiony = 0
	get_node("HBoxContainer/ViewportContainer/Viewport").add_child(gun_inst)
