extends Node

class_name ArchiveManager

static func createArchive() -> ArchiveData:
	FileManager.remove_file("user://archive.save")
	return ArchiveData.new()

static func loadArchive() -> ArchiveData:
	return FileManager.load_data("user://archive.save")

static func saveArchive(state: NumberData, role: RoleData):
	var oldArchive = loadArchive()
	var roleList = []
	if oldArchive == null:
		roleList = []
	elif oldArchive.currentRole.level == role.level:
		roleList = oldArchive.roleNameArray
		roleList.append(role.roleName)
	elif oldArchive.currentRole.level != role.level:
		roleList = []
	var archive = ArchiveData.new()
	archive.state = state
	archive.currentRole.roleName = role.roleName
	archive.currentRole.level = role.level
	archive.roleNameArray = roleList
	FileManager.save_data("user://archive.save", archive)
	

static func hasArchive() -> bool:
	return FileManager.exists_file("user://archive.save")
