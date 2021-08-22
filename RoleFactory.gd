extends Node

class_name RoleFactory

const roleQueue: Array = []

static func init(archive: ArchiveData = null) -> void:
	var roleDictionary = {}
	roleQueue.clear()
	var data = FileManager.parseCsvFile("res://game.csv")
	var currentLevel = 0
	var roleList = []
	if archive != null:
		currentLevel = archive.currentRole.level
		roleList = archive.roleNameArray
	# 按难度分组
	for role in data.values():
		if roleDictionary.has(role.level):
			roleDictionary[role.level].append(role)
		else:
			var array = []
			array.append(role)
			roleDictionary[role.level] = array
	# 难度升序
	var levelArray = roleDictionary.keys()
	levelArray.sort()
	var maxLevel = levelArray[levelArray.size() - 1]
	if currentLevel > maxLevel:
		return
	# 角色入队
	var level = currentLevel
	while level <= maxLevel:
		if not roleDictionary.has(level):
			level = level + 1
			continue
		var tempRoleArray = roleDictionary[level]
		if tempRoleArray == null:
			continue
		for role in tempRoleArray:
			if level == currentLevel and roleList.has(role.roleName):
				continue
			roleQueue.push_back(role)
		level = level + 1
	

static func next() -> RoleData:
	return roleQueue.pop_front()

static func hasNext()-> bool:
	return roleQueue.size() > 0

