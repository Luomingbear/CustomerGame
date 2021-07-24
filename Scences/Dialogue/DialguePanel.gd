extends PanelContainer


onready var animationPlayer:AnimationPlayer = $AnimationPlayer
onready var textLabel = $RichTextLabel

var textContent = ""

# 设置文本内容
func setText(text):
	textContent = text

func _ready():
	animationPlayer.play("DialogueShow")
	textLabel.bbcode_text = textContent 
