extends PanelContainer


signal make_choose_item(optionItemData)

var optionItemData = {}

onready var button = $Button


func setOptionData(data):
	optionItemData = data
	button.text = data.get("text")
	

# 按钮点击
func _on_Button_button_down():
	print("你选择了:"+optionItemData.get("text"))
	emit_signal("make_choose_item", optionItemData)
