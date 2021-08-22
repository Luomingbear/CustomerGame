extends Control

onready var player = $AnimationPlayer
onready var textRect = $TextureRect

var showIndex = 0
 
const BAD_ENDING = [
	"res://Images/Ending/ending_bad_1.png",
	"res://Images/Ending/ending_bad_2.png",
	"res://Images/Ending/ending_bad_3.png"
]


func _ready():
	showTexture(getTexturePath())
	pass

func showTexture(path):
	if path == null:
		return
	var texture = ImageTexture.new()
	var image = Image.new()
	image.load(path)
	texture.create_from_image(image)
	textRect.texture = texture

func _gui_input(event):
	if event.is_pressed():
		if showIndex == BAD_ENDING.size() - 1:
			get_tree().change_scene("res://Scences/Start/Start.tscn")
			return null
		player.play("HideAnimation")


func getTexturePath():
	if showIndex >= BAD_ENDING.size():
		return null
	return BAD_ENDING[showIndex]

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "HideAnimation":
		if showIndex < BAD_ENDING.size():
			showIndex += 1
			showTexture(getTexturePath())
			player.play("ShowAnimation")
