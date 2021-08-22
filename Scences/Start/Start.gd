extends Node2D

onready var continueBtn = $Control/ContinueBtn
onready var player = $AudioStreamPlayer2D

func _ready():
	player.play(3) #从第3秒开始播放
	if false:
		continueBtn.visible = true
	else:
		continueBtn.visible = false

func _on_NewBtn_button_up():
	if hasWorld():
		return
	ArchiveManager.createArchive()
	RoleFactory.init()
	var world = preload("res://Scences/World/World.tscn").instance()
	get_tree().get_root().add_child(world)


func _on_ContinueBtn_button_up():
	if hasWorld():
		return
	var archive = ArchiveManager.loadArchive()
	RoleFactory.init(archive)
	var world = preload("res://Scences/World/World.tscn").instance()
	get_tree().get_root().add_child(world)
	
func hasWorld()->bool:
	var world =  get_tree().get_root().get_node("World")
	return world != null
