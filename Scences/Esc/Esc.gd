# Esc.gd 推出游戏的panle
 
extends Control

func _ready():
	visible = false

func _on_TextureButton_button_up():
	if visible == false:
		return
	print("esc 回到开始页面")
	get_tree().paused = false
	var world = get_tree().root.get_node("World")
	world.queue_free()

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			if visible:
				visible = false
				get_tree().paused = false
			else:
				visible = true
				get_tree().paused = true
