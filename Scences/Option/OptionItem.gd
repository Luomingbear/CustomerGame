extends PanelContainer


signal make_choose_item(optionItemData)

var optionItemData :OptionData = null

onready var button = $Button


func setOptionData(data: OptionData):
	optionItemData = data
	button.text = data.get("text")
	
	
func _input(event):
	if event is InputEventMouseButton:
		var clickIn = get_global_rect().has_point(event.global_position)
		if event.is_pressed() and visible and clickIn:
			fit_child_in_rect(button,Rect2(0,0,250,50))
			_on_Button_button_down()

func isEventInRect()-> bool:
	return false

# 按钮点击
func _on_Button_button_down():
	if optionItemData != null:
		print("跳转："+optionItemData.jump +", 你选择了:"+optionItemData.text)
		emit_signal("make_choose_item", optionItemData)
