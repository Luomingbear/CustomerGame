extends PanelContainer

onready var animationPlayer:AnimationPlayer = $AnimationPlayer
onready var textLabel = $RichTextLabel
onready var optionPanel = get_parent().find_node("OptionPanel")

var optionData = {}
var textVisiableLength = 0 #可以看见的文字输量
var isTyping = false # 是否正在执行打字机效果

func _ready():
	optionPanel.connect("make_choose",self,"makeChoose")
	modulate = 0
	

# 设置文本内容
func setText(option):
	if option == null:
		return
	visible = true
	optionData = option
	textLabel.bbcode_text = optionData.get("text") 
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
		if optionData.get("text") != null && time > 0.1: 
			time = 0
			textVisiableLength += 1
			textLabel.visible_characters = textVisiableLength
		if textLabel.visible_characters >= optionData.get("text").length():
			isTyping = false
			optionPanel.showOptions(optionData)
	
func _input(event):
	if event.is_pressed() and optionData.get("text") != null :
		textLabel.visible_characters = optionData.get("text").length()
	
# 显示动画结束
func showAnimationFinished():
	typewriter()
	
# data {jump,mood}
func makeChoose(selectOptionData):
	animationPlayer.play("DialogueHide")
