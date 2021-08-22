#菜单界面的控制脚本

extends Node2D

class_name MenuPanel

var numberData : NumberData = NumberData.new()
onready var coinText = $CoinText
onready var moodText = $MoodText
var gameOver = preload("res://Scences/Menu/GameOver.tscn").instance()


func _ready():
	numberData.coin = 500

func updateNumbear(updateNumber: NumberData):
	print("update number, coin:"+str(numberData.coin)+", mood:"+str(numberData.mood))
	numberData.mood += updateNumber.mood
	numberData.coin += updateNumber.coin
	checkCoin(numberData.coin)


func checkCoin(coin: int):
	if coin < 0 :
		print("游戏结束：破产了")
		add_child(gameOver)
	
func checkMood(mood: int):
	if mood> 100 :
		print("游戏结束：气疯了")
	

func _process(delta):
	coinText.bbcode_text = str(numberData.coin)
	moodText.text = "剧情分："+str(numberData.mood)


func _on_BackBtn_pressed():
	print("esc 回到开始页面")
	var world = get_tree().root.get_node("World")
	world.queue_free()
