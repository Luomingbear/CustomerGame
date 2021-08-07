# 选项的控制脚本

extends Control

signal make_choose(optionData)

onready var option1 : CanvasItem = $Option1
onready var option2 : CanvasItem = $Option2
onready var option3 : CanvasItem = $Option3
onready var option4 : CanvasItem = $Option4
onready var timeText = $TimeText
onready var animatonPlayer = $AnimationPlayer

var selectOption = null
const DEAFULT_WAIT_TIME = 10 # 选项等待时间，超过这个时间会强制选择【未选择】选项
var time = DEAFULT_WAIT_TIME
var isNeedShowTime = true # 是否需要显示倒计时，退货不显示倒计时？
#[
#	{
#"1004" : {
#				"text":"喂！你在听我说话吗",
#				"option1":{
#					"text":"在的，亲",
#					"jump":"1001",
#					"mood":1
#				},
#				"option2":{
#					"text":"不在滚",
#					"jump":"1003",
#					"mood":2
#				},
#				"option3":null,
#				"option4":null,
#				"optionNo":{
#					"text":"",
#					"jump":"1003",
#					"mood":10
#				}
#			}
#			}
#]

func _ready():
	# 默认不可见
	modulate = 0

func showOptionItem(option : CanvasItem, data):
	if data == null:
		option.visible = false
	else:
		option.visible = true
		option.setOptionData(data)

# 显示选项
func showOptions(options):
	if visible == true:
		return
	print("显示选项")
	showOptionItem(option1,options.get("option1"))
	showOptionItem(option2,options.get("option2"))
	showOptionItem(option3,options.get("option3"))
	showOptionItem(option4,options.get("option4"))
	selectOption = options.get("optionNo") #默认选择[未选择]选项
	animatonPlayer.play("OptionsShow")
	visible = true
		
		
func _process(delta):
	if visible == true and isNeedShowTime:
		timeText.bbcode_text = str(int(time)) + "秒"
		time -= delta
		if time <= 0: #选择超时了，强制选择【未选择选项】
			makeChoose(selectOption)
			time = DEAFULT_WAIT_TIME
		
	

# 动画结束的回调
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "OptionsHide":
		emit_signal("make_choose", selectOption)


func makeChoose(optionData):
	selectOption = optionData
	animatonPlayer.play("OptionsHide")
	visible = false
	

func _on_Option1_make_choose_item(optionItemData):
	makeChoose(optionItemData)


func _on_Option2_make_choose_item(optionItemData):
	makeChoose(optionItemData)


func _on_Option3_make_choose_item(optionItemData):
	makeChoose(optionItemData)


func _on_Option4_make_choose_item(optionItemData):
	makeChoose(optionItemData)
