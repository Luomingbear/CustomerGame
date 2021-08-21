extends Node

class_name RoleFactory

const roleDictionary: Dictionary = {}

static func init():
	roleDictionary.clear()
	var data = FileManager.parseCsvFile("res://game.csv")
	# 按难度分组
	for role in data.values():
		if roleDictionary.has(role.level):
			roleDictionary[role.level].append(role)
		else:
			var array = []
			array.append(role)
			roleDictionary[role.level] = array
	

static func create() -> RoleData:
	return null
