extends CanvasLayer


const menu_scene = preload("res://Scenes/MenuScene.tscn")


func _on_MenuButton_pressed():
	var menu_inst = menu_scene.instance()
	add_child(menu_inst)
