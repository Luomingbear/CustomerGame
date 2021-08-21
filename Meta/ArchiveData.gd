extends Object

class_name ArchiveData

# 当前金钱和情绪状态
var state: NumberData = NumberData.new()

# 当前对话人物
var currentRole: RoleData = RoleData.new()

# 当前等级对话过的人物集合
var roleNameArray: PoolStringArray = []
