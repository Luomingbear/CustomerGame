extends Control

class_name GameOver

onready var button = $Button


func _on_Button_pressed():
	if visible == false:
		return
	var world = get_tree().root.get_node("World")
	world.queue_free()
