extends Node2D



func _on_NewBtn_button_up():
	ArchiveManager.createArchive()
	get_tree().change_scene("res://Scences/World.tscn")


func _on_ContinueBtn_button_up():
	ArchiveManager.loadArchive()	
	get_tree().change_scene("res://Scences/World.tscn")
	
