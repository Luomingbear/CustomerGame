extends PanelContainer

onready var animationPlayer:AnimationPlayer = $AnimationPlayer
onready var textLabel = $RichTextLabel
onready var optionPanel : OptionPanel = get_parent().find_node("OptionPanel") as OptionPanel
onready var timer = $Timer

const DEFAULT_OPTION_SHOW_TIME = 3 # 没有选项的时候，客户说话的间隔时间
var optionData : DialogueData
var textVisiableLength = 0 #可以看见的文字输量
var isTyping = false # 是否正在执行打字机效果

func _ready():
	optionPanel.connect("make_choose", self, "makeChoose")
	modulate = 0
	

# 设置文本内容
func setText(option: DialogueData):
	if option == null:
		return
	visible = true
	optionData = option
	textLabel.bbcode_text = optionData.text
	textLabel.visible_characters = 0
	animationPlayer.play("DialogueShow")

# 隐藏动画结束
func hideAnimationFinished():
	pass
	

# 打字机
func typewriter():
	isTyping = true
	textVisiableLength = 0
	

var time = 0
func _process(delta):
	if isTyping:
		time += delta
		if optionData.text != null && time > 0.1: 
			time = 0
			textVisiableLength += 1
			textLabel.visible_characters = textVisiableLength
		if textLabel.visible_characters >= optionData.text.length():
			isTyping = false
			if optionData.needShowOptions():
				optionPanel.showOptions(optionData)
			else:
				timer.start(DEFAULT_OPTION_SHOW_TIME)
	
func _input(event):
	if event.is_pressed():
		if optionData.text != null:
			if textLabel.visible_characters >= optionData.text.length():
				optionPanel.chooseNoOption()
			textLabel.visible_characters = optionData.text.length()
		
		
# 显示动画结束
func showAnimationFinished():
	typewriter()
	
# data {jump,mood}
func makeChoose(selectOptionData):
	animationPlayer.play("DialogueHide")


func _on_Timer_timeout():
	if not optionData.needShowOptions():
		optionPanel.chooseNoOption()
