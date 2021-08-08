#菜单界面的控制脚本

extends Control

class_name MenuPanel

var numberData : NumberData = NumberData.new()
onready var coinText = $CoinHBox/CoinText
onready var moodText = $MoodHBox/MoodText


func updateNumbear(updateNumber: NumberData):
	print("update number, coin:"+str(numberData.coin)+", mood:"+str(numberData.mood))
	numberData.mood += updateNumber.mood
	numberData.coin += updateNumber.coin
	

func checkCoin(coin: int):
	pass
	
func checkMood(mood: int):
	pass
	

func _process(delta):
	coinText.bbcode_text = str(numberData.coin)
	moodText.bbcode_text = str(numberData.mood)
