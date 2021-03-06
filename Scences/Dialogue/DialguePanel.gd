extends Control

class_name CustomerDialogue

onready var animationPlayer:AnimationPlayer = $AnimationPlayer
onready var textLabel = $VBoxContainer/PanelContainer/RichTextLabel
onready var worldScene = get_tree().root.get_node("World")
onready var optionPanel :OptionPanel  =worldScene.find_node("OptionPanel") as OptionPanel

var optionData : DialogueData
var textVisiableLength = 0 #可以看见的文字输量
var isTyping = false # 是否正在执行打字机效果

func _ready():
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



# 打字机
func typewriter():
	isTyping = true
	textVisiableLength = 0
	

var time = 0
func _process(delta):
	if isTyping and optionData != null :
		time += delta
		if optionData.text != null && time > 0.1: 
			time = 0
			textVisiableLength += 2
			textLabel.visible_characters = textVisiableLength
		if textLabel.visible_characters >= optionData.text.length():
			isTyping = false
			optionPanel.showOptions(optionData)
	
func _input(event):
	if event.is_pressed() and optionData != null and visible:
		# 点击鼠标的时候可以跳过打字机效果
		if optionData.text != null:
			textLabel.visible_characters = optionData.text.length()
		
		
# 显示动画结束
func showAnimationFinished():
	typewriter()

# 隐藏动画结束
func hideAnimationFinished():
	optionData = null
	


func hideDialogue():
	if not visible:
		return
	animationPlayer.play("DialogueHide")
	print("客户弹窗隐藏")
