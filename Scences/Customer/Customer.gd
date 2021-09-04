# 客户管理类

extends KinematicBody2D

class_name Customer

onready var moveController = $MoveController 
onready var dialogueContronller = $DialogueController 
onready var sprite = $Sprite

# 设置角色和对话信息
func setData(data: RoleData):
	moveController.roleData = data
	dialogueContronller.roleData = data
	if data.roleName.empty():
		print("角色的图片")
		return
	var path = "res://Images/Customer/"+data.roleName+".png"
	var res = load(path)
	if res != null:
		var texture = ImageTexture.new()
		var image = Image.new()
		image.load(path)
		texture.create_from_image(image)
		sprite.texture = texture
