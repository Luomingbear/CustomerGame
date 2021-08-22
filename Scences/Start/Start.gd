extends Node2D

onready var continueBtn = $Control/ContinueBtn

func _ready():
	RoleFactory.init()
	if ArchiveManager.hasArchive():
		continueBtn.visible = true
	else:
		continueBtn.visible = false

func _on_NewBtn_button_up():
	ArchiveManager.createArchive()
	get_tree().change_scene("res://Scences/World/World.tscn")


func _on_ContinueBtn_button_up():
	ArchiveManager.loadArchive()
	get_tree().change_scene("res://Scences/World/World.tscn")
	
