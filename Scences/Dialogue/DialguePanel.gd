extends PanelContainer

onready var animationPlayer:AnimationPlayer = $AnimationPlayer
onready var textLabel = $RichTextLabel
onready var optionPanel = get_parent().find_node("OptionPanel")

var optionData = {}

func _ready():
	optionPanel.connect("make_choose",self,"makeChoose")

# 设置文本内容
func setText(option):
	if option == null:
		return
	visible = true
	optionData = option
	textLabel.bbcode_text = optionData.get("text") 
	animationPlayer.play("DialogueShow")

# 隐藏动画结束
func hideAnimationFinished():
	pass
	
# 显示动画结束
func showAnimationFinished():
	optionPanel.showOptions(optionData)
	
# data {jump,mood}
func makeChoose(selectOptionData):
	animationPlayer.play("DialogueHide")
