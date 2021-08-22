# 选项的控制脚本

extends Control

class_name  OptionPanel

onready var option1 : CanvasItem = $Option1
onready var option2 : CanvasItem = $Option2
onready var option3 : CanvasItem = $Option3
onready var option4 : CanvasItem = $Option4
onready var timeText = $TimeText
onready var animatonPlayer = $AnimationPlayer
onready var worldScene = get_tree().root.get_node("World")
onready var hero : Hero = worldScene.find_node("Hero") as Hero


var selectOption: OptionData = null
const DEFAULT_WAIT_TIME = 15 # 选项等待时间，超过这个时间会强制选择【未选择】选项
var time = DEFAULT_WAIT_TIME
var isNeedShowTime = true # 是否需要显示倒计时，退货不显示倒计时？

func _ready():
	# 默认不可见
	modulate = 0

func showOptionItem(option: CanvasItem, data: OptionData):
	if data == null:
		option.visible = false
	else:
		option.visible = true
		option.setOptionData(data)

# 显示选项
func showOptions(options: DialogueData):
	if visible == true or options == null:
		return
	print("显示选项")
	showOptionItem(option1, options.option1)
	showOptionItem(option2, options.option2)
	showOptionItem(option3, options.option3)
	showOptionItem(option4, options.option4)
	selectOption = options.optionNo #默认选择[未选择]选项
	if options.needShowOptions():
		animatonPlayer.play("OptionsShow")
		visible = true
	
func chooseNoOption():
	makeChoose(selectOption)
	
		
func _process(delta):
	if visible == true and isNeedShowTime:
		timeText.bbcode_text = str(int(time)) + "S"
		time -= delta
		if time <= 0: #选择超时了，强制选择【未选择选项】
			makeChoose(selectOption)
			

# 动画结束的回调
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "OptionsHide":
		hero.makeChoose(selectOption)
		selectOption = null


func makeChoose(optionData: OptionData):
	selectOption = optionData
	animatonPlayer.play("OptionsHide")
	visible = false
	time = DEFAULT_WAIT_TIME
	

func _on_Option1_make_choose_item(optionItemData):
	makeChoose(optionItemData)


func _on_Option2_make_choose_item(optionItemData):
	makeChoose(optionItemData)


func _on_Option3_make_choose_item(optionItemData):
	makeChoose(optionItemData)


func _on_Option4_make_choose_item(optionItemData):
	makeChoose(optionItemData)
