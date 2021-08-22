# 客户管理类

extends KinematicBody2D

class_name Customer

onready var moveController = $MoveController 
onready var dialogueContronller = $DialogueConroller 
onready var sprite = $Sprite

# 设置角色和对话信息
func setData(data: RoleData):
	moveController.roleData = data
	dialogueContronller.roleData = data
	var texture = ImageTexture.new()
	var image = Image.new()
	image.load("res://Images/Customer/"+data.roleName+".png")
	texture.create_from_image(image)
	sprite.texture = texture
