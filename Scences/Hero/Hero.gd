
# 玩家的脚本
extends Node2D

class_name Hero

signal hero_make_choose(optionData)


onready var dialogue = $HeroDialogue


func makeChoose(option: OptionData):
	if option == null or option.text.empty():
		# 这个是超时自动选择
		afterDialogueHide(option)
	else:
	    dialogue.showDialogue(option)
	

func afterDialogueHide(option: OptionData):
	emit_signal("hero_make_choose", option)
