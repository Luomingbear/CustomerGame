# 游戏的世界加载的脚本

extends Node2D

onready var Customer = load("res://Scences/Customer/Customer.tscn")
onready var layer = $CustomerLayer
onready var menuPanel = $UILayer/MenuPanel

var fileManager : FileManager = FileManager.new()
var roleList: Array = []
var nextRoleIndex = 0

var time = 0
var CREATE_CUSTOMER_DELAY = 10 #创建新角色的时间间隔

# Called when the node enters the scene tree for the first time.
func _ready():
	# loadDataFromDisk()
	# 游戏开始就添加一个客户进入场景
	createCustomer(getNextRole())
	
func _process(delta):
	time += delta
	if time > CREATE_CUSTOMER_DELAY:
		if layer.get_child_count() < 1:
			time = 0
			# 每隔CREATE_CUSTOMER_DELAY就创建一个客户到场景里面
			createCustomer(getNextRole())
		
# 获取下一个客户的信息
func getNextRole()-> RoleData:
	# TODO
	menuPanel.numberData # 这个就是当前的金币等数据
	var role = RoleFactory.next()
	var archive = ArchiveData.new()
	# ArchiveManager.saveArchive()
	return role
	

func loadDataFromDisk():
	print("从磁盘加载角色数据")
	var roleDic = fileManager.parseCsvFile("res://game.csv")
	if roleDic != null:
		roleList = roleDic.values()
	nextRoleIndex = 0
	


func createCustomer(roleData: RoleData):
	if roleData == null:
		return
	print("创建角色："+ roleData.get("roleName"))
	var customer : Node2D = Customer.instance()
	layer.add_child(customer)
	customer.global_position = Vector2(-100, 550)
	customer.setData(roleData)
	
