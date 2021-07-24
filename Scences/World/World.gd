# 游戏的世界加载的脚本

extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func loadDataFromDisk():
	print("从磁盘加载角色数据")
	pass


func createCustomer(roleData):
	print("创建角色："+ roleData.get("roleName"))
	pass
