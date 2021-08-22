extends Node

class_name ArchiveManager

static func createArchive() -> ArchiveData:
	return ArchiveData.new()

static func loadArchive() -> ArchiveData:
	return FileManager.load_data("user://archive.save")

static func saveArchive(state: NumberData, role: RoleData, roleList: PoolStringArray):
	var archive = ArchiveData.new()
	archive.state = state
	archive.currentRole.roleName = role.roleName
	archive.currentRole.level = role.level
	archive.roleNameArray = roleList
	FileManager.save_data("user://archive.save", archive)
	

static func hasArchive() -> bool:
	return FileManager.exists_file("user://archive.save")
