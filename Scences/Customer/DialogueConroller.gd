# 角色对话的控制类

extends Node2D

var RETURN_GOODS = "RETURN_GOODS" #同意退货
var NOT_RETURN_GOODS = "NOT_RETURN_GOODS" #不同意退货

var roleData={}
var isShowDialogue = false
var hasReturnGood = false
var customerMood = 0
var playerMood = 0


onready var parent : Node2D = get_parent()
onready var dialoguePanel = get_tree().current_scene.find_node("DialoguePanel")
onready var sprite : Sprite = get_node("../Sprite")
onready var optionPanel = get_tree().current_scene.find_node("OptionPanel")
onready var settlementPanel = get_tree().current_scene.find_node("SettlementPanel")



func _ready():
	optionPanel.connect("make_choose",self,"makeChoose")


# 显示对话气泡
func showDialogue(dialogue = null):
	isShowDialogue = true
	# 优先使用函数传进来的对话信息
	var dialogueItem = dialogue
	if dialogue == null:
		dialogueItem = getDialogueItem()
	#没有找到对话信息
	if dialogueItem == null :
		hasNoDialogue()
		return
	if dialogueItem["option1"] == null and dialogueItem["option2"] == null \
	and dialogueItem["option3"] == null and dialogueItem["option4"] == null \
	and dialogueItem["optionNo"] == null:
		hasNoDialogue()
		return
	# 设置气泡的位置
	var size = sprite.get_rect().size * sprite.transform.get_scale()
	var p = parent.global_position + Vector2(size.x / 2 , -size.y)
	dialoguePanel.set_global_position(p)
	dialoguePanel.setText(dialogueItem)
	# 更新玩家愤怒值
	playerMood += (dialogueItem["mood"] as int)
	
	
func getDialogueItem():
	var dialogueMap = roleData.get("dialogMap")
	if dialogueMap == null:
		return
	return dialogueMap.get(roleData.get("dialogueIndex"))
	
func hasNoDialogue():
	print("对话结束:"+roleData["roleName"]+ ",是否需要退货："+ str(roleData["isNeedReturnGoods"]))
	if roleData["isNeedReturnGoods"] == true:
		showReturnGoodsDialogue()
		return
	var data = {
		"customerMood": customerMood,
		"playerMood": playerMood,
		"hasReturnGood": hasReturnGood,
		"roleName": roleData["roleName"]
	}
	settlementPanel.showSettlement(data)
	
func showReturnGoodsDialogue():
	roleData["isNeedReturnGoods"] = false
	var dialogueData = {
		    "text": "我要求退货！",
			"mood": 0,
			"option1": {
				"text": "同意退货",
				"jump": RETURN_GOODS,
				"mood": -10
				},
			"option2": {
				"text": "拒绝退货",
				"jump": NOT_RETURN_GOODS,
				"mood": 10
				}
		}
	showDialogue(dialogueData)

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
	isShowDialogue = false
	customerMood += (selectOption["mood"] as int) # 更新客户的愤怒值
	roleData["dialogueIndex"] = selectOption["jump"]
	if selectOption["jump"] == RETURN_GOODS:
		hasReturnGood = true
	showDialogue()
