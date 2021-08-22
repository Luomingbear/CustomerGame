extends Object

class_name OptionData

var text: String = ""
var jump: String = ""
var mood: int = 0
var money: int = 0
var hint: String = "" #选项显示的概要文字

func hasContent()-> bool:
	return !text.empty()
