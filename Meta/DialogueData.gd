extends Object

class_name DialogueData

var text: String = ""
var mood: int = 0
var option1: OptionData = OptionData.new()
var option2: OptionData = OptionData.new()
var option3: OptionData = OptionData.new()
var option4: OptionData = OptionData.new()
var optionNo: OptionData = OptionData.new()

func needShowOptions()-> bool:
	return option1!=null or option2!=null or option3!=null or option4!=null

func hasOptionNo()-> bool:
	return optionNo != null and !optionNo.jump.empty()
