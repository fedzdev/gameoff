extends CanvasLayer


const menu_scene = preload("res://Scenes/MenuScene.tscn")
const research_scene = preload("res://Scenes/ResearchScene.tscn")


func _on_MenuButton_pressed():
	var menu_inst = menu_scene.instance()
	add_child(menu_inst)


func _on_ResearchButton_pressed():
	var research_inst = research_scene.instance()
	add_child(research_inst)
