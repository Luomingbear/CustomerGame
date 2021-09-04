# 游戏的世界加载的脚本

extends Node2D

onready var Customer = load("res://Scences/Customer/Customer.tscn")
onready var layer = $CustomerLayer
onready var menuPanel :MenuPanel = $UILayer/MenuPanel as MenuPanel

var roleList: Array = []
var nextRoleIndex = 0
var changeScene = false

var time = 0
var CREATE_CUSTOMER_DELAY = 10 #创建新角色的时间间隔

# Called when the node enters the scene tree for the first time.
func _ready():
	# loadDataFromDisk()
	# 游戏开始就添加一个客户进入场景
	createCustomer(getNextRole())
	
func _process(delta):
	time += delta
	if !changeScene and  time > CREATE_CUSTOMER_DELAY:
		if layer.get_child_count() < 1:
			time = 0
			# 每隔CREATE_CUSTOMER_DELAY就创建一个客户到场景里面
			var role = getNextRole()
			if role != null:
				createCustomer(role)
		
# 获取下一个客户的信息
func getNextRole() -> RoleData:
	return RoleFactory.next()
	

func loadDataFromDisk():
	print("从磁盘加载角色数据")
	var roleDic = FileManager.parseCsvFile("res://game.csv")
	if roleDic != null:
		roleList = roleDic.values()
	nextRoleIndex = 0
	


func createCustomer(roleData: RoleData):
	if roleData == null:
		return
	print("创建角色："+ roleData.get("roleName"))
	var customer : Node2D = Customer.instance()
	layer.add_child(customer)
	customer.global_position = Vector2(-100, 600)
	customer.setData(roleData)
		
		
