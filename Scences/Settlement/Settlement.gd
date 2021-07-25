# 结算弹窗的控制脚本

extends Control

signal need_move_out(roleName)

var EVALUATE_NUM = 10 # 超过这个值就是差评
var BASE_COIN = 10 # 一局可以获得金币的基础值

var roleName = ""

onready var animationPlayer = $Control/AnimationPlayer
onready var numberManger = get_tree().current_scene.find_node("NumberManager")
onready var coinText = $Control/HBoxContainer/CoinText
onready var evaluateTexture = $Control/EvaluateTexture

# 显示结算弹窗,被DialogueController调用
# data:{ customerMood, playerMood, hasReturnGood,roleName }
func showSettlement(data):
	roleName = data["roleName"]
	var isGood = showEvaluate(data["customerMood"])
	showCoin(data["hasReturnGood"],isGood)
	animationPlayer.play("SettlementShow")

func showEvaluate(customerMood):
	print("显示评价动画")
	var texture = ImageTexture.new()
	var image = Image.new()
	
	if customerMood == null or customerMood > EVALUATE_NUM: # 差评
		image.load("res://Images/chaping.png")
		texture.create_from_image(image)
		evaluateTexture.texture = texture
		return false
	else: # 好评
		image.load("res://Images/haoping.png")
		texture.create_from_image(image)
		evaluateTexture.texture = texture
		return true
		
func onSettlementShowAnimationFinished():
	# 弹窗显示之后播放评价的动画
	animationPlayer.play("EvaluateShow")
	
	
# 显示结算金币
func showCoin(isReturn,isGood):
	#结算收入 = （符号）* 基本收入 + 评价收入
	var evaluateCoin = 5
	if not isGood:
		evaluateCoin = -5
	var symbol = 1
	if isReturn == true:
		symbol = -1
	var baseCoin = BASE_COIN * symbol
	var coin = baseCoin + evaluateCoin
	coinText.bbcode_text = str(coin) +"="+ str(baseCoin) +"+"+str(evaluateCoin)


# 点击了确定按钮，需要隐藏弹窗
func _on_OKBtn_button_down():
	animationPlayer.play("SettlementHide")
	# 发送信号，通知客户需要离开场景了
	emit_signal("need_move_out",roleName)