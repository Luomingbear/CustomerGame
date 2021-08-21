# 角色对话的控制类

extends Node2D

var RETURN_GOODS = "RETURN_GOODS" #同意退货
var NOT_RETURN_GOODS = "NOT_RETURN_GOODS" #不同意退货

var roleData: RoleData = null
var settlementData: SettlementData = SettlementData.new()
var isShowDialogue = false

onready var parent : Node2D = get_parent()
onready var dialoguePanel = get_tree().current_scene.find_node("DialoguePanel")
onready var sprite : Sprite = get_node("../Sprite")
onready var optionPanel = get_tree().current_scene.find_node("OptionPanel")
onready var settlementPanel = get_tree().current_scene.find_node("SettlementPanel")




# 显示对话气泡
func showDialogue(dialogue: DialogueData = null):
	isShowDialogue = true
	settlementData.roleName = roleData.roleName
	settlementData.customerMood = 0
	settlementData.playerMood = 0
	# 优先使用函数传进来的对话信息
	var dialogueItem = dialogue
	if dialogue == null:
		dialogueItem = getDialogueItem()
	#没有找到对话信息
	if dialogueItem == null or \
		(!dialogueItem.needShowOptions() and !dialogueItem.hasOptionNo()):
		hasNoDialogue()
		return
	if dialogueItem.option1 == null and dialogueItem.option2 == null \
	and dialogueItem.option3 == null and dialogueItem.option4 == null \
	and dialogueItem.optionNo == null:
		hasNoDialogue()
		return
	# 设置气泡的位置
	var size = sprite.get_rect().size * sprite.transform.get_scale()
	var p = parent.global_position + Vector2(size.x / 2 , -size.y)
	dialoguePanel.set_global_position(p)
	dialoguePanel.setText(dialogueItem)
	# 更新玩家愤怒值
	settlementData.playerMood += (dialogueItem.mood as int)
	
	
func getDialogueItem()-> DialogueData:
	var dialogueMap = roleData.dialogMap
	if dialogueMap == null:
		return null
	return dialogueMap.get(roleData.dialogueIndex)
	
func hasNoDialogue():
	print("对话结束:"+roleData.roleName+ ",是否需要退货："+ str(roleData.isNeedReturnGoods))
	if roleData.isNeedReturnGoods == true:
		showReturnGoodsDialogue()
		return
	settlementPanel.showSettlement(settlementData)
	settlementData = SettlementData.new()
	
# 显示退货的对话
func showReturnGoodsDialogue():
	roleData.isNeedReturnGoods = false
	var dialogueData = DialogueData.new()
	dialogueData.text = "我要求退货！"
	dialogueData.mood = 0
	dialogueData.option1 = OptionData.new()
	dialogueData.option1.hint = "同意退货"
	dialogueData.option1.text = "同意退货"
	dialogueData.option1.jump = RETURN_GOODS
	dialogueData.option1.mood = -10
	dialogueData.option2.hint = "拒绝退货"
	dialogueData.option2.text = "拒绝退货"
	dialogueData.option2.jump = NOT_RETURN_GOODS
	dialogueData.option2.mood = 10
	dialogueData.optionNo = dialogueData.option2
	showDialogue(dialogueData)

# 接收到需要对话的指令
func _on_MoveController_need_speak_signal(roleName):
	# 如果roleName和自己是相同的，就显示对话框，否则忽略
	if roleData.roleName != roleName:
		return
	if not isShowDialogue:
		showDialogue()

func makeChoose(selectOption: OptionData):
	if not isShowDialogue:
		return
	isShowDialogue = false
	settlementData.customerMood += (selectOption.mood as int) # 更新客户的愤怒值
	#roleData.dialogueIndex = selectOption.jump
	if selectOption.jump == RETURN_GOODS:
		settlementData.hasReturnGood = true
	settlementData.coin += selectOption.money
	#showDialogue()
