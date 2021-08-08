extends PanelContainer


signal make_choose_item(optionItemData)

var optionItemData :OptionData = null

onready var button = $Button


func setOptionData(data: OptionData):
	optionItemData = data
	button.text = data.get("text")
	
	
func _input(event):
	if event.is_pressed():
		_on_Button_button_down()

# 按钮点击
func _on_Button_button_down():
	if optionItemData != null:
		print("你选择了:"+optionItemData.text)
		emit_signal("make_choose_item", optionItemData)
