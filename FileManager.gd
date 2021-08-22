extends Node

class_name FileManager

static func getDialogueData(temp : PoolStringArray,keys) -> DialogueData:
	var dialog = DialogueData.new()
	dialog.text = temp[keys.find("Text")]
	dialog.mood = temp[keys.find("AddRage")]
	
	dialog.option1.text = temp[keys.find("Option1")]
	dialog.option1.jump = temp[keys.find("Option1Jump")]
	dialog.option1.mood = temp[keys.find("Option1Mood")]
	dialog.option1.hint = temp[keys.find("Option1ShowText")]
	dialog.option1.money = temp[keys.find("Option1Money")]
	if not dialog.option1.hasContent():
		dialog.option1 = null
		
	dialog.option2.text = temp[keys.find("Option2")]
	dialog.option2.jump = temp[keys.find("Option2Jump")]
	dialog.option2.mood = temp[keys.find("Option2Mood")]
	dialog.option2.hint = temp[keys.find("Option2ShowText")]
	dialog.option2.money = temp[keys.find("Option2Money")]
	if not dialog.option2.hasContent():
		dialog.option2 = null
	
	dialog.option3.text = temp[keys.find("Option3")]
	dialog.option3.jump = temp[keys.find("Option3Jump")]
	dialog.option3.mood = temp[keys.find("Option3Mood")]
	dialog.option3.hint = temp[keys.find("Option3ShowText")]
	dialog.option3.money = temp[keys.find("Option3Money")]
	if not dialog.option3.hasContent():
		dialog.option3 = null
		
	dialog.option4.text = temp[keys.find("Option4")]
	dialog.option4.jump = temp[keys.find("Option4Jump")]
	dialog.option4.mood = temp[keys.find("Option4Mood")]
	dialog.option4.hint = temp[keys.find("Option4ShowText")]
	dialog.option4.money = temp[keys.find("Option4Money")]
	if not dialog.option4.hasContent():
		dialog.option4 = null
		
	dialog.optionNo.jump = temp[keys.find("NoOptionJump")]
	dialog.optionNo.mood = temp[keys.find("NoOptionMood")]
	dialog.optionNo.money = temp[keys.find("NoOptionMoney")]
	if dialog.optionNo.jump.empty() :
		if dialog.option1 != null:
			dialog.optionNo = dialog.option1
		if dialog.option2 != null:
			dialog.optionNo = dialog.option2
		if dialog.option3 != null:
			dialog.optionNo = dialog.option3
		if dialog.option4 != null:
			dialog.optionNo = dialog.option4
		else:
			dialog.optionNo = null
	return dialog
	

static func parseCsvFile(path: String) -> Dictionary:
	var file = File.new()
	file.open(path, File.READ)
	
	var temp = file.get_csv_line(",")
	if temp.size() <= 1:
		return {}
	
	var keys = []
	for i in temp:
		keys.push_back(i)
	
	var data_list = {}
	temp = file.get_csv_line(",")
	while temp.size() > 1:
		if temp.size() != keys.size():
			break
			
		var roleIdx = keys.find("Role")
		var roleId = temp[roleIdx]
		
		if data_list.has(roleId):
			var role = data_list.get(roleId)
			role.dialogMap[temp[keys.find("TextId")]] = getDialogueData(temp,keys)
			
		else:
			var role = RoleData.new()
			role.roleName = roleId
			role.isNeedReturnGoods = temp[keys.find("IsReturnGoods")].to_lower() == "true"
			role.dialogueIndex = temp[keys.find("TextId")]
			role.level = temp[keys.find("Level")]
			
			var dialogMap = {}
			dialogMap[temp[keys.find("TextId")]] = getDialogueData(temp,keys)
			role.dialogMap = dialogMap
			
			data_list[roleId] = role
			
		# 读取下一行数据
		temp = file.get_csv_line(",")
		
	file.close()
	return data_list

## 文件是否存在
## @path 文件路径
static func exists_file(path: String) -> bool:
	var file = File.new()
	var exists = file.file_exists(path)
	file.close()
	return exists


## 保存数据
## @path 文件路径
## @data 数据
static func save_data(path: String, data) -> void:
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_var(data)
	file.close()


## 加载数据
## @path 文件路径
## @return 返回数据
static func load_data(path: String):
	var file = File.new()
	file.open(path, File.READ)
	var object = file.get_var()
	file.close()
	if object == null:
		return null
	else:
		return instance_from_id(object.get_object_id())


static func remove_file(path: String) -> bool:
	var dir = Directory.new()
	return dir.remove(path)
