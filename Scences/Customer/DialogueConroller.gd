# 角色对话的控制类

extends Node2D

var roleData={}
var isShowDialogue = false
onready var parent : RigidBody2D = get_parent()
onready var DialoguePanel = load("res://Scences/Dialogue/DialguePanel.tscn")


func showDialogue(roleName):
	print("开始说话吧:"+str(roleName))
	pass

# 接收到需要对话的指令
func _on_MoveController_need_speak_signal(roleName):
	# 如果roleName和自己是相同的，就显示对话框，否则忽略
	if roleData.get("roleName") != roleName:
		return
	if not isShowDialogue:
		showDialogue(roleName)
	
	
