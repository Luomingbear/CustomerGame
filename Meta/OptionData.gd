extends Object

class_name OptionData

var text: String = ""
var jump: String = ""
var mood: int = 0
var money: int = 0

func hasContent()-> bool:
	return text != null or text.length() > 0
