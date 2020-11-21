extends CanvasLayer

onready var arrow1 = get_node("HBoxContainer/VBoxContainer/CenterContainer/Arrow")
onready var arrow2 = get_node("HBoxContainer/VBoxContainer2/CenterContainer2/Arrow")
onready var arrow3 = get_node("HBoxContainer/VBoxContainer3/CenterContainer3/Arrow")
onready var arrow4 = get_node("HBoxContainer/VBoxContainer4/CenterContainer4/Arrow")
onready var arrow5 = get_node("HBoxContainer/VBoxContainer5/CenterContainer5/Arrow")

func _ready():
	hide_arrows()

func selected_companion():
	hide_arrows()
	if Global.selected_companion == 1:
		arrow1.show()
	if Global.selected_companion == 2:
		arrow2.show()
	if Global.selected_companion == 3:
		arrow3.show()
	if Global.selected_companion == 4:
		arrow4.show()
	if Global.selected_companion == 5:
		arrow5.show()


func hide_arrows():
	arrow1.hide()
	arrow2.hide()
	arrow3.hide()
	arrow4.hide()
	arrow5.hide()
