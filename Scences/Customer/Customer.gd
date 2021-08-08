# 客户管理类

extends KinematicBody2D


onready var moveController = $MoveController 
onready var dialogueContronller = $DialogueConroller 

# 设置角色和对话信息
func setData(data: RoleData):
	moveController.roleData = data
	dialogueContronller.roleData = data
