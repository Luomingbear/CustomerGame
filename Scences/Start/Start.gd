extends Node2D

onready var continueBtn = $Control/ContinueBtn
onready var player = $AudioStreamPlayer2D
var world = preload("res://Scences/World/World.tscn").instance()

func _ready():
	player.play(3) #从第3秒开始播放
	if ArchiveManager.hasArchive():
		continueBtn.visible = true
	else:
		continueBtn.visible = false

func _on_NewBtn_button_up():
	ArchiveManager.createArchive()
	RoleFactory.init()
	get_tree().get_root().add_child(world)


func _on_ContinueBtn_button_up():
	var archive = ArchiveManager.loadArchive()
	RoleFactory.init(archive)
	get_tree().change_scene("res://Scences/World/World.tscn")
	
