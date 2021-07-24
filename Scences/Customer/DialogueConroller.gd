# 角色对话的控制类

extends Node2D

var roleData={}
var isShowDialogue = false
onready var parent : Node2D = get_parent()
onready var dialoguePanel = get_tree().current_scene.find_node("DialoguePanel")
onready var sprite : Sprite = get_node("../Sprite")
onready var optionPanel = get_tree().current_scene.find_node("OptionPanel")

func _ready():
	optionPanel.connect("make_choose",self,"makeChoose")


# 显示对话气泡
func showDialogue():
	isShowDialogue = true
	var size = sprite.get_rect().size * sprite.transform.get_scale()
	var p = parent.global_position + Vector2(size.x / 2 , -size.y)
	dialoguePanel.set_global_position(p)
	var dialogueMap = roleData.get("dialogMap")
	if dialogueMap == null:
		return
	var dialogueItem = dialogueMap.get(roleData.get("dialogueIndex"))
	if dialogueItem == null:
		return
	dialoguePanel.setText(dialogueItem)
	

# 接收到需要对话的指令
func _on_MoveController_need_speak_signal(roleName):
	# 如果roleName和自己是相同的，就显示对话框，否则忽略
	if roleData.get("roleName") != roleName:
		return
	if not isShowDialogue:
		showDialogue()
		

func makeChoose(selectOption):
	if not isShowDialogue:
		return
	roleData["dialogueIndex"] = selectOption["jump"]
	isShowDialogue = false
	showDialogue()
	
