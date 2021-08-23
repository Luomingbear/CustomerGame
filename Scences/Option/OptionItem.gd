extends Button


signal make_choose_item(optionItemData)

var optionItemData :OptionData = null

func setOptionData(data: OptionData):
	optionItemData = data
	if not data.hint.empty():
		text = data.hint
	elif not data.text.empty():
		text = data.text
	else:
		visible = false


func _on_OptionItem_button_up():
	if optionItemData != null:
		print("跳转："+optionItemData.jump +", 你选择了:"+optionItemData.hint)
		emit_signal("make_choose_item", optionItemData)
