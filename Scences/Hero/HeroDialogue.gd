
# 玩家对话框的逻辑
extends Node2D


onready var textLabel = $VBoxContainer/PanelContainer/RichTextLabel
onready var animationPlayer = $AnimationPlayer
onready var timer = $Timer
var textVisiableLength = 0 #可以看见的文字输量
var isTyping = false # 是否正在执行打字机效果
var time = 0
var optionData: OptionData = null

func _ready():
	textLabel.bbcode_text = ""
	textLabel.visible_characters = textVisiableLength
	visible = false
	modulate = 0

# 显示对话框
func showDialogue(option: OptionData):
	if option == null or option.text.empty():
		return
	optionData = option
	visible = true
	textVisiableLength = 0
	textLabel.visible_characters = textVisiableLength	
	textLabel.bbcode_text = optionData.text
	animationPlayer.play("HeroDialogShow")
	print("播放显示主角对话动画")
	
	
func _process(delta):
	if not isTyping:
		return
	if time >= 0.1:
		textVisiableLength += 2
		textLabel.visible_characters = textVisiableLength
		time = 0
		return
	else:
		time += delta
	# 可显示的文字数量超过了时机文本数量，则说明文字打字结束了，这时执行timer倒计时
	if  textVisiableLength > len(textLabel.bbcode_text):
		isTyping = false
		print("主角打字机结束")
		timer.start(1)
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "HeroDialogShow":
		isTyping = true
		print("主角对话显示动画结束")
		
	elif anim_name == "HeroDialogHide":
		var hero = get_parent() as Hero
		hero.afterDialogueHide(optionData)
		optionData = null


func _on_Timer_timeout():
	animationPlayer.play("HeroDialogHide")
