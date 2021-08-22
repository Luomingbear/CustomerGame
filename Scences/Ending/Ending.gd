extends Control

onready var player = $AnimationPlayer
onready var textRect = $TextureRect

var showIndex = 0

const GOOD_ENDING = [
	"res://Images/Ending/ending_good_1.png",
	"res://Images/Ending/ending_good_2.png",
	"res://Images/Ending/ending_good_3.png"
]

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
	if showIndex == GOOD_ENDING.size() - 1:
		return null
	if event.is_pressed():
		player.play("HideAnimation")


func getTexturePath():
	if showIndex >= GOOD_ENDING.size():
		return null
	if true:
		return GOOD_ENDING[showIndex]
	else:
		return BAD_ENDING[showIndex]

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "HideAnimation":
		if showIndex < GOOD_ENDING.size():
			showIndex += 1
			showTexture(getTexturePath())
			player.play("ShowAnimation")
