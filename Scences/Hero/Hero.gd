
# 玩家的脚本
extends Node2D

class_name Hero

onready var dialogue = $HeroDialogue


func makeChoose(option:OptionData):
	dialogue.showDialogue(option)
