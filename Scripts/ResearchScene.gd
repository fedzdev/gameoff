extends "res://Scripts/ParentScene.gd"

onready var label = get_node("Panel/CenterContainer/HBoxContainer/Label")

var num_scroll = 0

func _ready():
	update_gun_text()


func _on_RightButton_pressed():
	num_scroll += 1
	if num_scroll > 2:
		num_scroll = 0
	update_gun_text()

func _on_LeftButton_pressed():
	num_scroll -= 1
	if num_scroll < 0:
		num_scroll = 2
	update_gun_text()


func update_gun_text():
	if num_scroll == 0:
		label.text = "Pistol"
		get_tree().call_group("TemplateGUI", "ChangeGun", "Pistol")
	if num_scroll == 1:
		label.text = "SMG"
		get_tree().call_group("TemplateGUI", "ChangeGun", "SMG")
	if num_scroll == 2:
		label.text = "Sniper"
		get_tree().call_group("TemplateGUI", "ChangeGun", "Sniper")
