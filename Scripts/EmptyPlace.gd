extends Node2D



func _on_Button_pressed():
#	get_tree().call_group("testgame","moveplauyer",global_position)
	get_node("PopupMenu").popup()
	get_node("PopupMenu").set_position(get_global_mouse_position())


func _on_PopupMenu_index_pressed(index):
	get_tree().call_group("testgame", "button_pressed", get_node("PopupMenu").get_item_text(index), self.name, get_parent().get_index(), get_parent().name)
