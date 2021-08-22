#菜单界面的控制脚本

extends Node2D

class_name MenuPanel

var numberData : NumberData = NumberData.new()
onready var coinText = $CoinHBox/CoinText
onready var moodText = $MoodHBox/MoodText


func updateNumbear(updateNumber: NumberData):
	print("update number, coin:"+str(numberData.coin)+", mood:"+str(numberData.mood))
	numberData.mood += updateNumber.mood
	numberData.coin += updateNumber.coin


func checkCoin(coin: int):
	if coin < 0 :
		print("游戏结束：破产了")
	
func checkMood(mood: int):
	if mood> 100 :
		print("游戏结束：气疯了")
	

func _process(delta):
	coinText.bbcode_text = str(numberData.coin)
	moodText.bbcode_text = str(numberData.mood)


func _on_BackBtn_pressed():
	print("esc 回到开始页面")
	get_tree().paused = false
	var world = get_tree().root.get_node("World")
	world.queue_free()
