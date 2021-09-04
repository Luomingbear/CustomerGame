extends Node

class_name RoleFactory

const roleQueue: Array = []

static func init(archive: ArchiveData = null) -> void:
	var roleDictionary = {}
	roleQueue.clear()
	var data = FileManager.parseCsvFile("res://data/game.csv")
	var currentLevel = -1
	var roleList: PoolStringArray = []
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
			level = level + 1
			continue
		for role in tempRoleArray:
			if level == currentLevel and hasRole(role.roleName, roleList):
				continue
			roleQueue.push_back(role)
		level = level + 1
	

static func hasRole(roleName: String, roleList: PoolStringArray) -> bool:
	if roleList == null || roleList.size() == 0:
		return false
	for name in roleList:
		if roleName == name:
			return true
	return false

static func next() -> RoleData:
	return roleQueue.pop_front()

static func hasNext()-> bool:
	return roleQueue.size() > 0

